<?php
  $servername = "docker-mysql";
  $username = "test";
  $password = "";
  $dbname = "mtr04group2";

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $conn->query("SET NAMES utf8mb4");
  $conn->query('SET time_zone = "+8:00"');

?>