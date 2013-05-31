<form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data" id="currency_form">
					<div id="currency_switcher_language" class="switcher">
					
					<?php foreach ($currencies as $currency) { ?>
					<?php if ($currency['code'] == $currency_code) { ?>
					<span class="s_selected"><?php echo $currency['title']; ?></span>
					<?php } ?>
					<?php } ?>
					<ul class="option">
						<?php foreach ($currencies as $currency) { ?>
							<li><a href="javascript:;" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $('#currency_form').submit();"><?php echo $currency['title']; ?></a></li>
						<?php } ?>
					</ul>
					</div>
						<input class="s_hidden" type="hidden" name="currency_code" value="" />
						<input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
				</form>