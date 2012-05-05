<?php

/*
deleteStudentSchedule.php
Eric Brewer
4/17/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - delete StudentSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['StudentID'] ) )
  $result['error'] = 'Bad data in STUDENTSCHEDULE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $StudentID = $_POST['StudentID'];
   
   $stmt = "DELETE FROM `StudentSchedule` WHERE `StudentID` = $StudentID";
   mysql_query( $stmt )
     or die( mysql_error() );
   
   $result['success'] = true;
 }

print json_encode( $result );

?>
