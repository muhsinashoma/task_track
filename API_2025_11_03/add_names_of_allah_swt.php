<?php

 //header("Access-Control-Allow-Origin: *");

include 'config.php';

$single_item_id = $_POST['single_item_id'];
$arabic_name = $_POST['arabic_name'];
$english_meaning = $_POST['english_meaning'];
$name_of_allah_swt = $_POST['name_of_allah_swt'];
$bangoli_meaning = $_POST['bangoli_meaning'];
$created_by = $_POST['created_by'];
$created_at = $_POST['created_at'];

$sql = "INSERT INTO tbl_name_of_allah_swt(single_item_id, arabic_name, english_meaning, name_of_allah_swt,bangoli_meaning, status,created_by,created_at) VALUES('".$single_item_id."', '".$arabic_name."', '".$english_meaning."', '".$name_of_allah_swt."'  , '".$bangoli_meaning."', '1', '".$created_by."', '".$created_at."')";

	//echo $sql;
$con->query($sql);

?>