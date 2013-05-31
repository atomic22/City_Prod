<?php $justifications = array('left', 'center', 'right'); ?>
<?php $currencies = array(
				'AUD',
				'CAD',
				'EUR',
				'GBP',
				'JPY',
				'USD',
				'NZD',
				'CHF',
				'HKD',
				'SGD',
				'SEK',
				'DKK',
				'PLN',
				'NOK',
				'HUF',
				'CZK',
				'ILS',
				'MXN',
				'MYR',
				'BRL',
				'PHP',
				'TWD',
				'THB',
				'TRY'
			  ); ?>
<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span>
		</div>
	<?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="language-<?php echo $module_row; ?>" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
            <table class="form">
			<tr>
			  <td><?php echo $entry_modulename; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][modulename]; ?>]" value="<?php echo isset($module['modulename']) ? $module['modulename'] : ''; ?>" size="100" /></td>
            </tr>
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="donations_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
			<tr>
			  <td><?php echo $entry_justification; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][justification]">
			  <?php foreach ($justifications as $justify) { ?>
				<?php if ($module['justification'] == $justify) { ?>
                <option value="<?php echo $justify; ?>" selected="selected"><?php echo $justify; ?></option>
                <?php } else { ?>
				<option value="<?php echo $justify; ?>"><?php echo $justify; ?></option>
                <?php } ?>
			  <?php } ?>
			  </select></td>
			</tr>
            </table>
          </div>
          <?php } ?>
          <table class="form">
			<tr>
			  <td><?php echo $entry_name; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][name]; ?>]" value="<?php echo isset($module['name']) ? $module['name'] : ''; ?>" size="100" /></td>
            </tr>
			<tr>
			  <td><?php echo $entry_donatenumber; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][donatenumber]" value="<?php echo isset($module['donatenumber']) ? $module['donatenumber'] : ''; ?>" size="10" /></td>
            </tr>
			<tr>
			  <td><?php echo $entry_email; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][email]" value="<?php echo isset($module['email']) ? $module['email'] : ''; ?>" size="100" /></td>
            </tr>
			<tr>
			  <td><?php echo $entry_amount; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][amount]" value="<?php echo isset($module['amount']) ? $module['amount'] : ''; ?>" size="10" /></td>
            </tr>			
			<tr>
			  <td><?php echo $entry_currency; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][currency]">
			  <?php foreach ($currencies as $currency) { ?>
				<?php if ($module['currency'] == $currency) { ?>
                <option value="<?php echo $currency; ?>" selected="selected"><?php echo $currency; ?></option>
                <?php } else { ?>
				<option value="<?php echo $currency; ?>"><?php echo $currency; ?></option>
                <?php } ?>
			  <?php } ?>
			  </select></td>
			</tr>
			<tr>
              <td><?php echo $entry_buttontype; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][buttontype]">
                  <?php if ($module['buttontype'] == '1') { ?>
                  <option value="1" selected="selected"><?php echo $text_button_small; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_button_small; ?></option>
                  <?php } ?>
                  <?php if ($module['buttontype'] == '2') { ?>
                  <option value="2" selected="selected"><?php echo $text_button_default; ?></option>
                  <?php } else { ?>
                  <option value="2"><?php echo $text_button_default; ?></option>
                  <?php } ?>
                  <?php if ($module['buttontype'] == '3') { ?>
                  <option value="3" selected="selected"><?php echo $text_button_defaultcc; ?></option>
                  <?php } else { ?>
                  <option value="3"><?php echo $text_button_defaultcc; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
			<tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_position; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="donations_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="donations_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
	  <center><?php echo $entry_contact; ?></center>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
    html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
	html += '  </div>';
	<?php foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '      <table class="form">';
	html += '    <tr>';
	html += '      <td><?php echo $entry_modulename; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][modulename]" value="Donations" size="100" /></td>';
	html += '    </tr>';
	html += '        <tr>';
	html += '          <td><?php echo $entry_description; ?></td>';
	html += '          <td><textarea name="donations_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
	html += '        </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_justification; ?></td>';
	html += '      <td><select name="donations_module[' + module_row + '][justification]">';
	<?php foreach ($justifications as $justify) { ?>
	html += '        <option value="<?php echo $justify; ?>"><?php echo $justify; ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '      </table>';
	html += '    </div>';
	<?php } ?>
	html += '  <table class="form">';
	html += '    <tr>';
	html += '      <td><?php echo $entry_name; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][name]" value="" size="100" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_donatenumber; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][donatenumber]" value="" size="10" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_email; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][email]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_amount; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][amount]" value="" size="10" /></td>';
	html += '    </tr>';
	html += '	 <tr>';
	html += '      <td><?php echo $entry_currency; ?></td>';
    html += '      <td><select name="donations_module[' + module_row + '][currency]">';	
	<?php foreach ($currencies as $currency) { ?>
	html += '        <option value="<?php echo $currency; ?>"><?php echo $currency; ?></option>';
    <?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_buttontype; ?></td>';
	html += '      <td><select name="donations_module[' + module_row + '][buttontype]">';
	html += '        <option value="1"><?php echo $text_button_small; ?></option>';
	html += '        <option value="2"><?php echo $text_button_default; ?></option>';
	html += '        <option value="3"><?php echo $text_button_defaultcc; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select name="donations_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select name="donations_module[' + module_row + '][position]">';
	html += '        <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '        <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '        <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '        <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="donations_module[' + module_row + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="donations_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);
	
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?>
	
	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>