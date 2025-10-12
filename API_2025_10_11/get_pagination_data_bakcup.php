<?php

include "config.php";

//$single_id = $_GET['single_item_id'];

// $pageNumber = empty($_GET["pageNumber"])?"1":$_GET["pageNumber"];

// $itemPerPage = empty($_GET["itemPerPage"])?"1":$_GET["itemPerPage"];

//$pageNumber = empty($_GET["pageNumber"])?"1":$_GET["pageNumber"];


//echo $pageNumber;

//$itemPerPage = empty($_GET["itemPerPage"])?"1":$_GET["itemPerPage"];

//echo $itemPerPage;

//$offset = ($pageNumber-1) * (($itemPerPage + 1) -1); 

$offset = empty($_GET["offset"])?"0":$_GET["offset"];


// $sql  =  ("SELECT * FROM tbl_title_subtitle limit 5  OFFSET $offset ");

 $sql  =  ("SELECT * FROM tbl_title_subtitle limit 10  OFFSET $offset ");

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
 
class AllPageItemData {

	public $single_page_data;
}

$myObj = new AllPageItemData;

$myObj ->single_page_data = $result;

$jsondata = json_encode($myObj);

echo $jsondata;

?>



