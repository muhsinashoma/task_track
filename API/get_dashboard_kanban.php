<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

include 'config.php';

// 📥 Get parameters
$device_user_id = isset($_REQUEST['device_user_id']) ? mysqli_real_escape_string($con, $_REQUEST['device_user_id']) : '';
$project_id      = isset($_REQUEST['project_id']) ? intval($_REQUEST['project_id']) : 0;

// 🚫 Validation
if (empty($device_user_id)) {
    echo json_encode(["success" => false, "message" => "device_user_id is required"]);
    exit;
}

// ---------------- FETCH ALL PROJECTS FOR DROPDOWN ----------------
$allProjects = [];
$allProjectQuery = "SELECT id, project_name FROM tbl_project_details WHERE device_user_id='$device_user_id'";
$allProjectResult = $con->query($allProjectQuery);
if ($allProjectResult && $allProjectResult->num_rows > 0) {
    while ($p = $allProjectResult->fetch_assoc()) {
        $allProjects[] = $p;
    }
}

// ---------------- FETCH PROJECT(S) FOR DASHBOARD ----------------
$dashboard = [];
$projectQuery = "SELECT id, project_name, project_owner_name, contact_number, email_address, permanent_address
                 FROM tbl_project_details 
                 WHERE device_user_id='$device_user_id'";

if ($project_id > 0) {
    $projectQuery .= " AND id='$project_id'"; // filter by single project
}

$projectsResult = $con->query($projectQuery);

if ($projectsResult && $projectsResult->num_rows > 0) {
    while ($project = $projectsResult->fetch_assoc()) {
        $pid = $project['id'];

        // ---------------- FETCH COLUMNS ----------------
        $columnQuery = "SELECT id, title 
                        FROM tbl_task_board 
                        WHERE project_id='$pid' 
                          AND device_user_id='$device_user_id' 
                          AND status = 1
                        ORDER BY id ASC";
        $columnResult = $con->query($columnQuery);

        $columns = [];
        if ($columnResult && $columnResult->num_rows > 0) {
            while ($column = $columnResult->fetch_assoc()) {
                $cid = $column['id'];

                // ---------------- FETCH TASKS ----------------
                $taskQuery = "SELECT id, title, model_name, created_by, created_at 
                              FROM tbl_task_name 
                              WHERE column_name='$cid' 
                                AND project_id='$pid' 
                                AND device_user_id='$device_user_id' 
                                AND status = 1
                              ORDER BY id DESC";
                $taskResult = $con->query($taskQuery);

                $tasks = [];
                if ($taskResult && $taskResult->num_rows > 0) {
                    while ($task = $taskResult->fetch_assoc()) {
                        $tasks[] = $task;
                    }
                }

                $column['tasks'] = $tasks;
                $columns[] = $column;
            }
        }

        $project['columns'] = $columns;
        $dashboard[] = $project;
    }
}

// Return response
echo json_encode([
    "success" => true,
    "projects" => $allProjects, // for dropdown
    "data" => $dashboard       // Kanban boards
]);

$con->close();
?>
