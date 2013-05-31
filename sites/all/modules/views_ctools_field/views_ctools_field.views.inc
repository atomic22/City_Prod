<?php
// $Id

/**
 * Implements hook_views_handlers().
 *
 * @return array
 */
function views_ctools_field_views_handlers() {
  return array(
    'info' => array(
      'path' => drupal_get_path('module', 'views_ctools_field') . '/includes',
    ),
    'handlers' => array(
      'views_ctools_field_handler_field' => array(
        'parent' => 'views_handler_field',
      ),
    ),
  );
}

/**
 * Implements hook_views_data().
 *
 * @return array
 */
function views_ctools_field_views_data() {
  ctools_include('plugins');
  ctools_include('context');

  $data = array();

  // Psuedo table for global content type that have no required context
  $data['ctools_field_global']['table']['group'] = t('Chaos Tools Field');
  $data['ctools_field_global']['table']['join'] = array(
    '#global' => array(),
  );

  // Psudo table for content-types that have a context
  foreach (views_ctools_field_context_config() as $id => $type) {
    $data['ctools_field_' . $id]['table']['group'] = $type['title'];
    $data['ctools_field_' . $id]['table']['base'] = array(
      'field' => $type['key'],
      'title' => $type['title'],
      'help' => t('ctools content with a @id context', array('@id' => $id)),
    );
    $data['ctools_field_' . $id]['table']['join'] = array(
      $type['table'] => array(
        'left_table' => $type['table'],
        'left_field' => $type['key'],
        'field' => $type['key'],
        'table' => $type['table'],
      ),
    );
  }

  // For each plugin, define a 'column' on a psudo-table
  $plugins = ctools_get_plugins('ctools', 'content_types');
  foreach ($plugins as $plugin_id => $plugin) {
    // Determine the psuedo-table based on context
    if (isset($plugin['required context'])) {
      $type = views_ctools_field_context_config($plugin['required context']->keywords);
      if (!$type) {
        continue;
      }
      $psuedo_table = 'ctools_field_' . $type['id'];
      $real_field = $type['key'];
    }
    else {
      $psuedo_table = 'ctools_field_global';
      $real_field = NULL;
    }

    $data[$psuedo_table][$plugin_id] = array(
      'title' => $plugin['title'],
      'real field' => $real_field,
      'field' => array(
        'handler' => 'views_ctools_field_handler_field',
        'click sortable' => FALSE,
      ),
    );
    if (isset($plugin['description'])) {
      $data[$psuedo_table][$plugin_id]['help'] = $plugin['description'];
    }
  }

  return $data;
}
