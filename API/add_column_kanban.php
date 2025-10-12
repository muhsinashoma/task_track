<?php
// header("Access-Control-Allow-Origin: *"); // Allows all origins
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Allows specific methods
// header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Allows specific headers

// include 'config.php';

// // Check if the request method is POST
// if ($_SERVER['REQUEST_METHOD'] == 'POST') {
//     // Retrieve and sanitize the input data
//     $title = mysqli_real_escape_string($con, $_POST['title']);
//     $created_by = mysqli_real_escape_string($con, $_POST['created_by']);

//     // Prepare the SQL statement
//     $sql = "INSERT INTO tbl_task_board (title, created_by) VALUES ('$title', '$created_by')";

//     // Execute the query and check for errors
//     if ($con->query($sql) === TRUE) {
//         // Success response
//         echo json_encode(["success" => true, "message" => "Column added successfully"]);
//     } else {
//         // Error response
//         echo json_encode(["success" => false, "message" => "Error: " . $con->error]);
//     }
// } else {
//     // Invalid request method response
//     echo json_encode(["success" => false, "message" => "Invalid request method"]);
// }

// // Close the database connection
// $con->close();


//------------End Backup Code-----------



// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// header("Access-Control-Allow-Headers: Content-Type, Authorization");

// include 'config.php';

// if ($_SERVER['REQUEST_METHOD'] == 'POST') {
//     $title = mysqli_real_escape_string($con, $_POST['title']);
//     $created_by = mysqli_real_escape_string($con, $_POST['created_by']);
//     $user_identifier = mysqli_real_escape_string($con, $_POST['user_identifier']); // 👈 new field

//     $sql = "INSERT INTO tbl_task_board (title, created_by, user_identifier) VALUES ('$title', '$created_by', '$user_identifier')";

//     if ($con->query($sql) === TRUE) {
//         echo json_encode(["success" => true, "message" => "Column added successfully"]);
//     } else {
//         echo json_encode(["success" => false, "message" => "Error: " . $con->error]);
//     }
// } else {
//     echo json_encode(["success" => false, "message" => "Invalid request method"]);
// }

// $con->close();




header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $project_id = mysqli_real_escape_string($con, $_POST['project_id']);
    $user_identifier = mysqli_real_escape_string($con, $_POST['user_identifier']); // 👈 new field

    // 🔍 Fetch project_owner_name from tbl_project_details
    $query = "SELECT project_owner_name FROM tbl_project_details WHERE id = '$project_id' LIMIT 1";
    $result = $con->query($query);

    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $created_by = mysqli_real_escape_string($con, $row['project_owner_name']);
    } else {
        echo json_encode(["success" => false, "message" => "Project not found"]);
        $con->close();
        exit;
    }

    // 🧩 Insert new column into task board
    echo $sql = "INSERT INTO tbl_task_board (title, created_by, user_identifier, project_id)
            VALUES ('$title', '$created_by', '$user_identifier', '$project_id')";

    if ($con->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Column added successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error: " . $con->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}

$con->close();




?>
