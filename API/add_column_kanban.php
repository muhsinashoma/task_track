<?php




header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $project_id = mysqli_real_escape_string($con, $_POST['project_id']);
    $device_user_id = mysqli_real_escape_string($con, $_POST['device_user_id']); // 👈 new field

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
    echo $sql = "INSERT INTO tbl_task_board (title, created_by, device_user_id, project_id)
            VALUES ('$title', '$created_by', '$device_user_id', '$project_id')";

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
