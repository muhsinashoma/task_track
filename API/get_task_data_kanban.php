<?php
// include 'config.php';

// // Get filter values from query parameters
// $period = isset($_GET['period']) ? intval($_GET['period']) : 1;
// $unit   = isset($_GET['unit']) ? strtolower($_GET['unit']) : "days";

// // Build condition based on filter
// switch ($unit) {
//     case "days":
//         $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period DAY)";
//         break;
//     case "months":
//         $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period MONTH)";
//         break;
//     case "years":
//         $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period YEAR)";
//         break;
//     case "last days":
//         $condition = "DATE(created_at) = DATE(NOW() - INTERVAL $period DAY)";
//         break;
//     case "last months":
//         $condition = "MONTH(created_at) = MONTH(NOW() - INTERVAL $period MONTH)
//                       AND YEAR(created_at) = YEAR(NOW() - INTERVAL $period MONTH)";
//         break;
//     case "last years":
//         $condition = "YEAR(created_at) = YEAR(NOW() - INTERVAL $period YEAR)";
//         break;
//     default:
//         $condition = "created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
// }

// // ---------------- Fetch Boards ----------------
// $sql = "SELECT * FROM tbl_task_board WHERE status = 1";
// $res = $con->query($sql);

// $taskBoards = [];
// $columnIds = [];

// if ($res->num_rows > 0) {
//     while ($row = $res->fetch_assoc()) {
//         $row['tasks'] = [];
//         $taskBoards[$row['id']] = $row;
//         $columnIds[] = $row['id'];
//     }
// }

// $columnIdsStr = $columnIds ? implode(',', $columnIds) : "0";

// // ---------------- Fetch Tasks ----------------
// $sql = "SELECT * 
//         FROM tbl_task_name 
//         WHERE column_name IN ($columnIdsStr) 
//           AND status = 1 
//           AND $condition
//         ORDER BY id DESC";

// $tasksRes = $con->query($sql);

// if ($tasksRes && $tasksRes->num_rows > 0) {
//     while ($task = $tasksRes->fetch_assoc()) {
//         $taskBoards[$task['column_name']]['tasks'][] = $task;
//     }
// }

// // Re-index boards
// $taskBoards = array_values($taskBoards);

// // CORS headers
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");
// header('Content-Type: application/json');

// // Response
// echo json_encode(['task_boards' => $taskBoards]);


// -------------------End Backup------------------------------


include 'config.php';

// Get filter values
$period     = isset($_GET['period']) ? intval($_GET['period']) : 1;
$unit       = isset($_GET['unit']) ? strtolower($_GET['unit']) : "days";
$projectId  = isset($_GET['project_id']) ? intval($_GET['project_id']) : 0; // 👈 NEW

// Build condition
switch ($unit) {
    case "days":
        $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period DAY)";
        break;
    case "months":
        $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period MONTH)";
        break;
    case "years":
        $condition = "created_at >= DATE_SUB(NOW(), INTERVAL $period YEAR)";
        break;
    case "last days":
        $condition = "DATE(created_at) = DATE(NOW() - INTERVAL $period DAY)";
        break;
    case "last months":
        $condition = "MONTH(created_at) = MONTH(NOW() - INTERVAL $period MONTH)
                      AND YEAR(created_at) = YEAR(NOW() - INTERVAL $period MONTH)";
        break;
    case "last years":
        $condition = "YEAR(created_at) = YEAR(NOW() - INTERVAL $period YEAR)";
        break;
    default:
        $condition = "created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
}

// ---------------- Fetch Boards ----------------
$sql = "SELECT * FROM tbl_task_board WHERE status = 1";
$res = $con->query($sql);

$taskBoards = [];
$columnIds = [];

if ($res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        $row['tasks'] = [];
        $taskBoards[$row['id']] = $row;
        $columnIds[] = $row['id'];
    }
}

$columnIdsStr = $columnIds ? implode(',', $columnIds) : "0";

// ---------------- Fetch Tasks ----------------
$sql = "SELECT * 
        FROM tbl_task_name 
        WHERE column_name IN ($columnIdsStr) 
          AND status = 1 
          AND $condition";

if ($projectId > 0) {
    $sql .= " AND project_id = $projectId"; // 👈 filter by project
}

$sql .= " ORDER BY id DESC";

$tasksRes = $con->query($sql);

if ($tasksRes && $tasksRes->num_rows > 0) {
    while ($task = $tasksRes->fetch_assoc()) {
        $taskBoards[$task['column_name']]['tasks'][] = $task;
    }
}

$taskBoards = array_values($taskBoards);

// Response
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");
header('Content-Type: application/json');

echo json_encode(['task_boards' => $taskBoards]);

