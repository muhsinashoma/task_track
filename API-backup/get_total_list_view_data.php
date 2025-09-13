<?php

include "config.php";

$sql = "SELECT COUNT(id) FROM `tbl_title_subtitle` WHERE status = 1";

//echo $sql;

$query = $con->query($sql);

$result = $query->fetch_row();

$total_data = $result[0];

//echo $total_data;

?>

<?php
header("Access-Control-Allow-Origin: *");

class TotalListData{
	public $total_count;
}

$obj_data["total_count"] = $total_data;

$obj_data['err'] = false;

$obj_data['message'] ="Data Fetched";

$jsondata = json_encode($obj_data);

echo $jsondata;


?>

