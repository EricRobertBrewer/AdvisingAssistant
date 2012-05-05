<?php

/*
insertPrerequisite.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Prerequisite

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 4 || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) || empty( $_POST['PrereqDeptID'] ) || empty( $_POST['PrereqCourseID'] ) )
  $result['error'] = 'Bad data in PREREQUISITE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $PrereqDeptID = $_POST['PrereqDeptID'];
   $PrereqCourseID = $_POST['PrereqCourseID'];

   $stmt = "INSERT INTO `Prerequisite` (`DepartmentID`, `CourseID`, `PrereqDeptID`, `PrereqCourseID` ) VALUES ( '$DepartmentID', '$CourseID', '$PrereqDeptID', '$PrereqCourseID' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
