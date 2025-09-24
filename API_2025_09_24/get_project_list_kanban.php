<?php

include 'config.php';

// Set CORS headers at the very top
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");

$sql = "SELECT * FROM tbl_project_details WHERE status = 1 order by id DESC";
$result = [];
$res = $con->query($sql);

if($res->num_rows > 0){
    while($row = $res->fetch_assoc()){
        $result[] = $row;
    }
}

// Always echo JSON, even if empty
echo json_encode($result, JSON_PRETTY_PRINT);
?>



