<?php

/*
insertStudent.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Student

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 4 || empty( $_POST['StudentID'] ) || empty( $_POST['Name'] ) || empty( $_POST['StartSemester'] ) || empty( $_POST['StartYear'] ) )
  $result['error'] = 'Bad data in STUDENT';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $StudentID = $_POST['StudentID'];
   $Name = $_POST['Name'];
   $StartSemester = $_POST['StartSemester'];
   $StartYear = $_POST['StartYear'];
   $Pattern = $_POST['Pattern'];

   $stmt = "INSERT INTO `Student` (`StudentID`, `Name`, `StartSemester`, `StartYear`, `Pattern` ) VALUES ( '$StudentID', '$Name', '$StartSemester', '$StartYear', '$Pattern' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
