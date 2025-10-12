<?php

include "config.php";

$sql = "SELECT COUNT(like_status) FROM `tbl_name_of_allah_swt` WHERE (like_status='true' and status=1 )";

//echo $sql;

$query = $con->query($sql);

$result = $query->fetch_row();

$total_favorite = $result[0];


?>

<?php

//Declaring Class

header("Access-Control-Allow-Origin: *");


class FavoriteCount{
	public $favorite_count;
}

$obj_data["favorite_count"] = $total_favorite;
$obj_data["error"] = false;
$obj_data["message"] = "Data fetched.";

$jsondata = json_encode($obj_data);

echo $jsondata;

?>