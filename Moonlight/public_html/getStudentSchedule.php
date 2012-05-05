<?php

/*
getStudentSchedule.php
Eric Brewer
4/18/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve StudentSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['StudentID'] ) ){
  $result['error'] = 'Invalid POST data in STUDENTSCHEDULE';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $StudentID = $_POST['StudentID'];
   
   $stmt = mysql_query( "SELECT * FROM `StudentSchedule` WHERE `StudentID` = $StudentID ORDER BY `Year` ASC, `Semester` DESC;" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
