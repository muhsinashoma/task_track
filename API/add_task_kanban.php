<?php


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $column_id = mysqli_real_escape_string($con, $_POST['column_id']);
    $model_name = mysqli_real_escape_string($con, $_POST['model_name']);
    $project_id = mysqli_real_escape_string($con, $_POST['project_id']);
    $created_by = mysqli_real_escape_string($con, $_POST['created_by']);
    $device_user_id = mysqli_real_escape_string($con, $_POST['device_user_id']);

    $stmt = $con->prepare(
        "INSERT INTO tbl_task_name (title, column_name, model_name, project_id, created_by, device_user_id) 
         VALUES (?, ?, ?, ?, ?, ?)"
    );
    $stmt->bind_param("ssssss", $title, $column_id, $model_name, $project_id, $created_by, $device_user_id);


    if ($stmt->execute()) {
    echo json_encode(["success" => 1, "message" => "Task Added Successfully"]);
    } else {
        echo json_encode(["success" => 0, "message" => "Error: " . $stmt->error]);
    }


    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid Request Method"]);
}

$con->close();




?>
