<?php

/*
insertCorequisite.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Corequisite

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 4 || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) || empty( $_POST['CoreqDeptID'] ) || empty( $_POST['CoreqCourseID'] ) )
  $result['error'] = 'Bad data in COREQUISITE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $CoreqDeptID = $_POST['CoreqDeptID'];
   $CoreqCourseID = $_POST['CoreqCourseID'];

   $stmt = "INSERT INTO `Corequisite` (`DepartmentID`, `CourseID`, `CoreqDeptID`, `CoreqCourseID` ) VALUES ( '$DepartmentID', '$CourseID', '$CoreqDeptID', '$CoreqCourseID' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
