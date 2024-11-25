<?php

header('Access-Control-Allow-Origin: *');

include "config.php";

$id = $_POST['id'];

$deleted_by = mysqli_real_escape_string($con, $_POST['deleted_by']);

$sql = "UPDATE tbl_task_name SET status = 0, deleted_by='$deleted_by', deleted_at=NOW() WHERE id = '$id'";

echo $sql;


if($con->query($sql)===TRUE){
    $response = array("status"=>"success", "message"=>"Record Updated Successfully");
}else{
    $response = array("status"=>"error", "message"=>"Error Updating Record : ".$con->error);
}

echo json_encode($response);

$con->close();



?>



