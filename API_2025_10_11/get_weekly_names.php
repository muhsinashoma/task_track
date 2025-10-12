<?php

include "config.php";

//$single_id = $_GET['single_item_id'];

$single_id = empty($_GET["parent_id"])?"3":$_GET["parent_id"];

$sql = "SELECT * FROM tbl_weekly_name where single_item_id = $single_id and  status = 1 ";

//echo $sql;

$result = array();

//print($result);

$res = $con->query($sql);

if($res->num_rows>0)
{
	while ($row = $res->fetch_assoc()) {
		$result[] = $row;
	}
}

?>



<?php

//Declaring Class

 header("Access-Control-Allow-Origin: *");
 
class WeeklyNameList {

	public $weekly_name_list_data;
}

$myObj = new WeeklyNameList;

$myObj ->weekly_name_list_data = $result;

$jsondata = json_encode($myObj);

echo $jsondata;

?>



