


		<div id="top"> 
			
			<div class="slideshow"> 
			<div class="controlnav-thumbs">
  			<div id="tg_slideshow<?php echo $module; ?>" class="nivoSlider" style="width: <?php echo $width; ?>px; height: <?php echo $height; ?>px;">
    		<?php foreach ($banners as $banner) { ?>
    			<?php if ($banner['link']) { ?>
   				 	<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" rel="<?php echo HTTPS_SERVER; ?>catalog/view/theme/themeglobal/stylesheet/timthumb.php?src=<?php echo $banner['image']; ?>&w=96&h=40&zc=1" alt="<?php echo $banner['title']; ?>" /></a>
    			<?php } else { ?>
    				<img src="<?php echo $banner['image']; ?>" rel="<?php echo HTTPS_SERVER; ?>catalog/view/theme/themeglobal/stylesheet/timthumb.php?src=<?php echo $banner['image']; ?>&w=96&h=40&zc=1" alt="<?php echo $banner['title']; ?>" />
				<?php } ?>
    		<?php } ?>
  			</div>
</div>
	
			</div>
			
		</div>	
			<script type="text/javascript">
    			$(document).ready(function() {
     	    	$('#tg_slideshow<?php echo $module; ?>').nivoSlider({
				animSpeed:'<?php echo $speed; ?>',
				effect:'<?php echo $effect; ?>',
				slices:'<?php echo $slices; ?>',
				boxCols:'<?php echo $boxcolumns; ?>',
     	   		boxRows:'<?php echo $boxrows; ?>',
     	 	  	directionNav:false,
				directionNavHide:false,
				captionOpacity:0.6,
				controlNav:true,
				controlNavThumbs:true,
				controlNavThumbsFromRel:true,
				pauseTime:<?php echo $delay; ?>,		
				pauseOnHover:<?php echo $pause; ?>
				});
    			});
    		</script>
  	
  
  
