<?php

/*
getTemplateSchedule.php
Eric Brewer
4/18/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve TemplateSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['TemplateID'] ) ){
  $result['error'] = 'Invalid POST data in TEMPLATESCHEDULE';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $TemplateID = $_POST['TemplateID'];
   
   $stmt = mysql_query( "SELECT * FROM `TemplateSchedule` WHERE `TemplateID` = $TemplateID ORDER BY `Year`, `Semester`;" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
