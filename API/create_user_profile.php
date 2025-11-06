<?php

// create_user_profile.php
include 'config.php';
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Get POST values (works with application/x-www-form-urlencoded or form-data)
$device_user_id      = isset($_POST['device_user_id']) ? trim($_POST['device_user_id']) : '';
$project_owner_name  = isset($_POST['project_owner_name']) ? trim($_POST['project_owner_name']) : 'New User';
$project_name        = isset($_POST['project_name']) ? trim($_POST['project_name']) : 'My Project';
$contact_number      = isset($_POST['contact_number']) ? trim($_POST['contact_number']) : '';
$email_address       = isset($_POST['email_address']) ? trim($_POST['email_address']) : '';
$permanent_address   = isset($_POST['permanent_address']) ? trim($_POST['permanent_address']) : '';
$created_by          = isset($_POST['created_by']) ? trim($_POST['created_by']) : $project_owner_name;

// basic validation
if (empty($device_user_id)) {
    echo json_encode(['success' => false, 'error' => 'Missing device_user_id']);
    exit;
}

// 1) If a row already exists for this device_user_id -> return its user_id (or id)
try {
    $stmt = $con->prepare("SELECT user_id, id FROM tbl_project_details WHERE device_user_id = ? LIMIT 1");
    $stmt->bind_param("s", $device_user_id);
    $stmt->execute();
    $res = $stmt->get_result();
    if ($row = $res->fetch_assoc()) {
        // If user_id column exists and not empty, return it; otherwise return the row id
        $existingUserId = !empty($row['user_id']) ? $row['user_id'] : $row['id'];
        echo json_encode(['success' => true, 'user_id' => (string)$existingUserId, 'existing' => true]);
        $stmt->close();
        $con->close();
        exit;
    }
    $stmt->close();
} catch (Exception $e) {
    // continue to create new profile if select fails
}

// 2) Create a new persistent user_id (UUID-like)
try {
    // generate a stable unique id (hex of random 16 bytes)
    $user_id = bin2hex(random_bytes(16)); // 32 hex chars

    $query = "INSERT INTO tbl_project_details (
        project_name, project_owner_name, owner_image, contact_number, email_address, permanent_address,
        created_by, created_at, status, device_user_id, user_id
    ) VALUES (?, ?, NULL, ?, ?, ?, ?, NOW(), 1, ?, ?)";

    if ($stmt = $con->prepare($query)) {
        $stmt->bind_param(
            "ssssssss",
            $project_name,
            $project_owner_name,
            $contact_number,
            $email_address,
            $permanent_address,
            $created_by,
            $device_user_id,
            $user_id
        );
        if ($stmt->execute()) {
            $insertId = $con->insert_id;
            echo json_encode([
                'success' => true,
                'user_id' => (string)$user_id,
                'db_id' => $insertId
            ]);
        } else {
            echo json_encode(['success' => false, 'error' => $stmt->error]);
        }
        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'error' => 'Prepare failed']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => 'Server error: ' . $e->getMessage()]);
}

$con->close();



// include 'config.php';
// header("Access-Control-Allow-Origin: *");
// header("Content-Type: application/json");

// $device_user_id = isset($_POST['device_user_id']) ? trim($_POST['device_user_id']) : '';
// $project_owner_name = isset($_POST['project_owner_name']) ? trim($_POST['project_owner_name']) : 'New User';
// $project_name = isset($_POST['project_name']) ? trim($_POST['project_name']) : 'My Project';
// $contact_number = isset($_POST['contact_number']) ? trim($_POST['contact_number']) : '';
// $email_address = isset($_POST['email_address']) ? trim($_POST['email_address']) : '';
// $permanent_address = isset($_POST['permanent_address']) ? trim($_POST['permanent_address']) : '';
// $created_by = isset($_POST['created_by']) ? trim($_POST['created_by']) : $project_owner_name;

// if (empty($device_user_id)) {
//     echo json_encode(['success' => false, 'error' => 'Missing device_user_id']);
//     exit;
// }

// // Generate a persistent user_id
// $user_id = uniqid('user_', true); // or use a UUID library

// $query = "INSERT INTO tbl_project_details (
//     project_name, project_owner_name, owner_image, contact_number, email_address, permanent_address,
//     created_by, created_at, status, device_user_id, user_id
// ) VALUES (?, ?, NULL, ?, ?, ?, ?, NOW(), 1, ?, ?)";

// if ($stmt = $con->prepare($query)) {
//     $stmt->bind_param(
//         "ssssssss",
//         $project_name,
//         $project_owner_name,
//         $contact_number,
//         $email_address,
//         $permanent_address,
//         $created_by,
//         $device_user_id,
//         $user_id
//     );
//     if ($stmt->execute()) {
//         echo json_encode(['success' => true, 'id' => $con->insert_id, 'user_id' => $user_id]);
//     } else {
//         echo json_encode(['success' => false, 'error' => $stmt->error]);
//     }
//     $stmt->close();
// } else {
//     echo json_encode(['success' => false, 'error' => 'Prepare failed']);
// }

// $con->close();




// include 'config.php';
// header("Access-Control-Allow-Origin: *");
// header("Content-Type: application/json");

// // gather POST data (works with application/x-www-form-urlencoded or form-data)
// $device_user_id = isset($_POST['device_user_id']) ? trim($_POST['device_user_id']) : '';
// $project_owner_name = isset($_POST['project_owner_name']) ? trim($_POST['project_owner_name']) : 'New User';
// $project_name = isset($_POST['project_name']) ? trim($_POST['project_name']) : 'My Project';
// $contact_number = isset($_POST['contact_number']) ? trim($_POST['contact_number']) : '';
// $email_address = isset($_POST['email_address']) ? trim($_POST['email_address']) : '';
// $permanent_address = isset($_POST['permanent_address']) ? trim($_POST['permanent_address']) : '';
// $created_by = isset($_POST['created_by']) ? trim($_POST['created_by']) : $project_owner_name;

// if (empty($device_user_id)) {
//     echo json_encode(['success' => false, 'error' => 'Missing device_user_id']);
//     exit;
// }

// $query = "INSERT INTO tbl_project_details (
//     project_name, project_owner_name, owner_image, contact_number, email_address, permanent_address,
//     created_by, created_at, status, device_user_id
// ) VALUES (?, ?, NULL, ?, ?, ?, ?, NOW(), 1, ?)";

// if ($stmt = $con->prepare($query)) {
//     $stmt->bind_param("sssssss", $project_name, $project_owner_name, $owner_image, $contact_number, $email_address, $permanent_address, $created_by, $device_user_id);
//     $exec = $stmt->execute();
//     if ($exec) {
//         $insertId = $con->insert_id;
//         echo json_encode(['success' => true, 'id' => $insertId]);
//     } else {
//         echo json_encode(['success' => false, 'error' => $stmt->error]);
//     }
//     $stmt->close();
// } else {
//     echo json_encode(['success' => false, 'error' => 'Prepare failed']);
// }

// $con->close();
?>
