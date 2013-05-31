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
    <div id="tabs" class="htabs"><a href="#tab-general">General Setting</a><a href="#tab-image">Slider Image Manager</a></div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    


    
     <div id="tab-general">  
    <table class="form">






<table class="form">


	<tr>
       <td width="20%"><?php echo $entry_effect; ?> </td>
        <td colspan="3"><select name="tg_themeglobal_slideshow_slideshow_effect">
              <?php if (isset($tg_themeglobal_slideshow_slideshow_effect)) {
              $selected = "selected";
              ?>
              <option value="sliceDown" <?php if($tg_themeglobal_slideshow_slideshow_effect=='sliceDown'){echo $selected;} ?>>Slice Down</option>
              <option value="sliceDownLeft" <?php if($tg_themeglobal_slideshow_slideshow_effect=='random'){echo $selected;} ?>>Slice Down Left</option>
              <option value="sliceUp" <?php if($tg_themeglobal_slideshow_slideshow_effect=='sliceUp'){echo $selected;} ?>>Slice Up</option>
              <option value="sliceUpLeft" <?php if($tg_themeglobal_slideshow_slideshow_effect=='sliceUpLeft'){echo $selected;} ?>>Slice Up Left</option>
              <option value="sliceUpDown" <?php if($tg_themeglobal_slideshow_slideshow_effect=='sliceUpDown'){echo $selected;} ?>>Slice Up Down</option>
              <option value="sliceUpDownLeft" <?php if($tg_themeglobal_slideshow_slideshow_effect=='sliceUpDownLeft'){echo $selected;} ?>>Slice Up Down Left</option>
              <option value="fold" <?php if($tg_themeglobal_slideshow_slideshow_effect=='fold'){echo $selected;} ?>>Fold</option>
              <option value="fade" <?php if($tg_themeglobal_slideshow_slideshow_effect=='fade'){echo $selected;} ?>>Fade</option>
              <option value="random" <?php if($tg_themeglobal_slideshow_slideshow_effect=='random'){echo $selected;} ?>>Random</option>
              <option value="slideInRight" <?php if($tg_themeglobal_slideshow_slideshow_effect=='slideInRight'){echo $selected;} ?>>Slide In Right</option>
              <option value="slideInLeft" <?php if($tg_themeglobal_slideshow_slideshow_effect=='slideInLeft'){echo $selected;} ?>>Slide In Left</option>
              <option value="boxRain" <?php if($tg_themeglobal_slideshow_slideshow_effect=='boxRain'){echo $selected;} ?>>Box Rain</option>
              <option value="boxRainReverse" <?php if($tg_themeglobal_slideshow_slideshow_effect=='boxRainReverse'){echo $selected;} ?>>Box Rain Reverse</option>
              <option value="boxRainGrow" <?php if($tg_themeglobal_slideshow_slideshow_effect=='boxRainGrow'){echo $selected;} ?>>Box Rain Grow</option>
              <option value="boxRainGrowReverse" <?php if($tg_themeglobal_slideshow_slideshow_effect=='boxRainGrowReverse'){echo $selected;} ?>>Box Rain Grow Reverse</option>
                   
            
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="sliceDown">Slice Down</option>
              <option value="sliceDownLeft">Slice Down Left</option>
              <option value="sliceUp">Slice Up</option>
              <option value="sliceUpLeft">Slice Up Left</option>
              <option value="sliceUpDown">Slice Up Down</option>
              <option value="sliceUpDownLeft">Slice Up Down Left</option>
              <option value="fold">Fold</option>
              <option value="fade">Fade</option>
              <option value="random">Random</option>
              <option value="slideInRight">Slide In Right</option>
              <option value="slideInLeft">Slide In Left</option>
              <option value="boxRain">Box Rain</option>
              <option value="boxRainReverse">Box Rain Reverse</option>
              <option value="boxRainGrow">Box Rain Grow</option>
              <option value="boxRainGrowReverse">Box Rain Grow Reverse</option>
            
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_delay; ?>
       
          </td>
          <td><select name="tg_themeglobal_slideshow_slideshow_delay">

              <?php if (isset($tg_themeglobal_slideshow_slideshow_delay)) {
              $selected = "selected";
              ?>
              <option value="1000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='1000'){echo $selected;} ?>>1000</option>
              <option value="2000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='2000'){echo $selected;} ?>>2000</option>
              <option value="3000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='3000'){echo $selected;} ?>>3000</option>
              <option value="4000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='4000'){echo $selected;} ?>>4000</option>
              <option value="5000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='5000'){echo $selected;} ?>>5000</option>
              <option value="6000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='6000'){echo $selected;} ?>>6000</option>
              <option value="7000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='7000'){echo $selected;} ?>>7000</option>
              <option value="8000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='8000'){echo $selected;} ?>>8000</option>
              <option value="9000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='9000'){echo $selected;} ?>>9000</option>
              <option value="10000" <?php if($tg_themeglobal_slideshow_slideshow_delay=='10000'){echo $selected;} ?>>10000</option>
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="1000">1000</option>
              <option value="2000">2000</option>
              <option value="3000">3000</option>
              <option value="4000">4000</option>
              <option value="5000">5000</option>
              <option value="6000">6000</option>
              <option value="7000">7000</option>
              <option value="8000">8000</option>
              <option value="9000">9000</option>
              <option value="10000">10000</option>
              <?php } ?>
            </select>
            </td>

          
        </tr>
        
        <tr>
        <td width="20%"><?php echo $entry_speed; ?>
        
          </td>
          <td><select name="tg_themeglobal_slideshow_slideshow_speed">
              <?php if (isset($tg_themeglobal_slideshow_slideshow_speed)) {
              $selected = "selected";
              ?>
              <option value="200" <?php if($tg_themeglobal_slideshow_slideshow_speed=='200'){echo $selected;} ?>>200</option>
              <option value="300" <?php if($tg_themeglobal_slideshow_slideshow_speed=='300'){echo $selected;} ?>>300</option>
              <option value="400" <?php if($tg_themeglobal_slideshow_slideshow_speed=='400'){echo $selected;} ?>>400</option>
              <option value="500" <?php if($tg_themeglobal_slideshow_slideshow_speed=='500'){echo $selected;} ?>>500</option>
              <option value="600" <?php if($tg_themeglobal_slideshow_slideshow_speed=='600'){echo $selected;} ?>>600</option>
              <option value="700" <?php if($tg_themeglobal_slideshow_slideshow_speed=='700'){echo $selected;} ?>>700</option>
              <option value="800" <?php if($tg_themeglobal_slideshow_slideshow_speed=='800'){echo $selected;} ?>>800</option>
              <option value="900" <?php if($tg_themeglobal_slideshow_slideshow_speed=='900'){echo $selected;} ?>>900</option>
              <option value="1000" <?php if($tg_themeglobal_slideshow_slideshow_speed=='1000'){echo $selected;} ?>>1000</option>
              <option value="2000" <?php if($tg_themeglobal_slideshow_slideshow_speed=='2000'){echo $selected;} ?>>2000</option>
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="200">200</option>
              <option value="300">300</option>
              <option value="400">400</option>
              <option value="500">500</option>
              <option value="600">600</option>
              <option value="700">700</option>
              <option value="800">800</option>
              <option value="900">900</option>
              <option value="1000">1000</option>
              <option value="2000">2000</option>
              <?php } ?>
            </select></td>
        </tr>

        

          <tr>
          <td><?php echo $entry_pause; ?></td>
          <td colspan="3"><select name="tg_themeglobal_slideshow_slideshow_pause">
              <?php if ($tg_themeglobal_slideshow_slideshow_pause) { 
               $selected = "selected";
              ?>
              <option value="true" <?php if($tg_themeglobal_slideshow_slideshow_pause=='true'){echo $selected;} ?>>Yes</option>     
              <option value="false" <?php if($tg_themeglobal_slideshow_slideshow_pause=='false'){echo $selected;} ?>>No</option>
               <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="true">Yes</option>
              <option value="false">No</option>
              <?php } ?>
              
            </select></td>
        </tr>
        
        
        
        
        
         <tr>
        <td width="20%"><?php echo $entry_slices; ?>
        
          </td>
          <td><select name="tg_themeglobal_slideshow_slideshow_slices">
              <?php if (isset($tg_themeglobal_slideshow_slideshow_slices)) {
              $selected = "selected";
              ?>
              <option value="1" <?php if($tg_themeglobal_slideshow_slideshow_slices=='1'){echo $selected;} ?>>1</option>
              <option value="2" <?php if($tg_themeglobal_slideshow_slideshow_slices=='2'){echo $selected;} ?>>2</option>
              <option value="3" <?php if($tg_themeglobal_slideshow_slideshow_slices=='3'){echo $selected;} ?>>3</option>
              <option value="4" <?php if($tg_themeglobal_slideshow_slideshow_slices=='4'){echo $selected;} ?>>4</option>
              <option value="5" <?php if($tg_themeglobal_slideshow_slideshow_slices=='5'){echo $selected;} ?>>5</option>
              <option value="6" <?php if($tg_themeglobal_slideshow_slideshow_slices=='6'){echo $selected;} ?>>6</option>
              <option value="7" <?php if($tg_themeglobal_slideshow_slideshow_slices=='7'){echo $selected;} ?>>7</option>
              <option value="8" <?php if($tg_themeglobal_slideshow_slideshow_slices=='8'){echo $selected;} ?>>8</option>
              <option value="9" <?php if($tg_themeglobal_slideshow_slideshow_slices=='9'){echo $selected;} ?>>9</option>
              <option value="10" <?php if($tg_themeglobal_slideshow_slideshow_slices=='10'){echo $selected;} ?>>10</option>
              <option value="11" <?php if($tg_themeglobal_slideshow_slideshow_slices=='11'){echo $selected;} ?>>11</option>
              <option value="12" <?php if($tg_themeglobal_slideshow_slideshow_slices=='12'){echo $selected;} ?>>12</option>
              <option value="13" <?php if($tg_themeglobal_slideshow_slideshow_slices=='13'){echo $selected;} ?>>13</option>
              <option value="14" <?php if($tg_themeglobal_slideshow_slideshow_slices=='14'){echo $selected;} ?>>14</option>
              <option value="15" <?php if($tg_themeglobal_slideshow_slideshow_slices=='15'){echo $selected;} ?>>15</option>
              <option value="16" <?php if($tg_themeglobal_slideshow_slideshow_slices=='16'){echo $selected;} ?>>16</option>
              <option value="17" <?php if($tg_themeglobal_slideshow_slideshow_slices=='17'){echo $selected;} ?>>17</option>
              <option value="18" <?php if($tg_themeglobal_slideshow_slideshow_slices=='18'){echo $selected;} ?>>18</option>
              <option value="19" <?php if($tg_themeglobal_slideshow_slideshow_slices=='19'){echo $selected;} ?>>19</option>
              <option value="20" <?php if($tg_themeglobal_slideshow_slideshow_slices=='20'){echo $selected;} ?>>20</option>
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
              <option value="13">13</option>
              <option value="14">14</option>
              <option value="15">15</option>
              <option value="16">16</option>
              <option value="17">17</option>
              <option value="18">18</option>
              <option value="19">19</option>
              <option value="20">20</option>
              <?php } ?>
            </select></td>
        </tr>
        
        
          <tr>
        <td width="20%"><?php echo $entry_boxcolumns; ?>
        
          </td>
          <td><select name="tg_themeglobal_slideshow_slideshow_boxcolumns">
              <?php if (isset($tg_themeglobal_slideshow_slideshow_boxcolumns)) {
              $selected = "selected";
              ?>
              <option value="1" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='1'){echo $selected;} ?>>1</option>
              <option value="2" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='2'){echo $selected;} ?>>2</option>
              <option value="3" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='3'){echo $selected;} ?>>3</option>
              <option value="4" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='4'){echo $selected;} ?>>4</option>
              <option value="5" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='5'){echo $selected;} ?>>5</option>
              <option value="6" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='6'){echo $selected;} ?>>6</option>
              <option value="7" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='7'){echo $selected;} ?>>7</option>
              <option value="8" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='8'){echo $selected;} ?>>8</option>
              <option value="9" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='9'){echo $selected;} ?>>9</option>
              <option value="10" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='10'){echo $selected;} ?>>10</option>
              <option value="11" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='11'){echo $selected;} ?>>11</option>
              <option value="12" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='12'){echo $selected;} ?>>12</option>
              <option value="13" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='13'){echo $selected;} ?>>13</option>
              <option value="14" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='14'){echo $selected;} ?>>14</option>
              <option value="15" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='15'){echo $selected;} ?>>15</option>
              <option value="16" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='16'){echo $selected;} ?>>16</option>
              <option value="17" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='17'){echo $selected;} ?>>17</option>
              <option value="18" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='18'){echo $selected;} ?>>18</option>
              <option value="19" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='19'){echo $selected;} ?>>19</option>
              <option value="20" <?php if($tg_themeglobal_slideshow_slideshow_boxcolumns=='20'){echo $selected;} ?>>20</option>
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
              <option value="13">13</option>
              <option value="14">14</option>
              <option value="15">15</option>
              <option value="16">16</option>
              <option value="17">17</option>
              <option value="18">18</option>
              <option value="19">19</option>
              <option value="20">20</option>
              <?php } ?>
            </select></td>
        </tr>



  <tr>
        <td width="20%"><?php echo $entry_boxrows; ?>
        
          </td>
          <td><select name="tg_themeglobal_slideshow_slideshow_boxrows">
              <?php if (isset($tg_themeglobal_slideshow_slideshow_boxrows)) {
              $selected = "selected";
              ?>
              <option value="1" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='1'){echo $selected;} ?>>1</option>
              <option value="2" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='2'){echo $selected;} ?>>2</option>
              <option value="3" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='3'){echo $selected;} ?>>3</option>
              <option value="4" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='4'){echo $selected;} ?>>4</option>
              <option value="5" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='5'){echo $selected;} ?>>5</option>
              <option value="6" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='6'){echo $selected;} ?>>6</option>
              <option value="7" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='7'){echo $selected;} ?>>7</option>
              <option value="8" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='8'){echo $selected;} ?>>8</option>
              <option value="9" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='9'){echo $selected;} ?>>9</option>
              <option value="10" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='10'){echo $selected;} ?>>10</option>
              <option value="11" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='11'){echo $selected;} ?>>11</option>
              <option value="12" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='12'){echo $selected;} ?>>12</option>
              <option value="13" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='13'){echo $selected;} ?>>13</option>
              <option value="14" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='14'){echo $selected;} ?>>14</option>
              <option value="15" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='15'){echo $selected;} ?>>15</option>
              <option value="16" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='16'){echo $selected;} ?>>16</option>
              <option value="17" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='17'){echo $selected;} ?>>17</option>
              <option value="18" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='18'){echo $selected;} ?>>18</option>
              <option value="19" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='19'){echo $selected;} ?>>19</option>
              <option value="20" <?php if($tg_themeglobal_slideshow_slideshow_boxrows=='20'){echo $selected;} ?>>20</option>
              <?php } else { ?>
              <option selected="selected"><?php echo $text_pleaseselect; ?></option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
              <option value="13">13</option>
              <option value="14">14</option>
              <option value="15">15</option>
              <option value="16">16</option>
              <option value="17">17</option>
              <option value="18">18</option>
              <option value="19">19</option>
              <option value="20">20</option>
              <?php } ?>
            </select></td>
        </tr>






</table>
</body>




        
  
        </table>
        </div>
    
    
    
    
    <div id="tab-image"> 
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_banner; ?></td>
            <td class="left"><?php echo $entry_dimension; ?></td>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left"><select name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][banner_id]">
                <?php foreach ($banners as $banner) { ?>
                <?php if ($banner['banner_id'] == $module['banner_id']) { ?>
                <option value="<?php echo $banner['banner_id']; ?>" selected="selected"><?php echo $banner['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $banner['banner_id']; ?>"><?php echo $banner['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><input type="text" name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="3" />
              <input type="text" name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="3"/>
              <?php if (isset($error_dimension[$module_row])) { ?>
              <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
              <?php } ?></td>
            <td class="left"><select name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][position]">
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
            <td class="left"><select name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="tg_themeglobal_slideshow_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="6"></td>
            <td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
</div>
 </div> <!-- tab-image (end) -->
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="tg_themeglobal_slideshow_module[' + module_row + '][banner_id]">';
	<?php foreach ($banners as $banner) { ?>
	html += '      <option value="<?php echo $banner['banner_id']; ?>"><?php echo addslashes($banner['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><input type="text" name="tg_themeglobal_slideshow_module[' + module_row + '][width]" value="" size="3" /> <input type="text" name="tg_themeglobal_slideshow_module[' + module_row + '][height]" value="" size="3" /></td>';	
	html += '    <td class="left"><select name="tg_themeglobal_slideshow_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="tg_themeglobal_slideshow_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="tg_themeglobal_slideshow_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="tg_themeglobal_slideshow_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs(); 
$('#vtab-option a').tabs();
//--></script> 
<?php echo $footer; ?>