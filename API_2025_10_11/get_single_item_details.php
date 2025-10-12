<?php

include "config.php";

//$single_id = $_GET['single_item_id'];

$single_id = empty($_GET["parent_id"])?"1":$_GET["parent_id"];

$sql = "SELECT * FROM tbl_name_of_allah_swt where single_item_id = $single_id and  status = 1 ";

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
 
class AllSingleItemData {

	public $all_single_item_list;
}

$myObj = new AllSingleItemData;

$myObj ->all_single_item_list = $result;

$jsondata = json_encode($myObj);

echo $jsondata;

?>



