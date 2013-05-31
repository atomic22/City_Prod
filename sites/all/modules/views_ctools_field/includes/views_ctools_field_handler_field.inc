<?php
// $Id

/**
 * @file
 * Contains the 'ctools_field' markup field handler.
 */

/**
 * Field handler to display custom markup text.
 */
class views_ctools_field_handler_field extends views_handler_field {

  function query() {
    // If this is a global content with no context, rewrite so as to select a null column
    if ($this->table == 'ctools_field_global') {
      $this->field_alias = 'ctools_field_markup_' . $this->position;

      if (!empty($this->options['value']) && $value = $this->options['value']) {
        $this->query->add_field('', "'$value'", $this->field_alias);
      }
    }
    else {
      parent::query();
    }
  }

  function option_definition() {
    $options = parent::option_definition();
    $options['views_ctools_field'] = array('default' => array());
    return $options;
  }

  function options_form(&$form, &$form_state) {
    ctools_include('plugins');
    ctools_include('context');
    ctools_include('content');

    parent::options_form($form, $form_state);

    $plugin_id = $this->options['field'];
    $plugin = ctools_get_plugins('ctools', 'content_types', $this->options['field'], $plugin_id);

    if (empty($this->options['views_ctools_field'])) {
        $defaults = $plugin['defaults'];
        $this->options['views_ctools_field'] = $defaults;
    }

    $edit_form_callback = $plugin['module'] . '_' . $plugin_id . '_content_type_edit_form';
    if (function_exists($edit_form_callback)) {
      $form['views_ctools_field'] = array(
        '#type' => 'fieldset',
        '#title' => t('@field field settings', array('@field' => $plugin['title'])),
        '#collapsible' => TRUE,
        '#collapsed' => FALSE,
        '#tree' => TRUE,
      );
      $sub_form_state = array('conf' => $this->getCtoolsContentTypeConf());
      $plugin_form = $edit_form_callback($form['views_ctools_field'], $sub_form_state);
      $form['views_ctools_field'] =  $plugin_form;
    }
    return $form;
  }

  function render($values) {
    ctools_include('plugins');
    ctools_include('context');
    ctools_include('content');

    $plugin_id = $this->options['field'];
    $plugin = ctools_get_plugins('ctools', 'content_types', $this->options['field'], $plugin_id);

    $conf = $this->getCtoolsContentTypeConf();

    if ($entity_id = $values->{$this->field_alias}) {
      $type = views_ctools_field_context_config(substr($this->table, 13));

      $entity = $type['load']($entity_id);
      $entity_context = ctools_context_create($type['id'], $entity);
      $entity_context->identifier = t('This @id', array('@id' => $type['id']));
      $entity_context->keyword = $type['id'];

      $context = array($type['id'] => $entity_context);
      $conf['context'] = $type['id'];

      $ctools_content = ctools_content_render($plugin_id, $plugin_id, $conf, array(), array(), $context);
    }
    else {
      $context = array();
      $ctools_content = ctools_content_render($plugin_id, $plugin_id, $conf);
    }

    return $ctools_content->content;
  }

  function getCtoolsContentTypeConf() {
    if (empty($this->options['views_ctools_field'])) {
      return array();
    }
    ctools_include('plugins');
    ctools_include('context');
    ctools_include('content');

    $plugin_id = $this->options['field'];
    $plugin = ctools_get_plugins('ctools', 'content_types', $this->options['field'], $plugin_id);

    $edit_submit_callback = $plugin['module'] . '_' . $plugin_id . '_content_type_edit_form_submit';
    // If there is no callback, pass back the raw form values
    if (!function_exists($edit_submit_callback)) {
      return $this->options['views_ctools_field'];
    }

    $form = array();
    $form_state = array(
      'conf' => array(),
      'values' => $this->options['views_ctools_field'],
      'plugin' => $plugin,
    );
    $edit_submit_callback($form, $form_state);

    return $form_state['conf'];
  }

  function options_submit(&$form, &$form_state) {
    $options_new = &$form_state['values']['options'];
    $this->options['views_ctools_field'] = $options_new;
  }
}
