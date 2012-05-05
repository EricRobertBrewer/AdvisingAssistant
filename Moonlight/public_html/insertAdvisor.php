<?php

/*
insertAdvisor.php
Eric Brewer
4/16/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - insert Advisor

*/

$result = array();
$result['success'] = false;

if( count( $_POST ) < 2 || empty( $_POST['Username'] ) || empty( $_POST['Password'] ) )
  $result['error'] = 'Bad data in ADVISOR';
 else{
   mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
     or die( mysql_error() );
   mysql_select_db( "ebrewer" )
     or die( mysql_error() );

   $Username = $_POST['Username'];
   $Password = $_POST['Password'];

   $stmt = "INSERT INTO `Advisor` ( `Username`, `Password` ) VALUES ( '$Username', '$Password' );";
   mysql_query( $stmt )
     or die( mysql_error() );

   $result['success'] = true;
 }

print json_encode( $result );

?>
