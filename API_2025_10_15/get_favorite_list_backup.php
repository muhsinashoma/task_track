<?php

include "config.php";

$sql = "SELECT * FROM tbl_name_of_allah_swt WHERE like_status='true' and status=1 ";

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


