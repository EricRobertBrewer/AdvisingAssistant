<?php

/*
getAreasForGEPattern.php
Eric Brewer
4/24/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve AreasForGEPattern

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['Pattern'] ) ){
  $result['error'] = 'Invalid POST data in GEAREA';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $Pattern = $_POST['Pattern'];
   
   $stmt = mysql_query( "SELECT * FROM GradRequirement WHERE `Area` IN(SELECT `Area` FROM `GEArea` WHERE `Pattern` = '$Pattern')" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
