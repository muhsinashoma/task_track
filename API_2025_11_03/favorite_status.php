<?php


header('Access-Control-Allow-Origin: *');

include "config.php";

$p_id = empty($_GET['p_id'])?"1":$_GET['p_id'];

$sql = ("UPDATE `tbl_name_of_allah_swt` SET `like_status` = IF(`like_status` = 'true', 'false', 'true') WHERE id = '$p_id' and status=1");

echo $sql;

$res = $con->query($sql);

echo json_encode($res);

?>




