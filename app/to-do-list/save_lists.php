<?php
require_once("./conn.php");


  function storeListsToTable($lists) {
    global $conn;
    $sql = "INSERT INTO John_lists (data) VALUES(?)";
    if (!$stmt = mysqli_prepare($conn, $sql)) {
      echo mysqli_error($conn);
    }
    $lists = json_encode($lists);
      mysqli_stmt_bind_param($stmt, "s",$lists);
      mysqli_stmt_execute($stmt);
      $id = mysqli_insert_id($conn);
      echo $id;
  };
  if (empty($_POST['data'][0]['title'])) {
    echo "There is no data to save.";
    die("There is no data to save.");
  };
  storeListsToTable($_POST['data']);

?>