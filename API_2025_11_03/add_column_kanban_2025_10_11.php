<?php
header("Access-Control-Allow-Origin: *"); // Allows all origins
header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Allows specific methods
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Allows specific headers

include 'config.php';

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Retrieve and sanitize the input data
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $created_by = mysqli_real_escape_string($con, $_POST['created_by']);

    // Prepare the SQL statement
    $sql = "INSERT INTO tbl_task_board (title, created_by) VALUES ('$title', '$created_by')";

    // Execute the query and check for errors
    if ($con->query($sql) === TRUE) {
        // Success response
        echo json_encode(["success" => true, "message" => "Column added successfully"]);
    } else {
        // Error response
        echo json_encode(["success" => false, "message" => "Error: " . $con->error]);
    }
} else {
    // Invalid request method response
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}

// Close the database connection
$con->close();
?>
