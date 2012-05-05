<?php

/*
getAreasForDepartment.php
Eric Brewer
4/24/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve AreasForDepartment

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['DepartmentID'] ) ){
  $result['error'] = 'Invalid POST data in DEPARTMENT';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $DepartmentID = $_POST['DepartmentID'];
   
   $stmt = mysql_query( "SELECT * FROM GradRequirement r WHERE r.Area IN (SELECT a.`Area` FROM `MajorArea` a WHERE a.`MajorID` IN ( SELECT m.`MajorID` FROM `Major` m WHERE m.`DepartmentID` = '$DepartmentID' ))" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
