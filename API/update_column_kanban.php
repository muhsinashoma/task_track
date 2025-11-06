<?php
// ----------------------------------------------
// ✅ Allow CORS (for Flutter / mobile requests)
// ----------------------------------------------
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// ----------------------------------------------
// ✅ Include database connection
// ----------------------------------------------
include 'config.php';

// ----------------------------------------------
// ✅ Handle POST request only
// ----------------------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Retrieve and sanitize inputs
    $id         = mysqli_real_escape_string($con, $_POST['id'] ?? '');
    $title      = mysqli_real_escape_string($con, $_POST['title'] ?? '');
    $edited_at  = date('Y-m-d H:i:s'); // Automatically use current datetime
    $edited_by  = mysqli_real_escape_string($con, $_POST['edited_by'] ?? 'system'); // Default fallback

    // Validate required fields
    if (empty($id) || empty($title)) {
        echo json_encode([
            "success" => false,
            "message" => "Missing required parameters: id or title"
        ]);
        exit;
    }

    // ----------------------------------------------
    // ✅ Perform UPDATE on Kanban columns table
    // ----------------------------------------------
    $sql = "
        UPDATE tbl_task_board
        SET title = '$title',
            edited_at = '$edited_at',
            edited_by = '$edited_by'
        WHERE status=1 and id = '$id'
    ";

    if ($con->query($sql) === TRUE) {
        echo json_encode([
            "success" => true,
            "message" => "Column title updated successfully"
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Database error: " . $con->error
        ]);
    }

    $con->close();

} else {
    // ----------------------------------------------
    // ❌ Invalid request method
    // ----------------------------------------------
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method"
    ]);
}
?>
