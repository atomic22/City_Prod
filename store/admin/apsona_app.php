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

include ("apsona_config.php");
require_once ("config.php");
    
class ApsonaApp {

    public function __construct ($languageId, $userId) {
        $this->_languageId = $languageId;
        $this->_userId     = $userId;
        $this->_init();
    }
    public function apsonaURL() {
        return APSONA_BASE_URL;
    }
    
    public function dbConnection () {
        return new MysqlConnection (DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
    }

    public function getPicklistNames () {
        return array_keys ($this->_picklistSQL());
    }

    public function getPicklists ($picklistNamesArray) {
        $dbConnection = $this->dbConnection();
        $picklists = array();
        foreach ($picklistNamesArray as $plName) {
            $pList = $this->getPicklist ($plName, $dbConnection);
            if ($pList != null) {
                $picklists[$plName] = $pList;
            }
        }
        $dbConnection->close();
        return $picklists;
    }


    public function getPicklist ($picklistName, $dbConnection) {
        $sqlArray = $this->_picklistSql ();
        if (!array_key_exists ($picklistName, $sqlArray)) {
            return null; // No such picklist
        }
        $sql = $sqlArray[$picklistName];
        $plArray = $sql != null ? $dbConnection->getPicklistValues ($sql) : null;
        if ($picklistName == "product.stores") {
            $plArray[] = array ("value" => "0", "text" => "Default store"); // OpenCart needs this
        }
        return $plArray;
    }

    private function _picklistSQL () {
        $languageId = $this->_languageId;
        $userId = $this->_userId;
        $pref = DB_PREFIX;
        return array (
            "product.categories"        => "select {$pref}category.category_id, {$pref}category_description.name, ${pref}category.parent_id " .
                " from {$pref}category, {$pref}category_description where  {$pref}category.category_id = {$pref}category_description.category_id " .
                " and  language_id = $languageId order by 2",
            "product.stores"            => "select store_id, name from {$pref}store order by 2",
            "product.stock_status_id"   => "select stock_status_id, name from {$pref}stock_status order by 2",
            "product.tax_class_id"      => "select tax_class_id, title from {$pref}tax_class order by 2",
            "product.length_class_id"   => "select length_class_id, title from {$pref}length_class_description where language_id = $languageId order by 2",
            "product.weight_class_id"   => "select weight_class_id, title from {$pref}weight_class_description where language_id = $languageId order by 2",
            "customer.customer_group_id"   => "select customer_group_id, name from {$pref}customer_group order by 2",
            "order.order_status_id"        => "select order_status_id, name from {$pref}order_status where language_id = $languageId order by 2",
            "address.zone_id"           => "select zone_id, name, code, country_id from {$pref}zone where status = 1 order by 2",
            "address.country_id"        => "select country_id, name, iso_code_2 from {$pref}country where status = 1 order by 2",
            "language"                  => "select language_id, name, code from {$pref}language order by sort_order"
        );
    }

    public function tableNamePrefix() {
        return DB_PREFIX;
    }

    public function storeDashboard ($dashboardJSON) {
        if ($dashboardJSON != "") {
            $dashboardFilePath = DIR_APPLICATION . "apsona_dashboard.js";
            file_put_contents ($dashboardFilePath, "Apsona.dashboard = {" . $dashboardJSON . "};");
        }
    }

    public function clearCache ($tableName) {
        $key = substr ($tableName, strlen (DB_PREFIX));
        $files = glob (DIR_CACHE . 'cache.' . $key . '.*');
        if ($files) {
            foreach ($files as $file) {
                if (file_exists ($file)) {
                    unlink($file);
                }
            }
            clearstatcache();
  	}
    }

    private function _init () {
        $returnValue = false;
        $db = $this->dbConnection();
        $tbl = $db->getMetadata ("apsona_report");
        if (!$tbl || !$tbl['fields']) {
            // Setup hasn't been done yet
            $sql = array (
                "create table apsona_report ( report_id int(11) not null auto_increment, name varchar(200) not null, description varchar(4000), entity_name varchar(64) not null, report_descriptor text, layout_descriptor text, last_run_time_msec integer, created_date timestamp, modified_date timestamp, constraint report_pk primary key (report_id))",
                "create table apsona_filter ( filter_id int(11) not null auto_increment, name varchar (200) not null, description varchar (4000), entity_name varchar(64) not null, filter_condition text, created_date timestamp, modified_date timestamp, constraint filter__pk primary key (filter_id))"
                );
            for ($i = 0; $i < count ($sql); $i++) {
                $db->execute ($sql[$i]);
            }
            $db->execute (file_get_contents (DIR_APPLICATION . "apsona_init_reports.sql"));
            $db->execute (file_get_contents (DIR_APPLICATION . "apsona_init_filters.sql"));
            $linkText = '<!-- Apsona ShopAdmin --><script>$(function () {var a = $("#catalog ul li a"); if (a && a.length) {var href = a[0].getAttribute("href").replace ("route=catalog/category", "route=tool/apsona_sa"); $("#system > ul").append (\'<li><a href="\' + href + \'" target="apsona_window">Apsona ShopAdmin</a></li>\');}});</script>';
            $footerFileStr = file_get_contents (DIR_TEMPLATE . "common/footer.tpl");
            if ($footerFileStr) {
                $position = strpos ($footerFileStr, $linkText);
                if ($position === false) { // Not already there, add it
                    $footerFileStr .= $linkText;
                    rename (DIR_TEMPLATE . "common/footer.tpl", DIR_TEMPLATE . "common/footer.tpl.bak");
                    file_put_contents (DIR_TEMPLATE . "common/footer.tpl", $footerFileStr);
                }
            }
            $returnValue = true;
        }
        $db->close();
        return $returnValue;
    }


    private $_languageId;
    private $_userId;
}

?>
