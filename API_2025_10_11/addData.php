<?php

include 'config.php';

 // $title =! '';
 // $subtitle = !'';
 // $created_by = !'';
 // $created_at =! '';

$title = $_POST['title'];
$subtitle = $_POST['subtitle'];
$created_by = $_POST['created_by'];
$created_at = $_POST['created_at'];

$sql = "INSERT INTO tbl_title_subtitle (title,subtitle,status,created_by,created_at) VALUES('".$title."', '".$subtitle."', '1',  '".$created_by."', '".$created_at."')";

	//echo $sql;
$con->query($sql);

?>