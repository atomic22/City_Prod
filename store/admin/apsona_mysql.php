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



class MysqlResultSet {
    public function __construct ($qResult) {
        $this->qResult = $qResult;
        $index = 0;
    }

    public function close () {
        mysql_free_result ($this->qResult);
    }

    public function next() {
        return mysql_fetch_row ($this->qResult);
    }

    public function fieldCount() {
        return mysql_num_fields ($this->qResult);
    }

    public function fieldName ($i) {
        return mysql_field_name ($this->qResult, $i);
    }

    public function seekTo ($i) {
        return mysql_data_seek ($this->qResult, $i);
    }
    
    private $qResult;
    private $index;
};


class MysqlConnection extends AbstractDbConnection {

    public function __construct ($hostName, $userName, $password, $databaseName) {
        $this->connection = mysql_connect ($hostName, $userName, $password);
        mysql_select_db ($databaseName, $this->connection);
        mysql_query('SET NAMES "utf8"', $this->connection);
        mysql_query("set sql_big_selects=1", $this->connection);
        mysql_query('SET group_concat_max_len = 100000', $this->connection);
    }


    public function quotedTableName ($tableName) { // Override inherited method for MySQL
        return "`$tableName`";
    }

    public function getTableNames() {
        $result = mysql_query ("show tables", $this->connection);
        if ($result) {
            $output = array();
            while ($row = mysql_fetch_array($result)) {
                $output[] = $row[0];
            }
            mysql_free_result ($result);
        }
        return $output;            
    }

    
    public function getMetadata ($tableName) {
        $cols = mysql_query ("show columns from `$tableName`", $this->connection);
        if ($cols) {
            $output = array();
            $fields = array();
            while ($col = mysql_fetch_assoc ($cols)) {
                $colName = strtolower ($col["Field"]);
                $colType = strtolower ($col["Type"]);
                preg_match ("/([a-zA-Z0-9_]*)(\((.*?)\))?/", $colType, $matches);
                $colType = $this->_apsonaDataType ($matches[1]);
                $size = $matches[3] != null ? $matches[3] : 0;
                $fields[] = array ("fieldId" => $colName, "fieldType" => $colType, "size" => $size, "disallowEmpty" => $col["Null"] == "NO");
                if ($col["Key"] == "PRI") {
                    if ($output["keyColNames"] == null) {
                        $output["keyColNames"] = array();
                    }
                    $output["keyColNames"][] = $colName;
                }
            }
            $output["fields"] = $fields;
            mysql_free_result ($cols);
        }
        return $output;
    }

    
    public function execute ($sqlString) {
        $qResult = mysql_query ($sqlString, $this->connection);
        $queryPrefix = strtolower (substr ($sqlString, 0, 6));
        switch ($queryPrefix) {
        case "select":
            if ($qResult) {
                $fieldNames = array();
                $fieldTypes = array();
                $nFields = mysql_num_fields ($qResult);
                for ($i = 0; $i < $nFields; $i++) {
                    $fieldNames[] = mysql_field_name ($qResult, $i);
                    $fieldTypes[] = mysql_field_type ($qResult, $i);
                }
                return array ("fieldNames" => $fieldNames, "fieldTypes" => $fieldTypes, "recordIterator" => new MysqlResultSet ($qResult), "recordCount" => mysql_num_rows($qResult));
            }
            $err = mysql_error ($this->connection);
            if ($err) {
                // errorLog ($err . "\nSQL was\n" . $sqlString);
                return array ("error" => $err, "sql" => $sqlString);
            }
            return null;

        case "insert":
            return $qResult ? array ("insert_id" => mysql_insert_id ($this->connection)) : array ("error" => mysql_error ($this->connection));

        default:
            return $qResult ? null : array ("error" => mysql_error ($this->connection));
        }
    }


    public function close () {
        if ($this->connection) {
            mysql_close ($this->connection);
        }
    }

};

?>
