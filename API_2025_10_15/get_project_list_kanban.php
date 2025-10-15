<?php

// include 'config.php';

// // Set CORS headers at the very top
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");

// $sql = "SELECT * FROM tbl_project_details WHERE status = 1 order by id DESC";
// $result = [];
// $res = $con->query($sql);

// if($res->num_rows > 0){
//     while($row = $res->fetch_assoc()){
//         $result[] = $row;
//     }
// }

// // Always echo JSON, even if empty
// echo json_encode($result, JSON_PRETTY_PRINT);





include 'config.php';

// Set CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");

// ---------------- Fetch Projects with Task Count ----------------
// Use LEFT JOIN to include projects even if they have 0 tasks
$sql = "
    SELECT 
        p.id,
        p.project_name,
        p.project_owner_name,
        p.attached_file,
        COUNT(t.id) AS task_count
    FROM tbl_project_details p
    LEFT JOIN tbl_task_name t 
        ON t.project_id = p.id AND t.status = 1
    WHERE p.status = 1
    GROUP BY p.id
    ORDER BY p.id DESC
";

$result = [];
$res = $con->query($sql);

if ($res && $res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        $result[] = $row;
    }
}

// Return JSON
echo json_encode($result, JSON_PRETTY_PRINT);
?>





