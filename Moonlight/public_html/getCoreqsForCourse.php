<?php

/*
getCoreqsForCourse.php
Eric Brewer
4/24/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve Corequisites For Course

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 2 || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) ){
  $result['error'] = 'Invalid POST data in COREQUISITE';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   
   $stmt = mysql_query( "SELECT c.DepartmentID, c.CourseID, c.Name, c.Description, c.Semester, c.Units FROM `Course` AS c JOIN `Corequisite` AS p WHERE c.DepartmentID = p.CoreqDeptID AND c.CourseID = p.CoreqCourseID AND p.DepartmentID = '$DepartmentID' AND p.CourseID = '$CourseID';" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
