<?php
  $servername = "docker-mysql";
  $username = "test";
  $password = "";
  $dbname = "mtr04group2";
  
  $conn = mysqli_connect($servername, $username, $password, $dbname);

  if (mysqli_connect_error()) {
    die('Connection failed: ' . mysqli_connect_error());
  }
  mysqli_query($conn,'SET NAMES UTF8');
  mysqli_query($conn,'SET time_zone = "+8:00"');
?>