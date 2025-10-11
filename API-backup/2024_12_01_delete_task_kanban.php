<?php

header('Access-Control-Allow-Origin: *');

include 'config.php';

// Check if 'id' and 'deleted_by' keys exist in the $_POST array
if (isset($_POST['id']) && isset($_POST['deleted_by'])) {
    // Retrieve and sanitize the 'id' and 'deleted_by' values
    $id = $_POST['id'];
    $deleted_by = $_POST['deleted_by'];

    // Ensure the values are not null
    $id = mysqli_real_escape_string($con, $id ?? '');
    $deleted_by = mysqli_real_escape_string($con, $deleted_by ?? '');

    // Prepare the update query
    $sql = "UPDATE tbl_task_name SET status = 0, deleted_by='$deleted_by', deleted_at=NOW() WHERE id = '$id'";

    if ($con->query($sql) === TRUE) {

        $response = json_encode(['status' => 'success', 'message' => 'Record Deleted Successfully']);
        //echo $response;
       // echo json_encode(['status' => 'success', 'message' => 'Record Updated Successfully']);
    } else {
       // echo json_encode(['status' => 'error', 'message' => 'Error updating record: ' . $con->error]);

       $response = json_encode(['status' => 'error', 'message' => 'Error updating record: ' . $con->error]);
    }

    echo ($response);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
}

?>