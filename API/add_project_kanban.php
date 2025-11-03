<?php

include 'config.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// -------------------- Read POST values --------------------
$project_name = isset($_POST['project_name']) ? trim($_POST['project_name']) : '';
$project_owner_name = isset($_POST['project_owner_name']) ? trim($_POST['project_owner_name']) : '';
$contact_number = isset($_POST['contact_number']) ? trim($_POST['contact_number']) : '';
$email_address = isset($_POST['email_address']) ? trim($_POST['email_address']) : '';
$permanent_address = isset($_POST['permanent_address']) ? trim($_POST['permanent_address']) : '';
$created_by = isset($_POST['created_by']) ? trim($_POST['created_by']) : $project_owner_name;
$device_user_id = isset($_POST['device_user_id']) ? trim($_POST['device_user_id']) : '';

// -------------------- Minimal validation --------------------
if (empty($project_name) || empty($project_owner_name) || empty($device_user_id)) {
    echo json_encode(['success' => false, 'error' => 'Missing required fields']);
    exit;
}

// -------------------- Create uploads folder if not exist --------------------
$uploadDir = "uploads/";
if (!file_exists($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

// -------------------- Max file sizes --------------------
$maxImageSize = 5 * 1024 * 1024;   // 5 MB
$maxFileSize  = 20 * 1024 * 1024;  // 20 MB

// -------------------- Handle optional owner image --------------------
$owner_image = NULL;
if (isset($_FILES['owner_image']) && $_FILES['owner_image']['error'] === UPLOAD_ERR_OK) {
    if ($_FILES['owner_image']['size'] > $maxImageSize) {
        echo json_encode(['success' => false, 'error' => 'Owner image exceeds 5 MB']);
        exit;
    }
    $owner_image_name = time() . '_' . basename($_FILES['owner_image']['name']);
    $targetOwnerImage = $uploadDir . $owner_image_name;
    if (move_uploaded_file($_FILES['owner_image']['tmp_name'], $targetOwnerImage)) {
        $owner_image = $owner_image_name;
    } else {
        echo json_encode(['success' => false, 'error' => 'Failed to upload owner image']);
        exit;
    }
}

// -------------------- Handle multiple attached files --------------------
$attached_files_array = [];
if (isset($_FILES['attached_file'])) {
    foreach ($_FILES['attached_file']['tmp_name'] as $key => $tmp_name) {
        if ($_FILES['attached_file']['error'][$key] === UPLOAD_ERR_OK) {
            if ($_FILES['attached_file']['size'][$key] > $maxFileSize) {
                echo json_encode(['success' => false, 'error' => 'Attached file exceeds 20 MB']);
                exit;
            }
            $attached_file_name = time() . '_' . basename($_FILES['attached_file']['name'][$key]);
            $targetAttachedFile = $uploadDir . $attached_file_name;
            if (move_uploaded_file($tmp_name, $targetAttachedFile)) {
                $attached_files_array[] = $attached_file_name;
            } else {
                echo json_encode(['success' => false, 'error' => 'Failed to upload attached file']);
                exit;
            }
        }
    }
}

// Convert attached files array to JSON string to store in DB
$attached_files_json = !empty($attached_files_array) ? json_encode($attached_files_array) : NULL;

// -------------------- Insert into database --------------------
$query = "INSERT INTO tbl_project_details
    (project_name, project_owner_name, owner_image, attached_file, contact_number, email_address, permanent_address, created_by, created_at, status, device_user_id)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 1, ?)";

if ($stmt = $con->prepare($query)) {
    $stmt->bind_param(
        "sssssssss",
        $project_name,
        $project_owner_name,
        $owner_image,
        $attached_files_json,  // store as JSON string
        $contact_number,
        $email_address,
        $permanent_address,
        $created_by,
        $device_user_id
    );

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'id' => $con->insert_id]);
    } else {
        echo json_encode(['success' => false, 'error' => $stmt->error]);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'error' => 'Prepare failed']);
}

$con->close();




// add_project_kanban.php
// include 'config.php';
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: POST, OPTIONS");
// header("Access-Control-Allow-Headers: Content-Type, Authorization");
// header("Content-Type: application/json");

// // Read POST values (form-data)
// $project_name = isset($_POST['project_name']) ? trim($_POST['project_name']) : '';
// $project_owner_name = isset($_POST['project_owner_name']) ? trim($_POST['project_owner_name']) : '';
// $contact_number = isset($_POST['contact_number']) ? trim($_POST['contact_number']) : '';
// $email_address = isset($_POST['email_address']) ? trim($_POST['email_address']) : '';
// $permanent_address = isset($_POST['permanent_address']) ? trim($_POST['permanent_address']) : '';
// $created_by = isset($_POST['created_by']) ? trim($_POST['created_by']) : $project_owner_name;
// $device_user_id = isset($_POST['device_user_id']) ? trim($_POST['device_user_id']) : '';

// // minimal validation
// if (empty($project_name) || empty($project_owner_name) || empty($device_user_id)) {
//     echo json_encode(['success' => false, 'error' => 'Missing required fields']);
//     exit;
// }


// $uploadDir = "uploads/";
// if (!file_exists($uploadDir)) {
//     mkdir($uploadDir, 0777, true); // Create folder if it doesn't exist
// }

// // Optional owner image
// $owner_image = NULL;
// if (isset($_FILES['owner_image']) && $_FILES['owner_image']['error'] === UPLOAD_ERR_OK) {
//     $owner_image_name = time() . '_' . basename($_FILES['owner_image']['name']);
//     $targetOwnerImage = $uploadDir . $owner_image_name;
//     if (move_uploaded_file($_FILES['owner_image']['tmp_name'], $targetOwnerImage)) {
//         $owner_image = $owner_image_name;
//     }
// }

// // Optional attached file
// $attached_file = NULL;
// if (isset($_FILES['attached_file']) && $_FILES['attached_file']['error'] === UPLOAD_ERR_OK) {
//     $attached_file_name = time() . '_' . basename($_FILES['attached_file']['name']);
//     $targetAttachedFile = $uploadDir . $attached_file_name;
//     if (move_uploaded_file($_FILES['attached_file']['tmp_name'], $targetAttachedFile)) {
//         $attached_file = $attached_file_name;
//     }
// }



// // Prepare query
// $query = "INSERT INTO tbl_project_details
//     (project_name, project_owner_name, owner_image, attached_file, contact_number, email_address, permanent_address, created_by, created_at, status, device_user_id)
//     VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 1, ?)";

// if ($stmt = $con->prepare($query)) {
//     $stmt->bind_param(
//         "sssssssss",
//         $project_name,
//         $project_owner_name,
//         $owner_image,
//         $attached_file,
//         $contact_number,
//         $email_address,
//         $permanent_address,
//         $created_by,
//         $device_user_id
//     );

//     if ($stmt->execute()) {
//         echo json_encode(['success' => true, 'id' => $con->insert_id]);
//     } else {
//         echo json_encode(['success' => false, 'error' => $stmt->error]);
//     }
//     $stmt->close();
// } else {
//     echo json_encode(['success' => false, 'error' => 'Prepare failed']);
// }

// $con->close();
?>
