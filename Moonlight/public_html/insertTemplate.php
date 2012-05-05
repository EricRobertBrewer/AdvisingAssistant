<?php

/*
insertTemplate.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Template

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 2 || empty( $_POST['Name'] ) || empty( $_POST['DepartmentID'] ) )
  $result['error'] = 'Bad data in TEMPLATE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $Name = $_POST['Name'];
   $DepartmentID = $_POST['DepartmentID'];
   $Pattern = $_POST['Pattern'];
   
   $stmt = "INSERT INTO `Template` ( `Name`, `DepartmentID`, `Pattern` ) VALUES ( '$Name', '$DepartmentID', '$Pattern' );";
   mysql_query( $stmt )
     or die( mysql_error() );
   
   $result['success'] = true;
 }

print json_encode( $result );

?>
