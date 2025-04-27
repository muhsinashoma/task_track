<?php

//header('Access-Control-Allow-Origin: *');

header("Access-Control-Allow-Origin: *"); // Allows all origins
header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Allows specific methods
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Allows specific headers


include 'config.php';


if($_SERVER['REQUEST_METHOD'] == 'POST'){

    echo '----------------------Edit PHP---------------';
    
    // Retrieve and sanitize the 'id', 'title', 'edited_at', and 'edited_by' values
    $id = mysqli_real_escape_string($con, $_POST['id'] ?? '');
    $title = mysqli_real_escape_string($con, $_POST['title'] ?? '');
    $edited_at = mysqli_real_escape_string($con, $_POST['edited_at'] ?? '');
    $edited_by = mysqli_real_escape_string($con, $_POST['edited_by'] ?? '');

    $sql = "UPDATE tbl_task_name SET  title='$title', edited_at='$edited_at', edited_by='$edited_by' WHERE id = '$id' and status = 1";  //echo $sql;

    echo $sql;
     if($con->query($sql)===TRUE){
        echo json_encode(["success"=>true, "message"=>"Task Updated Successfully"]);  //Ture Response
      }
      else{
        echo json_encode(["success"=>false, "message"=>"Error". $con->error]);    //Error Response
      }
} else{
         echo json_encode(["success"=>false, "message"=>"Invalid Request Method"]);     // Invalid request method response
         $con->close();    //Close Database Connection
}

?>
