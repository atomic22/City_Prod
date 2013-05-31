<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
/**
 *
 * --------------------------------------------------------------------------------------------------- 
 * Copyright (c) 2010 apsona.com
 * All rights reserved
 * You may not modify, redistribute, reverse-engineer, decompile or disassemble this software product.
 * Please see http://apsona.com/pages/ec/tos.html for full copyright details.
 * --------------------------------------------------------------------------------------------------- 
 *
*/
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<?php

define ('APSONA_SA_VERSION', '1.11');

if (!isset ($_COOKIE['oc_token']) || $_GET['token'] != $_COOKIE['oc_token']) {
    // Disallow unauthorized access
    header ("Location: index.php");
    exit();
}
$token = $_GET['token'];
require ('apsona_app.php');
require ('apsona_functions.php');
require ('apsona_mysql.php');
error_reporting (E_ALL ^ E_NOTICE);

$languageId = $_GET["languageId"] != null ? $_GET["languageId"] : ($_SESSION["language_id"] != null ? $_SESSION["language_id"] : 1);
$userId = 0;
$app = new ApsonaApp ($languageId, $userId);

?>
<head>
  <meta http-equiv="X-UA-Compatible" content="chrome=1">
  <meta http-equiv="Content-type" content="text/html;charset=UTF-8"/>
  <title>Apsona ShopAdmin <?php echo APSONA_SA_VERSION ?> for OpenCart</title>
  <script type="text/javascript">
    var Apsona = {
        apsonaBaseURL: "<?php echo APSONA_BASE_URL ?>",
        languageId: "<?php echo $languageId ?>",
        appId: "<?php echo APSONA_APP_ID ?>",
        addonVersion: "<?php echo APSONA_SA_VERSION ?>",
        dbInfo: {
            tablePrefix: "<?php echo $app->tableNamePrefix() ?>",
            picklists: <?php echo encodeJSON ($app->getPicklists ($app->getPicklistNames())) ?>
        }
    };
  </script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <script type="text/javascript" src="<?php echo APSONA_BASE_URL ?>/ec/opencart1.5/apsona.min.js"></script>
  <script type="text/javascript" src="apsona_dashboard.js"></script>
</head>
<body>
</body>
<script>
    $(function () {
        if (!jQuery.browser.msie) {
            ApsonaApp.init (Apsona,  "apsona_svc.php?token=<?php echo $token ?>&uri_offset=");
        }
    });
</script>
</html>
