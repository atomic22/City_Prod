<?php
setcookie ("oc_token", $this->session->data['token']);
$this->redirect (HTTPS_SERVER . "apsona_index.php?token=" . $this->session->data['token']);
?>
