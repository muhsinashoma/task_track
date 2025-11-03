<?php
include "config.php";
$offset = empty($_GET["offset"])?"0":$_GET["offset"];   //check nullable
$sql = ("SELECT * FROM tbl_name_of_allah_swt WHERE like_status IN ('true') and status IN(1) limit 10 OFFSET $offset");

//echo $sql;

$result = array();
$res = $con->query($sql);

 if($res->num_rows>0){

 	while ($row = $res->fetch_assoc()) {
 		$result[] = $row;
 	}
 }

?>


<?php

//Declaring Class

header("Access-Control-Allow-Origin: *");

class AllFavoriteList {
	
	public $all_favorite_list;
}

$objdata = new AllFavoriteList;

$objdata ->all_favorite_list = $result;

$jsondata = json_encode($objdata);

echo $jsondata;

?>


