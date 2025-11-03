<?php


// get_user_profile_kanban.php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

$device_user_id = isset($_GET['device_user_id']) ? trim($_GET['device_user_id']) : '';

if (empty($device_user_id)) {
    echo json_encode(["success" => false, "message" => "Missing device_user_id"]);
    exit;
}

// Fetch latest row for this device
$sql = "SELECT id, project_name, project_owner_name, owner_image, attached_file,
               contact_number, email_address, permanent_address, created_by, created_at,
               device_user_id, user_id
        FROM tbl_project_details
        WHERE device_user_id = ?
        ORDER BY id DESC
        LIMIT 1";

if ($stmt = $con->prepare($sql)) {
    $stmt->bind_param("s", $device_user_id);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        // return consistent shape
        echo json_encode(["success" => true, "data" => $row]);
    } else {
        echo json_encode(["success" => false, "message" => "No profile found"]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Prepare failed: " . $con->error]);
}

$con->close();





?>
