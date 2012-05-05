<?php

/*
insertTemplateSchedule.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert TemplateSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 5 || empty( $_POST['TemplateID'] ) || empty( $_POST['Semester'] ) || empty( $_POST['DepartmentID'] ) || empty( $_POST['CourseID'] ) )
  $result['error'] = 'Bad data in TEMPLATESCHEDULE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

	if (!$_POST['Year']) $_POST['Year'] = '0';

   $TemplateID = $_POST['TemplateID'];
   $Semester = $_POST['Semester'];
   $Year = $_POST['Year'];
   $DepartmentID = $_POST['DepartmentID'];
   $CourseID = $_POST['CourseID'];
   $Custom = $_POST['Custom'];

   $stmt = "INSERT INTO `TemplateSchedule` ( `TemplateID`, `Semester`, `Year`, `DepartmentID`, `CourseID`, `Custom` ) VALUES ( '$TemplateID', '$Semester', '$Year', '$DepartmentID', '$CourseID', '$Custom' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
