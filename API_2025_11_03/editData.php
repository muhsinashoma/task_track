<?php

header('Access-Control-Allow-Origin: *');

include "config.php";

$id = $_POST['id'];

$title = $_POST['title'];

$subtitle = $_POST['subtitle'];

$sql = ("UPDATE tbl_title_subtitle SET title ='$title', subtitle= '$subtitle' WHERE status = 1 and id ='$id' ");

$res = $con->query($sql);

echo json_encode($res);


?>