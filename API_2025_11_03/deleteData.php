<?php

header('Access-Control-Allow-Origin: *');

include "config.php";

$id = $_POST['id'];

$sql = "UPDATE tbl_title_subtitle SET status = 0 WHERE id = '$id'";

echo json_encode($con->query($sql));


?>



