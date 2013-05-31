<div <?php print drupal_attributes($page['attributes_array']['page']); ?>>
    <div class="header" <?php print drupal_attributes($page['attributes_array']['header']); ?>>
        <h1 class="site-name"><?php print $site_name; ?><img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" /></h1>
              
      <?php if (module_exists('toolbar') && $is_admin): ?>
      <a href="#toolbar" data-role="button" data-rel="dialog" data-transition="pop" data-icon="grid" >Menu</a>
      <?php endif; ?>

      <?php if (!$is_front && !$is_admin): ?>
      <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>" data-rel="home" data-icon="home" data-ajax="false"><span><?php print t('Home'); ?></span></a>
      <?php endif; ?>
      
      <?php if ($tabs): ?><?php print render($tabs); ?><?php endif; ?>  
      <?php if ($action_links): ?><div data-role="navbar"><ul class="action-links"><?php print render($action_links); ?></ul></div><?php endif; ?>
    </div> <!-- /#header -->

	

    <div class="main-content" 
	<?php print drupal_attributes($page['attributes_array']['content']); ?>
	
        <div class="content-primary">
		<div class="navigation">
			<?php $blockt = module_invoke('menu_block', 'block_view', 3);
			if ($blockt['content'] != null):
			?>
			<span class="menutoggle" data-role="button">Hide Menu</span>
			<span class="themenu"><?php print render($blockt['content']);
			endif;?></span>
		</div>
	      <?php print render($page['header']); ?>
          <?php print $messages; ?>  
          <?php print render($title_prefix); ?>
          <?php if ($title): ?><h2 class="title" class="page-title"><?php print $title; ?></h2><?php endif; ?>
          <?php print render($title_suffix); ?>
          <?php print render($page['help']); ?>
          <?php print render($page['content']); ?>
        </div> <!-- /.content-primary -->
        
     <div class="footer" <?php print drupal_attributes($page['attributes_array']['footer']); ?>>        
      <?php print render($page['footer']); ?>
    </div> <!-- /#footer -->

</div> <!-- /#page -->