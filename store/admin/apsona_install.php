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
require ('apsona_app.php');
require ('apsona_functions.php');
require ('apsona_mysql.php');
error_reporting (E_ALL ^ E_NOTICE);

$languageId = $_GET["languageId"] != null ? $_GET["languageId"] : ($_SESSION["language_id"] != null ? $_SESSION["language_id"] : 1);
$userId = 0;
$app = new ApsonaApp ($languageId, $userId);

// The app will now have been installed.
?>
<head>
  <title>Apsona install complete.</title>
</head>
<body>
  <div style="padding: 40px 20px; width: 400px;">
    Apsona ShopAdmin has been installed. You can access it via the <code>Apsona ShopAdmin</code> menu item in your OpenCart <code>System</code> menu.
    <p>Please make sure to enable the Apsona files: Navigate to System - Users - User groups, edit "Top Administrator" and enable the file tool/apsona_sa.</p>
  </div>
</body>
</html>

