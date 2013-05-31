<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
      <div style="text-align: <?php echo $justification; ?>; margin: 5px; width: 100%;">
	  
		<?php echo $message; ?>
    
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
		<input type="hidden" name="cmd" value="_donations">
		<input type="hidden" name="business" value="<?php echo $email; ?>">
		<input type="hidden" name="lc" value="US">
		<input type="hidden" name="item_name" value="<?php echo $name; ?>">
		<?php if ($amount) { ?>
		<input type="hidden" name="amount" value="<?php echo $amount; ?>">
		<?php } ?>
		<input type="hidden" name="currency_code" value="<?php echo $currency; ?>">
		<input type="hidden" name="no_note" value="0">
		<?php if ($buttontype == '1') { ?>
		<input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_SM.gif:NonHostedGuest">
		<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
		<?php } elseif ($buttontype == '2') { ?>
		<input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_LG.gif:NonHostedGuest">
		<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
		<?php } elseif ($buttontype == '3') { ?>
		<input type="hidden" name="bn" value="PP-DonationsBF:btn_donateCC_LG.gif:NonHostedGuest">
		<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
		<?php } else { ?>
		<input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_LG.gif:NonHostedGuest">
		<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
		<?php } ?>
		<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
		</form>
		
    </div>
  </div>
</div>