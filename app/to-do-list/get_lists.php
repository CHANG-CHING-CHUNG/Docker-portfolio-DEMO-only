<?php
require_once("./conn.php");


  function getListsFromTable($id) {
    global $conn;
    $sql = "SELECT id, data FROM John_lists WHERE id = ?";
    if (!$stmt = mysqli_prepare($conn, $sql)) {
      echo mysqli_error($conn);
    }
      mysqli_stmt_bind_param($stmt, "i",$id);
      mysqli_stmt_execute($stmt);
      mysqli_stmt_bind_result($stmt, $id, $data);
      mysqli_stmt_fetch($stmt);
    $dataArr = array("id"=>$id,"data"=>$data);
      echo json_encode($dataArr);
  };
  if (empty($_GET['id'])) {
    echo "There is no data to save.";
    die("There is no data to save.");
  };
  getListsFromTable($_GET['id']);

?>