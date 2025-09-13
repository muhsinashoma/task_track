<?php
header("Access-Control-Allow-Origin: *"); // Allows all origins
header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Allows specific methods
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Allows specific headers

include 'config.php';


if($_SERVER['REQUEST_METHOD'] == 'POST'){
      // Retrieve and sanitize the input data
      $title = mysqli_real_escape_string($con, $_POST['title']);
      $column_name = $_POST['column_id'];
      $model_name = $_POST['model_name'];
      $project_name  = $_POST['project_name'];
      $created_by = mysqli_real_escape_string($con, $_POST['created_by']);

      //Prepare the SQL Statement

      $sql = "INSERT INTO tbl_task_name(title,column_name, model_name,project_name,created_by, edited_at) VALUES('$title', '$column_name', '$model_name', '$project_name', '$created_by', NOW())";

      //Execute the query and check for errors

      if($con->query($sql)===TRUE){
        echo json_encode(["success"=>true, "message"=>"Task Added Successfully"]);
      }
      else{

        //Error Response
        echo json_encode(["success"=>false, "message"=>"Error". $con->error]);
      }
} else{
         // Invalid request method response
         echo json_encode(["success"=>false, "message"=>"Invalid Request Method"]);

         //Close Database Connection

         $con->close();
}




?>
