<?php

include 'config.php';
$title = $_POST['title'];
$created_by = $_POST['created_by'];
$sql = ("INSERT INTO tbl_task_board(title, created_by) values('$title', '$created_by')");
echo $sql;
$con->query($sql);
?>