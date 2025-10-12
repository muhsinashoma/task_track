<?php

include 'config.php';

// Prepare the main query to get all task boards with status 1
$sql = "SELECT * FROM tbl_task_board WHERE status = 1";
$res = $con->query($sql);

$taskBoards = [];
$columnIds = [];

// Fetch all task boards and initialize the task list for each board
if ($res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        $row['tasks'] = [];
        $taskBoards[$row['id']] = $row;
        $columnIds[] = $row['id'];
    }
}

// Convert columnIds array to a comma-separated string for the next query
$columnIdsStr = implode(',', $columnIds);

// Prepare the query to get tasks for the collected column ids
$sql = "SELECT * FROM tbl_task_name WHERE column_name IN ($columnIdsStr)";
$tasksRes = $con->query($sql);

if ($tasksRes->num_rows > 0) {
    while ($task = $tasksRes->fetch_assoc()) {
        $taskBoards[$task['column_name']]['tasks'][] = $task;
    }
}

// Re-index the task boards array
$taskBoards = array_values($taskBoards);

// Add headers for CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");
header('Content-Type: application/json');

// Encode the response as JSON with pretty print
echo json_encode(['task_boards' => $taskBoards], JSON_PRETTY_PRINT);

?>
