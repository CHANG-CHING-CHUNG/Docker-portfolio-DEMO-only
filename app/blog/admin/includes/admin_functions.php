<?php

$topic_id = 0;
$isEditingTopic = false;
$topic_name = "";

if (isset($_POST['create_topic'])) {
  createTopic($_POST);
}

if (!empty($_GET['edit-topic'])) {
  $isEditingTopic = true;
  $topic_id = $_GET['edit-topic'];
  editTopic($topic_id);
}

if (isset($_POST['update_topic'])) {
  updateTopic($_POST);
}

if (!empty($_GET['delete-topic'])) {
	$topic_id = (int)$_GET['delete-topic'];
	deleteTopic($topic_id);
}

function getAllTopics() {
  global $conn;
  // $sql = "SELECT * FROM topics";
  $sql = "SELECT * FROM John_blog_topics WHERE is_deleted = 'N'";
  $result = mysqli_query($conn, $sql);
  $topics = mysqli_fetch_all($result, MYSQLI_ASSOC);
  return $topics;
}

function createTopic($request_values) {
  global $conn, $topic_name;
  $topic_name = esc($request_values['topic_name']);
  
  if(empty($topic_name)) {
    header("location: admin.php?errCode=1");
    die("類別名稱不得為空");
  }
  // $topic_check_query = "SELECT * FROM topics WHERE name = '$topic_name' LIMIT 1";
  $topic_check_query = "SELECT * FROM John_blog_topics WHERE name = '$topic_name' LIMIT 1";
  $result = mysqli_query($conn, $topic_check_query);
  if (mysqli_num_rows($result) > 0 ) {
    header("location: admin.php?errCode=2");
    die("該類別已經存在");
  }

  // $query = "INSERT INTO topics (name) VALUES('$topic_name')";
  $query = "INSERT INTO John_blog_topics (name) VALUES('$topic_name')";
  mysqli_query($conn, $query);
  $_SESSION['message'] = "類別創建成功";
  header('location: topics.php');
  exit(0);
}

function editTopic($topic_id) {
  global $conn, $topic_name, $isEditingTopic, $topic_id;

  // $sql = "SELECT * FROM topics WHERE id =$topic_id LIMIT 1";
  $sql = "SELECT * FROM John_blog_topics WHERE id =$topic_id LIMIT 1";
  $result = mysqli_query($conn, $sql);
  $topic = mysqli_fetch_assoc($result);
  $topic_name = $topic['name'];
}

function updateTopic($request_values) {
  global $conn, $topic_name, $topic_id;
  $topic_name = esc($request_values['topic_name']);
  $topic_id = esc($request_values['topic_id']);

  if(empty($topic_name)) {
    header("location: admin.php?errCode=1");
    die("類別名稱不得為空");
  }
  
  // $query = "UPDATE topics SET name = '$topic_name' WHERE id = $topic_id";
  $query = "UPDATE John_blog_topics SET name = '$topic_name' WHERE id = $topic_id";
  mysqli_query($conn, $query);
  $_SESSION['message'] = "類別創建成功";
  header('location: topics.php');
  exit(0);
}

function deleteTopic($topic_id) {
  global $conn;
  // $sql = "DELETE FROM topics WHERE id = $topic_id";
  $sql = "UPDATE John_blog_topics SET is_deleted = 'Y' WHERE id = $topic_id";
  if (mysqli_query($conn, $sql)) {
    $_SESSION['message'] = "已成功刪除該類別";
    header('location: topics.php');
    exit(0);
  } else {
    die(mysqli_error($conn));
  }
}

function esc(String $value) {
  global $conn;

  $val = trim($value);
  $val = mysqli_real_escape_string($conn, $value);

  return $val;
}
?>