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

// Fetch all projects for this user
$sql = "SELECT id, project_name, project_owner_name, owner_image, attached_file,
               contact_number, email_address, permanent_address, created_by, created_at,
               device_user_id, user_id
        FROM tbl_project_details
        WHERE device_user_id = ?
        ORDER BY id ASC";  // Remove LIMIT 1 to get all projects

if ($stmt = $con->prepare($sql)) {
    $stmt->bind_param("s", $device_user_id);
    $stmt->execute();
    $res = $stmt->get_result();

    $projects = [];
    while ($row = $res->fetch_assoc()) {
        // Convert attached_file JSON string to array
        if (!empty($row['attached_file'])) {
            $row['attached_file'] = json_decode($row['attached_file'], true);
        } else {
            $row['attached_file'] = [];
        }
        $projects[] = $row;
    }

    if (!empty($projects)) {
        echo json_encode(["success" => true, "data" => $projects]);
    } else {
        echo json_encode(["success" => false, "message" => "No projects found"]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Prepare failed: " . $con->error]);
}

$con->close();
?>




