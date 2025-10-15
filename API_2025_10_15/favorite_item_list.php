<?php

include "config.php";

//$single_id = $_GET['id'];

$single_id = empty($_GET['id'])?"1":$_GET['id'];


$sql = ("SELECT * FROM `tbl_name_of_allah_swt` WHERE like_status='$single_id' and status=1");

//echo $sql;

$result = array();

//print($result);

$res = $con ->query($sql);

if($res->num_rows>0){

	while ($row  = $res ->fetch_assoc()) {
		$result[] = $row; 
	}
}


?>


<?php

//Declaring Class
 header("Access-Control-Allow-Origin: *");

 class FavoriteItemList{

 	public $favorite_tiem_list;
 }

  $myObj = new FavoriteItemList;

  $myObj ->favorite_tiem_list = $result;

  $jsondata = json_encode($myObj);

  echo $jsondata;



?>




