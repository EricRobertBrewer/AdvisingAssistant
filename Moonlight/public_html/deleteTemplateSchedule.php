<?php

/*
deleteTemplateSchedule.php
Eric Brewer
4/17/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - delete TemplateSchedule

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 1 || empty( $_POST['TemplateID'] ) )
  $result['error'] = 'Bad data in TEMPLATESCHEDULE';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );
   
   $TemplateID = $_POST['TemplateID'];
   
   $stmt = "DELETE FROM `TemplateSchedule` WHERE `TemplateID` = $TemplateID";
   mysql_query( $stmt )
     or die( mysql_error() );
   
   $result['success'] = true;
 }

print json_encode( $result );

?>
