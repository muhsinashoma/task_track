<?php

include 'config.php';
$title = $_POST['title'];
$sql = ("INSERT INTO tbl_task_board(title) values('$title')");
echo $sql;
$con->query($sql);
?>