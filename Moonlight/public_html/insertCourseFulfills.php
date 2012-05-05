<?php

/*
insertCourseFulfills.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert CourseFulfills

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 7 || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) || empty( $_POST['Area'] ) || empty( $_POST['StartSemester'] ) || empty( $_POST['StartYear'] ) || empty( $_POST['EndSemester'] ) || empty( $_POST['EndYear'] ) )
  $result['error'] = 'Bad data in COURSEFULFILLS';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $Area = $_POST['Area'];
   $StartSemester = $_POST['StartSemester'];
   $StartYear = $_POST['StartYear'];
   $EndSemester = $_POST['EndSemester'];
   $EndYear = $_POST['EndYear'];

   $stmt = "INSERT INTO `CourseFulfills` (`DepartmentID`, `CourseID`, `Area`, `StartSemester`, `StartYear`, `EndSemester`, `EndYear` ) VALUES ( '$DepartmentID', '$CourseID', '$Area', '$StartSemester', '$StartYear', '$EndSemester', `EndYear` );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
