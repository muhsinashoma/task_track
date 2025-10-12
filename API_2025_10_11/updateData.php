<?php

header('Access-Control-Allow-Origin: *');

include "config.php";

$id = $_POST['id'];

$title = $_POST['title'];

$subtitle = $_POST['subtitle'];

$updated_at = $_POST['updated_at'];

$updated_by = $_POST['updated_by'];

$sql = ("UPDATE tbl_title_subtitle SET title = '$title', subtitle='$subtitle', updated_at='$updated_at', updated_by='$updated_by'  WHERE  id ='$id' and status = 1");


$res = $con->query($sql);

echo json_encode($res);



?>