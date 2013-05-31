<?php

/**
 * @file
 * Settings forms alteration for taxonomy_menu_trails.
 *
 * @author Dmitriy.trt      <http://drupal.org/user/329125>
 */

/**
 * Callback for _taxonomy_menu_trails_sort_by_weight().
 */
function _taxonomy_menu_trails_sort_by_weight_helper($a, $b) {
  $vars = &drupal_static('_taxonomy_menu_trails_sort_by_weight');
  $a_info = field_info_instance($vars['entity_type'], $a, $vars['bundle']);
  $b_info = field_info_instance($vars['entity_type'], $b, $vars['bundle']);
  return $a_info['widget']['weight'] - $b_info['widget']['weight'];
}

/**
 * Sorts instances array by its weight fetched from field info API.
 *
 * @param array $instances
 * @param string $entity_type
 * @param string $bundle
 */
function _taxonomy_menu_trails_sort_by_weight(&$instances, $entity_type, $bundle) {
  $static = &drupal_static(__FUNCTION__, array());
  $static = compact('entity_type', 'bundle');
  // make sure fields info is collated already to workaround warning on 
  // field creation
  _field_info_collate_fields();
  uksort($instances, '_taxonomy_menu_trails_sort_by_weight_helper');
  $static = array();
}

/**
 * Add Taxonomy Menu Trails settings to bundle form.
 *
 * @param array $form
 * @param string $entity_type
 * @param mixed $bundle
 */
function _taxonomy_menu_trails_alter_bundle_form(&$form, $entity_type, $bundle) {
  $bundle = field_extract_bundle($entity_type, $bundle);
  list($settings) = _taxonomy_menu_trails_get_settings($entity_type, $bundle);
  
  $type_info = entity_get_info($entity_type);

  $all_instances = field_info_instances($entity_type, $bundle);
  $instances_options = array();
  foreach ($all_instances as $instance) {
    $field_info = field_info_field($instance['field_name']);
    if ($field_info['type'] == 'taxonomy_term_reference') {
      $instances_options[$instance['field_name']] = $instance['label'];
    }
  }
  
  // Looks like there is no way to get default entity path without actual
  // enity instance, so we use switch here.
  switch ($entity_type) {
    case 'node':
      $default_paths = t('paths "node/[nid]" and "node/[nid]/*"');
      break;

    // TODO: Support for other entity types.
  }

  if (!empty($instances_options)) {
    _taxonomy_menu_trails_sort_by_weight($instances_options, $entity_type, $bundle);

    $subform = array(
      '#tmt_entity' => $entity_type,
      '#tmt_bundle' => $bundle,
      'instances' => array(
        '#type' => 'checkboxes',
        '#title' => t('Term references for setting active trail'),
        '#options' => $instances_options,
        '#default_value' => $settings['instances'],
      ),
      'selection_method' => array(
        // TODO convert it to 'value' if there is one term reference with
        // Number of values == 1
        '#type' => 'select',
        '#title' => t("Term selection method"),
        '#description' => t("This option defines how module chooses term for processing:<ul><li><b>First/Last</b> - select first/last term with menu item.</li><li><b>Deepest in menu</b> - use term with deepest menu item.</ul>"),
        '#default_value' => $settings['selection_method'],
        '#options' => array(
          'first' => t('First term'),
          'last' => t('Last term'),
          'deepest-in-menu' => t('Deepest in menu'),
        ),
        /*TODO depends on http://drupal.org/node/1057748
        '#states' => array(
          'invisible' => array(
            'input[name^="taxonomy_menu_trails[instances]"]' => array('checked' => FALSE),
          ),
        ),*/
      ),
      'only_without_menu' => array(
        '#type' => 'checkbox',
        '#title' => t("Only if @entity doesn't have enabled menu item", array('@entity' => drupal_strtolower($type_info['label']))),
        '#description' => t("This option also applies to pages detected with path pattern. You should think twice before turning this option on, because it'll reduce site performance a bit."),
        '#default_value' => $settings['only_without_menu'],
        /*TODO also depends on http://drupal.org/node/1057748
        '#states' => array(
          'invisible' => array(
            'input[name^="taxonomy_menu_trails[instances]"]' => array('checked' => FALSE),
          ),
        ),*/
      ),
      'tm_integration' => module_exists('taxonomy_menu') ? array(
        '#type' => 'checkbox',
        '#title' => t("Get term's path from Taxonomy Menu modules"),
        '#description' => t("If you've configured non-default paths for menu items in the Taxonomy Menu, module will use them. Turning this option on will reduce site performance a bit too."),
        '#default_value' => $settings['tm_integration'],
        /*TODO also depends on http://drupal.org/node/1057748
        '#states' => array(
          'invisible' => array(
            'input[name^="taxonomy_menu_trails[instances]"]' => array('checked' => FALSE),
          ),
        ),*/
      ) : array(
        '#type' => 'value',
        '#value' => $settings['tm_integration'],
      ),
      'paths_ui' => array(
        '#title' => t('Additional path patterns for @entity detection', array('@entity' => drupal_strtolower($type_info['label']))),
        '#type' => 'textarea',
        '#description' => t('By default module is trying to detect @entity at !default_paths. Here you can specify additional paths to detect @entity and set menu trails for it. The "*" character matches any non-empty string, the "%" character matches non-empty string without "/" character. Available placeholders are:<ul><li>[@id] - @entity ID</li><li>[@title] - @entity title</li></ul>Each additional pattern will be tested on each page load, so use it only if you really need this feature.', array(
          '@entity' => drupal_strtolower($type_info['label']),
          '!default_paths' => $default_paths,
          '@id' => $type_info['entity keys']['id'],
          '@title' => $type_info['entity keys']['label'],
        )),
        '#default_value' => $settings['paths_ui'],
      ),
    );

    // Add validation function.
    $form['#validate'][] = 'taxonomy_menu_trails_bundle_form_validate';

    // Add our submit function before default handler because
    // we don't want our elements to be saved as persistent variables
    // by default node type submit handler
    array_unshift($form['#submit'], 'taxonomy_menu_trails_bundle_form_submit');
  }
  else {
    $subform = array(
      'notice' => array(
        '#markup' => '<p>' . t('Add some "Term reference" fields to use Taxonomy Menu Trails.') . '</p>'
      ),
    );
  }
  
  $form['taxonomy_menu_trails'] = array(
    '#tree' => TRUE,
    '#type' => 'fieldset',
    '#title' => t('Taxonomy menu trails'),
  ) + $subform;
}

/**
 * Validation function for bundle form.
 */
function taxonomy_menu_trails_bundle_form_validate($form, &$state) {
  $paths_ui = trim($state['values']['taxonomy_menu_trails']['paths_ui']);
  if (!empty($paths_ui)) {
    $entity_type = $form['taxonomy_menu_trails']['#tmt_entity'];
    list($id, $title) = _taxonomy_menu_trails_get_entity_type_keys($entity_type);
    $patterns = preg_split('/\R/', $paths_ui, -1, PREG_SPLIT_NO_EMPTY);
    foreach ($patterns as $pattern) {
      if (preg_match_all('/\[(' . preg_quote($title) . '|' . preg_quote($id) . ')\]/u', $pattern, $matches) != 1) {
        form_set_error('taxonomy_menu_trails][paths_ui', t('Each path pattern must have one [@id] or [@title] placeholder.', array(
          '@id' => $id,
          '@title' => $title,
        )));
        break;
      }
    }
  }
}

/**
 * Converts entity path patterns from user input into regular expressions.
 * 
 * @param string $paths_ui
 * @param string $entity_type
 * @return array
 *   Two-dimension array of patterns grouped by placeholder type
 *   (id or title entity key):
 *   - first level keys are placeholders
 *   - second level has numerical keys.
 */
function _taxonomy_menu_trails_compile_path_patterns($paths_ui, $entity_type) {
  $path_exprs = array();
  if (!empty($paths_ui)) {
    list($id, $title) = _taxonomy_menu_trails_get_entity_type_keys($entity_type);
    $patterns = preg_split('/\R/', $paths_ui, -1, PREG_SPLIT_NO_EMPTY);
    foreach ($patterns as $pattern) {
      if (preg_match('/^(.*)\[(' . preg_quote($id) . '|' . preg_quote($title) . ')\](.*)$/u', $pattern, $matches)) {
        // Escape parts before and after id/title placeholders. Also, convert
        // "*" and "%" special characters into regular expressions.
        foreach (array(1,3) as $index) {
          $matches[$index] = str_replace(array('\\*', '%'), array('.+', '[^\/]+'), preg_quote($matches[$index], '/'));
        }

        // Convert id/title placeholder into subpattern.
        $placeholder = $matches[2];
        switch ($placeholder) {
          case $id:
            $matches[2] = '(\d+)';
            break;

          case $title:
            $matches[2] = '([^\/]+)';
            break;
        }

        // Construct final regular expression and store them indexed by
        // placeholder type.
        $path_exprs[$placeholder][] = '/^' . implode('', array_slice($matches, 1)) . '$/ui';
      }
    }
  }
  return $path_exprs;
}

/**
 * Submit handler for bundle form.
 */
function taxonomy_menu_trails_bundle_form_submit($form, &$state) {
  $entity_type = $form['taxonomy_menu_trails']['#tmt_entity'];
  $old_bundle = $form['taxonomy_menu_trails']['#tmt_bundle'];

  // Determine new bundle.
  switch ($entity_type) {
    case 'node':
      $new_bundle = $state['values']['type'];
      break;

    // TODO: Support for other entity types.

    default:
      return;
  }
  
  // Convert path patterns into regular expressions and save bundle regexps
  // into regular expressions index containing.
  $paths_ui = trim($state['values']['taxonomy_menu_trails']['paths_ui']);
  $bundle_regexps = _taxonomy_menu_trails_compile_path_patterns($paths_ui, $entity_type);
  $all_regexps = variable_get('taxonomy_menu_trails__path_regexps', array());
  unset($all_regexps[$entity_type][$old_bundle]);
  $all_regexps[$entity_type][$new_bundle] = $bundle_regexps;
  variable_set('taxonomy_menu_trails__path_regexps', $all_regexps);

  // Process bundle name change and save our settings.
  $new_var_name = 'taxonomy_menu_trails_' . $entity_type . '_' . $new_bundle;
  list($settings, $old_var_name, $var_exists) = _taxonomy_menu_trails_get_settings($entity_type, $old_bundle);
  $values = !empty($state['values']['taxonomy_menu_trails']) ? $state['values']['taxonomy_menu_trails'] : array();
  $settings = array_merge($settings, $values);
  $settings['instances'] = array_filter($settings['instances']);
  if (!empty($settings['instances'])) {
    // Sort by instances weight again, because it could be changed since form generation.
    // We're using old_bundle because renaming did not processed yet (it will be in original handler).
    _taxonomy_menu_trails_sort_by_weight($settings['instances'], $entity_type, $old_bundle);
    
    variable_set($new_var_name, $settings);
  }
  if ($var_exists && (empty($settings['instances']) || $old_bundle !== $new_bundle)) {
    variable_del($old_var_name);
  }
  unset($state['values']['taxonomy_menu_trails']);
}

/**
 * Add Taxonomy Menu Trails settings to field instance form.
 */
function _taxonomy_menu_trails_alter_field_form(&$form) {
  list($settings) = _taxonomy_menu_trails_get_settings($form['#instance']['entity_type'], $form['#instance']['bundle'], FALSE);

  $form['instance']['taxonomy_menu_trails'] = array(
    '#tree' => FALSE,
    '#type' => 'fieldset',
    '#title' => t('Taxonomy menu trails'),
    'taxonomy_menu_trails_enabled' => array(
      '#type' => 'checkbox',
      '#title' => t('Use this term reference to set active trail'),
      '#default_value' => !empty($settings['instances'][$form['#field']['field_name']]),
    ),
  );
  $form['#submit'][] = 'taxonomy_menu_trails_field_form_submit';
}

/**
 * Submit handler for field instance form.
 */
function taxonomy_menu_trails_field_form_submit($form, &$state) {
  $entity_type = $form['#instance']['entity_type'];
  $bundle = $form['#instance']['bundle'];
  list($settings, $var_name, $var_exists) = _taxonomy_menu_trails_get_settings($entity_type, $bundle);
  $field_name = $form['#field']['field_name'];
  if (!empty($state['values']['taxonomy_menu_trails_enabled'])) {
    $settings['instances'][$field_name] = $field_name;
    _taxonomy_menu_trails_sort_by_weight($settings['instances'], $entity_type, $bundle);
  }
  else {
    unset($settings['instances'][$field_name]);
  }
  if (!empty($settings['instances'])) {
    variable_set($var_name, $settings);
  }
  elseif ($var_exists) {
    variable_del($var_name);
  }
}

/**
 * Deletes instance from settings and saves them.
 */
function _taxonomy_menu_trails_delete_instance($instance) {
  list($settings, $var_name, $var_exists) = _taxonomy_menu_trails_get_settings($instance['entity_type'], $instance['bundle'], FALSE);
  if ($var_exists) {
    unset($settings['instances'][$instance['field_name']]);
    if (!empty($settings['instances'])) {
      variable_set($var_name, $settings);
    }
    else {
      variable_del($var_name);
    }
    //TODO replace with specific cache entries deleting
    menu_cache_clear_all();
  }
}

/**
 * Add custom submit handler to fields overview form.
 */
function _taxonomy_menu_trails_alter_overview_form(&$form) {
  $form['#submit'][] = 'taxonomy_menu_trails_overview_form_submit';
}

/**
 * Submit handler for fields overview form. Sorts instances and saves bundle settings.
 */
function taxonomy_menu_trails_overview_form_submit($form, &$state) {
  $entity_type = $form['#entity_type'];
  $bundle = $form['#bundle'];
  list($settings, $var_name, $var_exists) = _taxonomy_menu_trails_get_settings($entity_type, $bundle, FALSE);
  if ($var_exists) {
    _taxonomy_menu_trails_sort_by_weight($settings['instances'], $entity_type, $bundle);
    variable_set($var_name, $settings);
    //TODO replace with specific cache entries deleting
    menu_cache_clear_all();
  }
}
