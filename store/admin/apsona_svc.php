<?php

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

require ('apsona_app.php');
require ('apsona_functions.php');
require ('apsona_mysql.php');
error_reporting (E_ALL ^ E_NOTICE);

// Disallow unauthorized access:
if (!isset ($_COOKIE['oc_token']) || $_GET['token'] != $_COOKIE['oc_token']) {
    // Disallow unauthorized access
    echo '{"error": "Unauthorized access."}';
    exit();
}


// Parse the parameters:
$uri = $_SERVER['REQUEST_URI'];

$pathInfo = $_GET['uri_offset'];
if (!$pathInfo) {
    $pos = strpos ($uri, "/apsona_svc.php/");
    if ($pos > 0) {
        $pathInfo = substr ($uri, $pos + strlen ("/apsona_svc.php"));
        $qPos = strpos ($pathInfo, "?");
        if ($qPos > 0) {
            $pathInfo = substr ($pathInfo, 0, $qPos);
        }
    }
}

if (!$pathInfo) {
    echo ("{\"error\": \"Cannot find path info for URI '$uri'\"}");
    exit();
}

$op  = $pathInfo;

$parameters = parseParameters();
preg_match (":^/svc/|(/get/data|/put/data|/update/data|/delete/data)/([A-Za-z0-9_]+)(\.csv|\.js)?|/get/metadata|/util/echo:", $op, $matches);
$command   = count($matches) >= 2 ? $matches[1] : $matches[0];
$tableName = count($matches) >= 3 ? $matches[2] : null;
$mimeType  = count($matches) >= 4 ? substr ($matches[3], 1) : null;

$languageId = isset($_GET["languageId"]) ? $_GET["languageId"] :  $_SESSION["language_id"];
$userId = 0;
$app = new ApsonaApp ($languageId, $userId);


if ($op == "/put/dashboard.js") {
    $dashboardJSON = isset ($_GET['parameters']) ? $_GET['parameters'] : $_POST['parameters'];
    header ("Content-type: text/javascript");
    if (isset ($dashboardJSON)) {
        $app->storeDashboard ($dashboardJSON);
        echo "{}";
    } else {
        echo '{"error": "No dashboard given."}';
    }
    exit();
}

$svr = new ApsonaServer ($app);
if (substr ($op, 0, 4) == "/svc/") {
    $svr->serveResource ($op);
} else if ($op == "/util/echo") {
    $svr->doEcho ($_POST["data"], $_POST["_fileName"], $_POST["_mimeType"]);
} else {
    $svr->serve ($command, $tableName, $mimeType, $parameters);
}

?>
