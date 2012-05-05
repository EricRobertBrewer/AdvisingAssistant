<?php

/*
getAreasForArea.php
Eric Brewer
4/24/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve Areas For Area

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['Area'] ) ){
  $result['error'] = 'Invalid POST data in AREA';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $Area = $_POST['Area'];
   
   $stmt = mysql_query( "SELECT * FROM `GradRequirement` WHERE `ParentArea` = '$Area'" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
