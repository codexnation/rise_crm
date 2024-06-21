<?php
ini_set('max_execution_time', 300); //300 seconds 
$product = AUDIO_CHAT;
//check requirements
$db = db_connect('default');
$dbprefix = get_db_prefix();

if (!$db->tableExists($dbprefix."projects_audio_version")) {
    $sql = "CREATE TABLE IF NOT EXISTS `projects_audio_version` (
	  	`id` int(11) NOT NULL AUTO_INCREMENT,
	  	`project_id` int(11) NOT NULL,
	  	`version` VARCHAR(255) NOT NULL,
	  	`audio_file` VARCHAR(255) NOT NULL,
	  	`created` datetime DEFAULT NULL,
	  	`updated` datetime DEFAULT NULL,
		`deleted` tinyint DEFAULT '0',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8";
	$sql = str_replace('CREATE TABLE IF NOT EXISTS `', 'CREATE TABLE IF NOT EXISTS `' . $dbprefix, $sql);
	$sql = str_replace('INSERT INTO `', 'INSERT INTO `' . $dbprefix, $sql);
	$sql_explode = explode('--#', $sql);
	foreach ($sql_explode as $sql_query) {
	    $sql_query = trim($sql_query);
	    if ($sql_query) {
	        $db->query($sql_query);
	    }
	}
}

if (!$db->tableExists($dbprefix."projects_audio_comment")) {
    $sql = "CREATE TABLE IF NOT EXISTS `projects_audio_comment` (
	  	`id` int(11) NOT NULL AUTO_INCREMENT,
	  	`project_id` int(11) NOT NULL,
	  	`comment_id` int(11) NOT NULL,
	  	`audio_version`int(11) NOT NULL,
	  	`audio_time` VARCHAR(255) NOT NULL,
	  	`comment` VARCHAR(255) NOT NULL,
	  	`comment_by`int(11) NOT NULL,
	  	`created_at` datetime DEFAULT NULL,
		`deleted` tinyint DEFAULT '0',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8";
	$sql = str_replace('CREATE TABLE IF NOT EXISTS `', 'CREATE TABLE IF NOT EXISTS `' . $dbprefix, $sql);
	$sql = str_replace('INSERT INTO `', 'INSERT INTO `' . $dbprefix, $sql);
	$sql_explode = explode('--#', $sql);
	foreach ($sql_explode as $sql_query) {
	    $sql_query = trim($sql_query);
	    if ($sql_query) {
	        $db->query($sql_query);
	    }
	}
}
$tasks_fields = $db->getFieldNames($dbprefix."tasks");

if (!in_array("audio_time", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_time` VARCHAR(255) NULL";
    $db->query($sql);
}
if (!in_array("audio_v_id", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_v_id` int(11) NOT NULL";
    $db->query($sql);
}
if (!in_array("audio_task_created_at", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_task_created_at` datetime  NULL";

    $db->query($sql);
}
if (!in_array("audio_task_by", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_task_by` int(11) NOT NULL";
    $db->query($sql);
}

$projects_audio_version_fields = $db->getFieldNames($dbprefix."projects_audio_version");

if (!in_array("version", $projects_audio_version_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."projects_audio_version CHANGE `version` `version` VARCHAR(255) NOT NULL";
    $db->query($sql);
}
$projects_audio_comment_fields = $db->getFieldNames($dbprefix."projects_audio_comment");

if (!$db->tableExists($dbprefix."projects_audio_comment_like_unlike")) {
    $sql = "CREATE TABLE IF NOT EXISTS `projects_audio_comment_like_unlike` (
	  	`id` int(11) NOT NULL AUTO_INCREMENT,
	  	`project_id` int(11) NOT NULL,
	  	`audio_version`int(11) NOT NULL,
	  	`rel_id` int(11) NOT NULL,
	  	`staff_id`int(11) NOT NULL,
		`is_like` tinyint DEFAULT '0',
		`type` VARCHAR(255) NOT NULL,
		`deleted` tinyint DEFAULT '0',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8";
	$sql = str_replace('CREATE TABLE IF NOT EXISTS `', 'CREATE TABLE IF NOT EXISTS `' . $dbprefix, $sql);
	$sql = str_replace('INSERT INTO `', 'INSERT INTO `' . $dbprefix, $sql);
	$sql_explode = explode('--#', $sql);
	foreach ($sql_explode as $sql_query) {
	    $sql_query = trim($sql_query);
	    if ($sql_query) {
	        $db->query($sql_query);
	    }
	}
}

$projects_audio_version = $db->getFieldNames($dbprefix."projects_audio_version");
if (!in_array("status", $projects_audio_version)) {
	$sql = "ALTER TABLE ".$dbprefix."projects_audio_version ADD COLUMN `status` enum('1','2','3','4') NOT NULL DEFAULT '1'" ;
    $db->query($sql);
}
if (!in_array("created_by", $projects_audio_version)) {
	$sql = "ALTER TABLE ".$dbprefix."projects_audio_version ADD COLUMN `created_by` int(11) NOT NULL ";
    $db->query($sql);
}
if (!in_array("audio_time_end", $projects_audio_comment_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."projects_audio_comment ADD COLUMN `audio_time_end` VARCHAR(255) NULL";
    $db->query($sql);
}
if (!in_array("audio_time_end", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_time_end` VARCHAR(255) NULL";
    $db->query($sql);
}
if (!in_array("audio_seconds", $projects_audio_comment_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."projects_audio_comment ADD COLUMN `audio_seconds` VARCHAR(255) NULL";
    $db->query($sql);
}
if (!in_array("audio_seconds", $tasks_fields)) {
	$sql = "ALTER TABLE ".$dbprefix."tasks ADD COLUMN `audio_seconds` VARCHAR(255) NULL";
    $db->query($sql);
}