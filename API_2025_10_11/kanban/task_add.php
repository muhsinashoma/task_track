<?php

include 'config.php';

$title = $_POST['title'];

$task_status = 1;

$model_name = 1;

$project_name = 1;

$created_at = $_POST['created_at'];

$created_by = $_POST['created_by'];

$sql = "INSERT INTO  tbl_task_name(title, task_status, model_name, project_name, created_at, created_by ) VALUES('$title', '$task_status',  '$model_name', '$project_name',  '$created_at', '$created_by')";

echo $sql;

$con->query($sql);

?>