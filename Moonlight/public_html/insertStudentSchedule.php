<?php

/*
insertStudentSchedule.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert StudentSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 5 || empty( $_POST['StudentID'] ) || empty( $_POST['Semester'] ) || empty( $_POST['Year'] ) || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) )
  $result['error'] = 'Bad data in STUDENTSCHEDULE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $StudentID = $_POST['StudentID'];
   $Semester = $_POST['Semester'];
   $Year = $_POST['Year'];
   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $Custom = $_POST['Custom'];

   $stmt = "INSERT INTO `StudentSchedule` ( `StudentID`, `Semester`, `Year`, `DepartmentID`, `CourseID`, `Custom` ) VALUES ( '$StudentID', '$Semester', '$Year', '$DepartmentID', '$CourseID', '$Custom' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
