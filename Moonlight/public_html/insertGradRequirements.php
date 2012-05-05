<?php

/*
insertGradRequirements.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert GradRequirements

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 7 || empty( $_POST['MajorID'] ) || empty( $_POST['Area'] ) || empty( $_POST['Units'] ) || empty( $_POST['StartSemester'] ) || empty( $_POST['StartYear'] ) || empty( $_POST['EndSemester'] ) || empty( $_POST['EndYear'] ) )
  $result['error'] = 'Bad data in GRADREQUIREMENTS';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $MajorID = $_POST['MajorID'];
   $Area = $_POST['Area'];
   $Units = $_POST['Units'];
   $StartSemester = $_POST['StartSemester'];
   $StartYear = $_POST['StartYear'];
   $EndSemester = $_POST['EndSemester'];
   $EndYear = $_POST['EndYear'];

   $stmt = "INSERT INTO `GradRequirements` (`MajorID`, `Area`, `Units`, `StartSemester`, `StartYear`, `EndSemester`, `EndYear` ) VALUES ( '$MajorID', '$Area', '$Units', '$StartSemester', '$StartYear', '$EndSemester', `EndYear` );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
