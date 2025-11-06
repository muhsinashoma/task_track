<?php
header('Access-Control-Allow-Origin: *');
include 'config.php';

 // $created_by = !'';
 // $created_at =! '';

 if(empty($_POST['user_name']))
{
	$result['error']=true;
    $result['message']="Username is empty";
	exit(json_encode($result));
}
else if(empty($_POST['password']))
{
	$result['error']=true;
    $result['message']="password is empty";
	exit(json_encode($result));
}
else if(empty($_POST['email']))
{
	$result['error']=true;
    $result['message']="email is empty";
	exit(json_encode($result));
}
else if(empty($_POST['mobile']))
{
	$result['error']=true;
    $result['message']="mobile is empty";
	exit(json_encode($result));
}

$user_name = $_POST['user_name'];
$password = $_POST['password'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];


$sql = "INSERT INTO tbl_login (user_name, password, email, mobile, user_type, status, user) VALUES('".$user_name."', '".$password."', '".$email."', '$mobile', '3',  '1',  '".$user_name."')";

//$con->query($sql);


//----------------Backup---------------------
	//echo $sql;
$result = array();

$res = $con->query($sql);

if($res->num_rows>0)
{
	while ($row = $res->fetch_assoc()) {
		$data[] = $row;
	}
    
    $result['error']=false;
    $result['data'] = $data;
    $result['message']="Username and Password Correct";
   // $result['token']="54dsfdsfsdfsdf5ad4f5sdafsd25f45"; 

}
else{
    $result['error']=true;
    $result['message']="Username or Password incorrect";
}

echo json_encode($result);

?>