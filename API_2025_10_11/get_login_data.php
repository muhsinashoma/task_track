<?php

//working perfectly

// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: PUT, GET, POST");
// header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
// header('Content-Type: application/json');

header('Access-Control-Allow-Origin: *');

include "config.php";

$user_name =  $_POST['user_name'];

$password  =  $_POST['password'];

$sql = ("SELECT * FROM tbl_login WHERE user_name='$user_name' and password='$password' and status=1  and (user_type='1' || user_type='2' || user_type='3') ");   

$result = array();

$res = $con->query($sql);


if($res->num_rows>0)
{
	while ($row = $res->fetch_assoc()) {
		$data[] = $row;
	}
    $result['error']=false;
    $result['data'] = $data;
    $result['message']="Username and password correct";
    $result['token']="54dsfdsfsdfsdf5ad4f5sdafsd25f45";
}
else{
    $result['error']=true;
    $result['message']="Username or Password Incorrect";
}

echo json_encode($result);








