<?php

/*
insertCourse.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Course

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 4 || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) || empty( $_POST['Name'] ) || empty( $_POST['Semester'] ) )
  $result['error'] = 'Bad data in COURSE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $Name = $_POST['Name'];
   $Description = $_POST['Description'];
   $Semester = $_POST['Semester'];
   $Units = $_POST['Units'];

   $stmt = "INSERT INTO `Course` (`DepartmentID`, `CourseID`, `Name`, `Description`, `Semester`, `Units` ) VALUES ( '$DepartmentID', '$CourseID', '$Name', '$Description', '$Semester', '$Units' ) ON DUPLICATE KEY UPDATE `Name` = $Name, `Description` = $Description, `Semester` = $Semester, `Units` = $Units;";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
