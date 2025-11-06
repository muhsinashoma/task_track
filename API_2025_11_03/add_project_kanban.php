 <?php


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $project_name       = mysqli_real_escape_string($con, $_POST['project_name']);
    $project_owner_name = mysqli_real_escape_string($con, $_POST['project_owner_name']);
    $contact_number     = mysqli_real_escape_string($con, $_POST['contact_number']);
    $email_address      = mysqli_real_escape_string($con, $_POST['email_address']);
    $permanent_address  = mysqli_real_escape_string($con, $_POST['permanent_address']);
    $user_identifier    = mysqli_real_escape_string($con, $_POST['user_identifier']); // 👈 new field
    $created_by         = $project_owner_name;
    $created_at         = date('Y-m-d H:i:s');

    $attached_file = null;
    if (isset($_FILES['attached_file']) && $_FILES['attached_file']['error'] === 0) {
        $uploadDir = "uploads/";
        if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

        $fileName = time() . "_" . basename($_FILES['attached_file']['name']);
        $targetFile = $uploadDir . $fileName;

        if (move_uploaded_file($_FILES['attached_file']['tmp_name'], $targetFile)) {
            $attached_file = $fileName;
        } else {
            echo json_encode(["success"=>false, "message"=>"File upload failed"]);
            exit();
        }
    }

    $stmt = $con->prepare("INSERT INTO tbl_project_details 
        (project_name, project_owner_name, attached_file, contact_number, email_address, permanent_address, created_by, user_identifier, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssssss", $project_name, $project_owner_name, $attached_file, $contact_number, $email_address, $permanent_address, $created_by, $user_identifier, $created_at);

    if ($stmt->execute()) {
        echo json_encode(["success"=>true, "message"=>"Project added successfully", "file"=>$attached_file]);
    } else {
        echo json_encode(["success"=>false, "message"=>"DB Error: ".$stmt->error]);
    }

    $stmt->close();
    $con->close();
} else {
    echo json_encode(["success"=>false, "message"=>"Invalid Request Method"]);
}




// ----------------------------- Start Backup Code--------------------

// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// header("Access-Control-Allow-Headers: Content-Type, Authorization");

// include 'config.php';

// if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
//     http_response_code(200);
//     exit();
// }

// if ($_SERVER['REQUEST_METHOD'] == 'POST') {
//     // Collect form data
//     $project_name       = mysqli_real_escape_string($con, $_POST['project_name']);
//     $project_owner_name = mysqli_real_escape_string($con, $_POST['project_owner_name']);
//     $contact_number     = mysqli_real_escape_string($con, $_POST['contact_number']);
//     $email_address      = mysqli_real_escape_string($con, $_POST['email_address']);
//     $permanent_address  = mysqli_real_escape_string($con, $_POST['permanent_address']);
//     $created_by         = $project_owner_name; // created_by = ownerName
//     $created_at         = date('Y-m-d H:i:s');

//     // File upload
//     $attached_file = null;
//     if (isset($_FILES['attached_file']) && $_FILES['attached_file']['error'] === 0) {
//         $uploadDir = "uploads/";
//         if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

//         $fileName = time() . "_" . basename($_FILES['attached_file']['name']);
//         $targetFile = $uploadDir . $fileName;

//         if (move_uploaded_file($_FILES['attached_file']['tmp_name'], $targetFile)) {
//             $attached_file = $fileName;
//         } else {
//             echo json_encode(["success"=>false, "message"=>"File upload failed"]);
//             exit();
//         }
//     }

//     // Insert into database
//     $stmt = $con->prepare("INSERT INTO tbl_project_details 
//         (project_name, project_owner_name, attached_file, contact_number, email_address, permanent_address, created_by, created_at)
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
//     $stmt->bind_param("ssssssss", $project_name, $project_owner_name, $attached_file, $contact_number, $email_address, $permanent_address, $created_by, $created_at);

//     if ($stmt->execute()) {
//         echo json_encode(["success"=>true, "message"=>"Project added successfully", "file"=>$attached_file]);
//     } else {
//         echo json_encode(["success"=>false, "message"=>"DB Error: ".$stmt->error]);
//     }

//     $stmt->close();
//     $con->close();
// } else {
//     echo json_encode(["success"=>false, "message"=>"Invalid Request Method"]);
// }

// ----------------------------- End Backup Code--------------------
?>



