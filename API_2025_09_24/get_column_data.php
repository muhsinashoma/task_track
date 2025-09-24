<?php

include 'config.php';

$sql = ("select * from tbl_task_board where status = 1 ");

$result = [];

$res = $con->query($sql);

if($res->num_rows>0){
  while($row = $res->fetch_assoc()){
    $result[] = $row;
  }

  // In get_column_data.php, add these headers at the top
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization");

  echo json_encode($result);
}

?>

