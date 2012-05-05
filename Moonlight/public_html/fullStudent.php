<?php

/*
fullStudent.php
Eric Brewer
4/18/12
Kooshesh & Schettler
CS470 - Advanced Software Design Project
Advising Assistant - retrieve Student

*/

mysql_connect( "localhost", "ebrewer", "AliKooshesh" )
  or die( mysql_error() );
mysql_select_db( "ebrewer" )
or die( mysql_error() );

$result = mysql_query( "SELECT * FROM `Student`;" )
  or die( mysql_error() );

$jsonrows = array();
while( $row = mysql_fetch_assoc( $result ) )
  $jsonrows[] = $row;

print json_encode( $jsonrows );

?>
