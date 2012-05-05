<?php

/*
deleteTemplate.php
Eric Brewer
4/18/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve Template

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['TemplateID'] ) ){
  $result['error'] = 'Invalid POST data in TEMPLATE';
  print json_encode( $result );
 }
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $TemplateID = $_POST['TemplateID'];
   
   $stmt = mysql_query( "DELETE FROM `Template` WHERE `TemplateID` = $TemplateID;" )
     or die( mysql_error() );
   
   $jsonrows = array();
   while( $row = mysql_fetch_assoc( $stmt ) )
     $jsonrows[] = $row;
   
   print json_encode( $jsonrows );
 }

?>
