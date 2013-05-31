<!-- LANGUAGE AREA -->
			
					<form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data" id="language_form">
						<div id="language_switcher" class="switcher">
							<?php foreach ($languages as $language) { ?>
							<?php if ($language['code'] == $language_code) { ?>
							<span class="s_selected"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></span>
						<?php } ?>
						<?php } ?>
							<ul class="option">
							<?php foreach ($languages as $language) { ?>
							<li><a href="javascript:;" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $('#language_form').submit();"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
							<?php } ?>
							</ul>
						</div>
						<input class="s_hidden" type="hidden" name="language_code" value="" />
						<input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
					</form>
	<!-- LANGUAGE AREA -->			