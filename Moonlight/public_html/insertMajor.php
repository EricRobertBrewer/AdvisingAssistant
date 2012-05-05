<?php

/*
insertMajor.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Major

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 3 || empty( $_POST['MajorID'] ) || empty( $_POST['DepartmentID'] ) || empty( $_POST['Name'] ) )
  $result['error'] = 'Bad data in MAJOR';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $MajorID = $_POST['MajorID'];
   $DepartmentID = $_POST['DepartmentID'];
   $Name = $_POST['Name'];

   $stmt = "INSERT INTO `Major` ( `MajorID`, `DepartmentID`, `Name` ) VALUES ( '$MajorID', '$DepartmentID', '$Name' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
