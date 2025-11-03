<?php

    header('Access-Control-Allow-Origin: *');
    include 'config.php';
    $id = $_POST['id'];
    $column_name = $_POST['column_name'];
    $previous_status = $_POST['previous_status'];
    $model_name = $_POST['model_name'];
    $status_change_by = $_POST['status_change_by'];


    date_default_timezone_set("Asia/Dhaka");
    $current_bd_time = date("Y-m-d H:i:s");
    echo $current_bd_time;


    $status_change_time = date("Y-m-d H:i:s");

    $sql = "UPDATE tbl_task_name SET column_name='$column_name', previous_status='$previous_status', model_name='$model_name', status_change_time='$current_bd_time', status_change_by='$status_change_by' WHERE id='$id' and status=1";

    echo $sql;
    // Execute the query and check for errors
    $res = $con->query($sql);

    if ($res) {
        echo json_encode(["success" => true, "message" => "Task Updated Successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error: " . $con->error]);
    }


?>
