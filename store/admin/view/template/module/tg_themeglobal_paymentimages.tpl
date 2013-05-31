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
   <div id="tabs" class="htabs"><a href="#tab_general"><?php echo $tab_gen; ?></a><a href="#tab_image"><?php echo $tab_sliderimage; ?></a></div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    
     <div id="tab_general">  
    <table class="form">
   
        <tr>
          <td><?php echo $entry_status; ?></td>
          <td colspan="3"><select name="slideshow_status">
              <?php if ($slideshow_status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
		<tr>
		
        

        
		
		
            
        </table>
        </div>
        
       <div id="tab_image">
        
        <tr>
          <td colspan="4"><h3><?php echo $help_addslidehdr; ?></h3>
          <?php echo $help_addslidetext; ?>
          </td>
        </tr>
        <tr>
          <td colspan="4">
        <table id="images" class="list">
          <thead>
            <tr>
              <td class="left" colspan="2"><?php echo $entry_image; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $image_row = 0; ?>
          <?php
          if(!empty($slide_images)){
                foreach ($slide_images as $key=>$slide_image) {

          //Capture errors for blank fields
          if(empty($slide_image['file'])){$preview_image = $no_image;}else{$preview_image = HTTP_IMAGE . $slide_image['file']; }
          if(!isset($slide_image['url'])){ $slide_image['url'] == ""; }
          
          

          ?>
          <tbody id="image_row<?php echo $image_row; ?>">
            <tr>
              <td class="left">
              <input type="hidden" name="slide_image[<?php echo $image_row; ?>][file]" value="<?php echo $slide_image['file']; ?>" id="image<?php echo $image_row; ?>" />
               <img src="<?php echo $preview_image; ?>" alt="" id="preview<?php echo $image_row; ?>" width="100" height="auto" width="auto" height="100"  style="margin: 4px 0px; border: 1px solid #EEEEEE;" onclick="image_upload('image<?php echo $image_row; ?>', 'preview<?php echo $image_row; ?>');" /></td>
              
              
              
              <td><?php echo $entry_url; ?>
              <input type="text" name="slide_image[<?php echo $image_row; ?>][url]" size="80" value="<?php echo $slide_image['url'] ?>" id="url<?php echo $image_row; ?>" /><br />
              
              
              </td>
              
              <td class="left"><a onclick="$('#image_row<?php echo $image_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
            </tr>
          </tbody>
          <?php $image_row++; ?>
          <?php }
          } ?>
          <tfoot>
            <tr>
              <td class="right" colspan="4"><a onclick="addImage();" class="button"><span><?php echo $button_addslide; ?></span></a></td>
            </tr>
          </tfoot>
        </table>
          </td>
        </tr>
      </table>
      </div>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
function image_upload(field, preview) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&field=' + encodeURIComponent(field) + '&token=<?php echo $this->session->data['token']; ?>" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $this->session->data['token']; ?>',
					type: 'POST',
					data: 'image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" style="border: 1px solid #EEEEEE;" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
    html  = '<tbody id="image_row' + image_row + '">';
	html += '<tr>';
	html += '<td class="left"><input type="hidden" name="slide_image[' + image_row + '][file]" value="" id="image' + image_row + '" /><img src="<?php echo $no_image; ?>" alt="" id="preview' + image_row + '" style="margin: 4px 0px; border: 1px solid #EEEEEE;"  style="cursor: pointer;" align="top" onclick="image_upload(\'image' + image_row + '\', \'preview' + image_row + '\');"  /></td>';
	html += '<td class="left"><?php echo $entry_url; ?><input type="text" name="slide_image[' + image_row + '][url]" size="80" value="" id="url' + image_row + '" /><br />';
	html += '<td class="left"><a onclick="$(\'#image_row' + image_row  + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';
	html += '</tbody>';

	$('#images tfoot').before(html);

	image_row++;
}
//--></script>


<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs(); 
$('#vtab-option a').tabs();
//--></script> 