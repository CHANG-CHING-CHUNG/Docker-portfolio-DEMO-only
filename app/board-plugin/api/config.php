<?php
  $servername = "docker-mysql";
  $username = "test";
  $password = "";
  $dbname = "mtr04group2";

  $conn = mysqli_connect($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . mysqli_connect_error());
  }

  $conn->query("SET NAMES utf8mb4");
  $conn->query('SET time_zone = "+8:00"');
?>