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


class ApsonaServer {


    public function __construct ($app) {
        $this->_app = $app;
    }

    public function serveResource ($uri) {
        $service = new HttpProxy ($this->_app->apsonaURL());
        $service->perform (substr ($uri, 4));
    }
    
    public function doEcho ($data, $fileName, $mimeType) {
        header ("Content-type: $mimeType");
        header ("Content-Disposition: attachment;filename=$fileName");
        echo $data;
    }

    public function serve ($command, $tableName, $mimeType, $parameters) {

        switch ($command) {
        case "/get/data":
            $query = $parameters['q'];
            if (!$query || $query == "") {
                echo "{\"error\":  \"$pathInfo: No query given.\"}";
                break;
            }
            $query = str_rot13 ($query);
            $fields = $parameters['fields'];
            $first = $parameters['firstRecord'];
            if ($first == null) $first = 0;
            $count = $parameters['recordCount'];
            if ($count == null) $count = 1000000;
            $db = $this->_app->dbConnection();
            if (strtolower ($mimeType) == "csv") {
                header ("Content-type: text/csv");
                header ("Content-disposition: attachment;filename=" . $tableName . ".csv");
                $this->_getDataCSV ($tableName, $query, $fields, $db);
            } else { // Default: Assume JSON
                header ("Content-type: text/javascript");
                $this->_getDataJSON ($query, $first, $count, $parameters['isRef'], $db);
            }
            $db->close();
            break;

        case "/put/data":
            header ("Content-type: text/javascript");
            $db = $this->_app->dbConnection();
            $result = $db->storeRecords ($tableName, $parameters['fieldIds'], $parameters['records']);
            $db->close();
            $this->_app->clearCache ($tableName);
            echo encodeJSON ($result);
            break;

        case "/update/data":
            header ("Content-type: text/javascript");
            $where = $parameters['where'];
            $valueMap = $parameters['valueMap'];
            $result = null;
            if ($where && $valueMap) {
                $where = str_rot13 ($where);
                $db = $this->_app->dbConnection();
                $result = $db->updateRecords ($tableName, $where, $valueMap);
                $db->close();
            }
            $this->_app->clearCache ($tableName);
            echo $result ? encodeJSON ($result) : "{}";
            break;

        case "/delete/data":
            header ("Content-type: text/javascript");
            $where = $parameters['where'];
            $result = null;
            if ($where) {
                $where = str_rot13 ($where);
                $db = $this->_app->dbConnection();
                $result = $db->deleteRecords ($tableName, $where);
                $db->close();
            }
            $this->_app->clearCache ($tableName);
            echo $result ? encodeJSON ($result) : "{}";
            break;
            
        case "/get/metadata":
            header ("Content-type: text/javascript");
            $tables = $parameters['tableNames'];
            $db = $this->_app->dbConnection();
            echo "{";
            for ($i = 0; $i < count($tables); $i++) {
                echo "\n";
                if ($i > 0) echo ",";
                echo '"' . $tables[$i] . '": ';
                echo encodeJSON ($db->getMetadata ($tables[$i]));
            }
            echo "\n}";
            $db->close();
            break;

        default:
            header ("Content-type: text/javascript");
            echo "{\"error\": \"Invalid command '$command'\"}";
            break;
            
        }
    }

    private function _getDataJSON ($query, $first, $count, $isRef, $db) {
        $timeNow = microtime(true);
        $result = $db->execute ($query, $first, $count, true);
        if (!$result) {
            return;
        }
        $result["timeStats"] = array ("totalMS" => (microtime(true) - $timeNow)*1000);
        if ($result['error'] || !array_key_exists ('recordIterator', $result)) {
            echo encodeJSON ($result);
            return;
        }
        $nRecs = $result['recordCount'];
        if ($nRecs == null) $nRecs = 0;
        $iter = $result['recordIterator'];
        echo '{ "totalRecords": ' . $nRecs . ',"records": [';
        if ($first <= 0 || $iter->seekTo ($first) ) {
            for ($ndx = 0; ($row = $iter->next()) != null && $ndx < $count; $ndx++) {
                if ($isRef) {
                    // The data includes references, return them as pairs
                    $newRec = array();
                    for ($j = 0, $m = count($row); $j < $m; $j++) {
                        if ($isRef[$j]) {
                            $newRec[] = array($row[$j], $row[$j+1]);
                            $j++;
                        } else {
                            $newRec[] = $row[$j];
                        }
                    }
                    $row = $newRec;
                }
                if ($ndx > 0) echo ",";
                echo encodeJSON ($row);
                echo "\n";
            }
        }
        echo ']}';
        $iter->close();
    }


    function _getDataCSV ($tableName, $query, $fields, $db) {
        $result = $db->execute ($query);
        if (!$result) {
            return;
        }
        if ($result['error']) {
            echo $result['error'];
            return;
        }
        $nFields = count($fields);
        for ($i = 0; $i < $nFields; $i++) {
            if ($i > 0) echo ",";
            echo '"' . str_replace ('"', '""', $fields[$i]['label']) . '"';
        }
        echo "\n";
        $picklistMap = array();
        for ($i = 0; $i < $nFields; $i++) {
            $plValues = $fields[$i]['choicesList'];// getPicklistForField ($tableName, $fields[$i], $db);
            if ($plValues) {
                $kvMap = array();
                for ($j = 0; $j < count($plValues); $j++) {
                    $plPair = $plValues[$j];
                    $kvMap[$plPair['value']] = $plPair['text'];
                }
                $picklistMap[$i] = $kvMap;
            }
        }
        $iter = $result['recordIterator'];
        while (($row = $iter->next()) != null) {
            for ($i = 0; $i < $nFields; $i++) {
                if ($i > 0) echo ",";
                $value = $row[$i];
                $plMap = $picklistMap[$i];
                if ($plMap) {
                    $valueParts = explode ("##", $value);
                    for ($j = count($valueParts)-1; $j >= 0; $j--) {
                        $valueParts[$j] = $plMap[$valueParts[$j]];
                    }
                    $value = implode ("\n", $valueParts);
                }
                echo '"' . str_replace ('"', '""', $value) . '"';
            }
            echo "\n";
        }
        $iter->close();
    }


    // function errorLog ($str) {
    //     error_log (strftime('%Y-%m-%d %H:%M:%S') . " [Apsona ShopAdmin error] " . $str . "\n");
    // }


    private $_app;
}




class AbstractDbConnection {

    public function getTableNames() {
        return array ("error" => "Must be implemented by derived class.");
    }
    
    public function getMetadata ($tableName) {
        return array ("error" => "Must be implemented by derived class.");
    }
    
    public function execute ($sqlString) {
        return array ("error" => "Must be implemented by derived class.");
    }

    public function quotedTableName ($tableName) { // Maybe overridden by derived classes
        return $tableName;
    }

    public function close () {
        return array ("error" => "Must be implemented by derived class.");
    }
    
    function sqlify ($valueString, $type) {
        switch ($type) {
        case "string":
            return "'" . preg_replace ('/\n/', '\\n', addslashes ($valueString)) . "'";

        case "number":
        default:
            return $valueString;
        }
    }


    public function getPicklistValues ($query) {
        $result = $this->execute ($query);
        $returnVal = array();
        if (!$result) return $returnVal;
        if ($result['error']) {
            $returnVal = $result;
        } else {
            $iter = $result['recordIterator'];
            $fieldNames = $result['fieldNames'];
            $nFields = count($fieldNames);
            for ($ndx = 0; ($row = $iter->next()) != null; $ndx++) {
                $entry = array ("value" => addslashes($row[0]), "text" => addslashes ($row[1]));
                for ($i = 2; $i < $nFields; $i++) {
                    $entry [$fieldNames[$i]] = addSlashes ($row[$i]);
                }
                $returnVal[] = $entry;
            }
            $iter->close();
        }
        return $returnVal;
    }

    private function _ensureMetadata ($tableName) {
        if ($this->tableInfo == null) {
            $this->tableInfo = array();
        }
        if ($this->tableInfo[$tableName] == null) {
            $this->tableInfo[$tableName] = $this->getMetadata ($tableName);
        }
        return $this->tableInfo[$tableName];
    }

    /**
     * Insert or update data records into the given table.
     */
    public function storeRecords ($tableName, $fieldNamesArray, $recordsArray) {
        $nFields = count ($fieldNamesArray);
        if ($nFields <= 0) {
            return array (); // Do nothing - need at least 1 field to insert or update
        }
        // Set up the SQL to check if the record already exists, and the positions of the columns
        $this->_ensureMetadata ($tableName);
        $keyColNames = $this->tableInfo[$tableName]["keyColNames"];
        $keyColPos = array(); // Map: table key column name -> position in record
        $isKeyCol = array(); // Map: position (#) -> true if the column at that position is a table key column
        $selSql = "select " . implode (",", $keyColNames) . " from  " . $this->quotedTableName ($tableName) . " ";
        $whereSql = "where ";
        $allKeyColsGiven = true;
        $nKeyCols = count($keyColNames);
        for ($i = 0; $i < $nKeyCols; $i++) {
            $whereSql .= ($i == 0 ? "" : " and ") . $keyColNames[$i] . " = ?$i?";
            $pos = array_search ($keyColNames[$i], $fieldNamesArray);
            if ($pos !== false) {
                $keyColPos[$keyColNames[$i]] = $pos;
                $isKeyCol[$pos] = true;
            } else {
                $allKeyColsGiven = false;
                break;
            }
        }
        $fieldTypes = array();
        for ($i = 0; $i < nFields; $i++) {
            $fieldType = $this->tableInfo[$tableName]["fieldTypes"][$fieldNamesArray[$i]];
            if (!$fieldType) {
                return array ("error" => "Cannot find field " . $fieldNamesArray[$i] . " in table $tableName");
            }
            $fieldTypes[] = $fieldType;
        }
        for ($i = 0, $n = count($recordsArray); $i < $n; $i++) {
            $record = $recordsArray[$i];
            if (count ($record) <= 0) {
                $results[] = array ("error" => "Empty record");
                continue; // Ignore empty records
            }
            if (count ($record) != $nFields) {
                $results[] = array ("error" => "Field count mismatch: Expecting $nFields fields, found " . count($record) . " fields.");
                continue;
            }
            $recordExists = false;
            $whereClauseForRec = "";
            if ($allKeyColsGiven) {
                $searchValues = array();
                $replacements = array();
                for ($j = 0; $j < $nKeyCols; $j++) {
                    $kcName = $keyColNames[$j];
                    $searchValues[] = "?$j?";
                    $replacements[] = $this->sqlify ($record[$keyColPos[$kcName]], $this->tableInfo[$tableName]["fieldTypes"][$kcName]);
                }
                $whereClauseForRec = str_replace ($searchValues, $replacements, $whereSql);
                $selSqlForRec = $selSql . " " . $whereClauseForRec;
                $result = $this->execute ($selSqlForRec);
                $recordExists = $result != null && $result['recordCount'] >= 1;
            }
                
            if ($recordExists) {
                $updates = "";
                for ($j = 0, $m = count($fieldNamesArray); $j < $m; $j++) {
                    $value =  $record [$j];
                    $fieldName = $fieldNamesArray[$j];
                    $fieldType = $fieldTypes[$j];
                    if (!isset ($fieldType)) $fieldType = "string";
                    if (!$isKeyCol[$j]) {
                        $updates .= ($updates != "" ? ", " : "") . $fieldNamesArray[$j] . " = " . $this->sqlify ($record[$j], $fieldType);
                    }
                }
                if (strlen($updates) > 0) {
                    $updSql = "update  " . $this->quotedTableName ($tableName) . " set $updates $whereClauseForRec";
                    $result = $this->execute ($updSql);
                    $result['op'] = "update";
                    $results[] = $result;
                } else {
                    $results[] = array(); // Did nothing, because no fields to update
                }
            } else {
                $fields = "";
                $values = "";
                for ($j = 0, $m = count($fieldNamesArray); $j < $m; $j++) {
                    $value =  $record [$j];
                    $fieldName = $fieldNamesArray[$j];
                    $fieldType = $fieldTypes[$j];
                    if (!isset ($fieldType)) $fieldType = "string";
                    $sep = $j > 0 ? ", " : "";
                    $fields .= $sep . $fieldNamesArray[$j];
                    $values .= $sep . $this->sqlify ($record[$j], $fieldType);
                }
                $result = $this->execute ("insert into " . $this->quotedTableName ($tableName) . " (" . $fields . ") values (" . $values . ")");
                $result['op'] = "insert";
                $results[] = $result;
            }
        }
        return $results;
    }


    private function _getWhereClauseForUpdateDelete ($tableName, $whereStr) {
        $keys = $this->_getKeyValues ($tableName, $whereStr);
        if ($keys && $keys['error']) return $keys;
        $whereSql = null;
        if ($keys && count($keys) > 0) {
            $tableInfo = $this->_ensureMetadata ($tableName);
            $whereSql = "";
            $keyColNames = $tableInfo["keyColNames"];
            $nKeys = count ($keyColNames);
            if ($nKeys > 1) {
                for ($i = 0, $m = count($keys); $i < $m; $i++) {
                    if ($i > 0) {
                        $whereSql .= " or ";
                    }
                    for ($j = 0; $j < $nKeys; $j++) {
                        $kcName = $keyColNames[$j];
                        $type = $tableInfo["fieldTypes"][$kcName];
                        $value = $keys[$i][$j];
                        $whereSql .= ($j > 0 ? " and " : "") . $kcName . " = " . $this->sqlify ($value, $type);
                    }
                }
            } else {
                $whereSql .= $keyColNames[0] . " in (" . implode(",", $keys) . ")";
            }
        }
        return array ("keys" => $keys, "where" => $whereSql);
    }
    
    public function updateRecords ($tableName, $where, $valueMap) {
        $whereCond = $this->_getWhereClauseForUpdateDelete ($tableName, $where);
        if (!$whereCond || $whereCond['error']) return $whereCond;
        $wClause = $whereCond['where'];
        if ($wClause) {
            $tableInfo = $this->_ensureMetadata ($tableName);
            $str = "";
            foreach ($valueMap as $key => $value) {
                $type = $tableInfo["fieldTypes"][$fieldName];
                if (!$type) $type = "string";
                $str .= ($str == "" ? "" : ", ") . $key . " = " . $this->sqlify ($value, $type);
            }
            $sql = "update " . $this->quotedTableName ($tableName) . " set $str where " . $wClause;
            $sqlResult = $this->execute ($sql);
            $result = $sqlResult && $sqlResult['error'] ? $sqlResult : array ("ids" => $whereCond['keys']);
        }
        return $result;
    }

    public function deleteRecords ($tableName, $where) {
        $whereCond = $this->_getWhereClauseForUpdateDelete ($tableName, $where);
        if (!$whereCond || $whereCond['error']) return $whereCond;
        $wClause = $whereCond['where'];
        if ($wClause) {
            $sql = "delete from  " . $this->quotedTableName ($tableName) . " where $wClause";
            $sqlResult = $this->execute ($sql);
            $result = $sqlResult && $sqlResult['error'] ? $sqlResult : array ("ids" => $whereCond['keys']);
        }
        return $result;
    }


    private function _getKeyValues ($tableName, $where) {
        // Return an array containing the primary keys for the records matching the given where clause. If there is only one pk column, the returned array
        // contains the key values as scalars; otherwise, it contains arrays, each of which are the key values.
        $tableInfo = $this->_ensureMetadata ($tableName);
        $keyFields = $tableInfo['keyColNames'];
        $sql = "select " . implode (",", $keyFields) . " from  " . $this->quotedTableName ($tableName) . ($where ? " where $where" : "");
        $result = $this->execute ($sql);
        $returnVal = array();
        $isSinglePk = count($keyFields) == 1;
        if ($result['error']) {
            $returnVal = $result;
        } else {
            $iter = $result['recordIterator'];
            for ($ndx = 0; ($row = $iter->next()) != null; $ndx++) {
                $returnVal[] = $isSinglePk ? $row[0] : $row;
            }
            $iter->close();
        }
        return $returnVal;
    }
    
    function _apsonaDataType ($sqlType) {
        switch ($sqlType) {
        case "varchar":
        case "char":
        case "tinytext":
            return "string";

        case "blob":
            return "text";
            
        case "int":
        case "smallint":
        case "mediumint":
            return "integer";

        case "float":
        case "decimal":
            return "number";

        case "tinyint":
            return "boolean";

        case "date":
            return "date";

        case "datetime":
        case "timestamp":
            return "datetime";

        default:
            return $sqlType;
        }
    }

    private $connection;
    private static $tableInfo;
};


class HttpProxy {

    public function __construct ($baseURL) {
        $this->baseUrl = $baseURL;
    }


    private function _getViaCurl ($url, $postData) {
        $headers = $this->_getHeaders();
        $hdrs = array();
        foreach ($headers as $name => $value) {
            $hdrs[] = "$name: $value";
        }
        $process = curl_init ($url);
        curl_setopt ($process, CURLOPT_HTTPHEADER, $hdrs);
        curl_setopt ($process, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt ($process, CURLOPT_ENCODING, $headers["Accept-Encoding"]);
        // curl_setopt ($process, CURLOPT_HEADER, true);
        if ($postData) {
            curl_setopt ($process, CURLOPT_POST, 1);
            curl_setopt ($process, CURLOPT_POSTFIELDS, $postData);
        }
        $return = curl_exec ($process);
        if ($return === false) {
            return array ("error" => curl_error ($process));
        }
        $response = curl_getinfo ($process);
        curl_close($process);
        return array ("content" => $return, "headers" => get_headers ($response['url']));
    }
    

    private function _getHeaders() {
       foreach ($_SERVER as $name => $value) {
           if (substr($name, 0, 5) == 'HTTP_') {
               $hdr = str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))));
               $hdrLower = strtolower ($hdr);
               if ($hdr != "host") $headers[$hdr] = $value;
           }
       }
       return $headers;
    }

    private function _copyServerHeaders ($headers) {
        $isGzip = false;
        foreach ($headers as $hdr) {
            if (is_string ($hdr) && preg_match ("/^[A-Za-z0-9_-]+:/", $hdr) > 0) {
                $hdrLower = strtolower ($hdr);
                if (substr ($hdrLower, 0, 22) == "content-encoding: gzip") {
                    $isGzip = true;
                } else if (substr ($hdrLower, 0, 17) != "transfer-encoding") {
                    header ($hdr);
                }
            }
        }
        return $isGzip;
    }
    
    private function _showError ($msg, $url) {
        if (substr ($url, strlen($url) - 3) == ".js") {
            echo "window.apsona_error = (window.apsona_error || '') + '<br/>' + " .  encodeJSON($msg);
        } else {
            echo $msg;
        }
    }
    
    public function perform ($svcUrl) {
        $qs = $_SERVER['QUERY_STRING'];
        $qs = $qs == null ? "" :  (substr ($qs, 0, 1) == "?" ? $qs : ("?" . $qs));
        $url = $this->baseUrl . $svcUrl . $qs;
        switch ($_SERVER['REQUEST_METHOD']) {
        case 'GET':
            $opts = array('http' => array('method' => 'GET','header'  => $this->_getHeaders(), 'timeout' => 3.0));
            $stream = @fopen($url, 'rb', false, stream_context_create ($opts));
            if ($stream) {
                $str = @stream_get_contents ($stream);
                if ($str === null  || trim($str) === "") {
                    $this->_showError ("$svcUrl: get failed: $php_errormsg", $svcUrl);
                    break;
                }
                $isGzip = $this->_copyServerHeaders ($http_response_header);
                if ($isGzip) {
                    $str = $this->_gzinflate ($str);
                    if ($str === null  || trim($str) === "") {
                        $this->_showError ("$svcUrl: gzinflate failed: $php_errormsg", $svcUrl);
                    }
                }
                fclose ($stream);
                echo $str;
            } else {
                // Try CURL
                $curlRes = $this->_getViaCurl ($url, null);
                if ($curlRes['error']) {
                    $this->_showError ("Unable to get shopAdmin resources: " . $curlRes['error']);
                    return;
                }
                $this->_copyServerHeaders ($curlRes["headers"]);
                echo $curlRes['content'];
            }
            flush();
            break;

        case 'POST':
            $data = file_get_contents("php://input");
            $params = array ('http' => array( 'method' => 'POST', 'content' => $data));
            $ctx = stream_context_create ($params);
            $fp = @fopen ($url, 'rb', false, $ctx);
            if ($fp) {
                fpassthru ($fp);
                fclose ($fp);
            } else { // Try CURL
                $curlRes = $this->_getViaCurl ($url, $data);
                if ($curlRes['error']) {
                    $this->_showError ("Unable to get shopAdmin resources: " . $curlRes['error']);
                    return;
                }
                $this->_copyServerHeaders ($curlRes["headers"]);
                echo $curlRes['content'];
                flush();
                break;
            }
            flush();
            break;
        }
    }

    private static function _gzinflate($gzData) {
        // From http://www.mydigitallife.info/2010/01/17/workaround-to-fix-php-warning-gzuncompress-or-gzinflate-data-error-in-wordpress-http-php/
        if ( substr($gzData, 0, 3) == "\x1f\x8b\x08" ) {
            $i = 10;
            $flg = ord( substr($gzData, 3, 1) );
            if ( $flg > 0 ) {
                if ( $flg & 4 ) {
                    list($xlen) = unpack('v', substr($gzData, $i, 2) );
                    $i = $i + 2 + $xlen;
                }
                if ( $flg & 8 )
                    $i = strpos($gzData, "\0", $i) + 1;
                if ( $flg & 16 )
                    $i = strpos($gzData, "\0", $i) + 1;
                if ( $flg & 2 )
                    $i = $i + 2;
            }
            return @gzinflate( substr($gzData, $i, -8) );
        } else {
            return false;
        }
    }

    private $baseUrl;
};


function encodeJSON ($a=false) {
    if (is_null($a)) return 'null';
    if ($a === false) return 'false';
    if ($a === true) return 'true';
    if (is_scalar($a)) {
        if (is_float($a)) {
            // Always use "." for floats.
            return floatval(str_replace(",", ".", strval($a)));
        }

        if (is_string($a)) {
            static $jsonReplaces = array(array("\\", "/", "\n", "\t", "\r", "\b", "\f", '"'), array('\\\\', '\\/', '\\n', '\\t', '\\r', '\\b', '\\f', '\"'));
            return '"' . str_replace($jsonReplaces[0], $jsonReplaces[1], $a) . '"';
        }
        return $a;
    }
    $isList = true;
    for ($i = 0, reset($a); $i < count($a); $i++, next($a)) {
        if (key($a) !== $i) {
            $isList = false;
            break;
        }
    }
    $result = array();
    if ($isList) {
        foreach ($a as $v) $result[] = encodeJSON($v);
        return '[' . join(',', $result) . ']';
    }
    foreach ($a as $k => $v) $result[] = encodeJSON($k) . ':' . encodeJSON($v);
    return '{' . join(',', $result) . '}';
}



function parseParameters () {
    $parameterStr = $_GET['parameters'];
    $parameters = array();
    if (!$parameterStr) {
        $parameterStr = $_POST['parameters'];
    }
    if ($parameterStr) {
        if (get_magic_quotes_gpc()) {
            $parameterStr = stripslashes ($parameterStr);
        }
        $pStr = preg_replace("#(\\\x[0-9A-Fa-f]{2})#e", "chr(hexdec('$1'))", $parameterStr);  // Decode
        $parameterStr = $pStr != null ? $pStr : $parameterStr;
        $parameters = json_decode ($parameterStr, true);
    }
    return $parameters;
}

// function debugLog ($str) {
//     $fp = fopen ("apsona_debug.txt", 'a+');
//     fputs ($fp, $_SERVER['REQUEST_URI'] . ": " . $_SERVER['QUERY_STRING'] . ": " .$str . "\n");
//     fclose ($fp);
// }
?>
