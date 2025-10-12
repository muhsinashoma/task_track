<?php


include "config.php";

$sql = "select * from  tbl_title_subtitle where status = 1";

$result = array();

$res = $con->query($sql);

// echo "<pre>";
// print_r($res);
// echo "</pre>";



if($res ->num_rows>0)
 {
 	while($row = $res ->fetch_assoc()){
 		$result[] = $row;
 	}

 	//print_r($result);

 	//need to change for json so we have to use json_encode(value)

 // echo json_encode($result);
 }


?>



<?php 

//Declaring Class
 
  header("Access-Control-Allow-Origin: *");

  class tileView{
     // public $title;
     // public $subtitle;
     // public $arrvalue;
     public $arrylist;
  }

 $myObj = new tileView;

 $arrvalue =  $result;

 $myObj->arrylist = $arrvalue;

 $myJSON = json_encode($myObj);


 echo $myJSON;


 ?>