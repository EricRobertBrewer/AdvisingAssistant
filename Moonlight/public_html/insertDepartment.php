<?php

/*
insertDepartment.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Department

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 2 || empty( $_POST['DepartmentID'] ) || empty( $_POST['Name'] ) )
  $result['error'] = 'Bad data in DEPARTMENT';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $DepartmentID = $_POST['DepartmentID'];
   $Name = $_POST['Name'];

   $stmt = "INSERT INTO `Department` ( `DepartmentID`, `Name` ) VALUES ( '$DepartmentID', '$Name' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
