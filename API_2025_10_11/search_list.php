<?php
include "config.php";

//$sql = "SELECT * FROM `tbl_title_subtitle` WHERE `title` LIKE 'Weekly Name' ORDER BY `id` ASC";

$sql = "SELECT * FROM `tbl_title_subtitle` ";

$result = array();

//echo $result;

$res = $con->query($sql);

//echo $res;

if($res->num_rows>0){
	while($row = $res->fetch_assoc()){
          $result[] = $row;
	}
}

?>

<?php

//Declaring Class

header("Access-Control-Allow-Origin: *");

class AllSearchList{
	public $search_list;
}

$objdata = new AllSearchList;

$objdata ->search_list = $result;

$jsondata = json_encode($objdata);

echo $jsondata;



?>




