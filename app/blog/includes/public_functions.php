<?php

function getAllPosts() {
  global $conn;
  // $sql = "SELECT * FROM posts where is_deleted = 0;";
  $sql = "SELECT * FROM John_blog_posts where is_deleted = 0;";
  $result = mysqli_query($conn, $sql);

  $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

  $final_posts = array();
  foreach ($posts as $post) {
    $post['topic'] = getPostTopic($post['id']);
    array_push($final_posts, $post);
  }
  return $final_posts;
}

function getPostsCount() {
  global $conn;
  // $sql = "SELECT COUNT(id) AS count FROM posts WHERE is_deleted = 0";
  $sql = "SELECT COUNT(id) AS count FROM John_blog_posts WHERE is_deleted = 0";
  $result = mysqli_query($conn, $sql);
  $count = mysqli_fetch_assoc($result);

  return $count['count'];
}

function getPostsByPageNum($page_id) {
  global $conn;
  $offset = ($page_id - 1) * 5;
  // $sql = "SELECT * FROM posts WHERE is_deleted = 0 ORDER BY id DESC LIMIT 5 OFFSET $offset";
  $sql = "SELECT * FROM John_blog_posts WHERE is_deleted = 0 ORDER BY id DESC LIMIT 5 OFFSET $offset";
  $result = mysqli_query($conn, $sql);

  $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

  $final_posts = array();
  foreach ($posts as $post) {
    $post['topic'] = getPostTopic($post['id']);
    array_push($final_posts, $post);
  }
  return $final_posts;
}

function getFiveLatestPosts() {
  global $conn;
  // $sql = "SELECT * FROM posts WHERE is_deleted = 0 ORDER BY id DESC LIMIT 5";
  $sql = "SELECT * FROM John_blog_posts WHERE is_deleted = 0 ORDER BY id DESC LIMIT 5";
  $result = mysqli_query($conn, $sql);
  $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

  $final_posts = array();
  foreach ($posts as $post) {
    $post['topic'] = getPostTopic($post['id']);
    array_push($final_posts, $post);
  }

  return $final_posts;
}

function getPostTopic($post_id) {
  global $conn;
  // $sql = "SELECT * FROM topics WHERE id = (SELECT topic_id FROM post_topic WHERE post_id = $post_id) LIMIT 1";
  $sql = "SELECT * FROM John_blog_topics WHERE id = (SELECT topic_id FROM John_blog_post_topic WHERE post_id = $post_id) LIMIT 1";
  $result = mysqli_query($conn, $sql);
  $topic = mysqli_fetch_assoc($result);
  return $topic;
}

function getAllPostsByTopic($topic_id) {
  global $conn;
  // $sql = "SELECT * FROM posts ps WHERE ps.id IN (SELECT pt.post_id FROM post_topic pt WHERE pt.topic_id = $topic_id GROUP BY pt.post_id HAVING COUNT(1) = 1)";
  $sql = "SELECT * FROM John_blog_posts ps WHERE ps.id IN (SELECT pt.post_id FROM John_blog_post_topic pt WHERE pt.topic_id = $topic_id GROUP BY pt.post_id HAVING COUNT(1) = 1)";
  $result = mysqli_query($conn, $sql);

  $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

  $final_posts = array();
  foreach ($posts as $post) {
    $post['topic'] = getPostTopic($post['id']);
    array_push($final_posts, $post);
  }

  return $final_posts;
}

function getTopicNameById($id) {
  global $conn;
  // $sql = "SELECT name FROM topics WHERE id = $id";
  $sql = "SELECT name FROM John_blog_topics WHERE id = $id";
  $result = mysqli_query($conn, $sql);
  $topic = mysqli_fetch_assoc($result);
  return $topic['name'];
}

function htmlspecial_array(&$variable) {
  foreach ($variable as &$value) {
      if (!is_array($value)) { $value = htmlspecialchars($value); }
      else { htmlspecial_array($value); }
  }
}

function getPost($id) {
  global $conn;
  $post_id = (int) $_GET['id'];
  // $sql = "SELECT * FROM posts WHERE id = $post_id AND is_deleted = 0";
  $sql = "SELECT * FROM John_blog_posts WHERE id = ? AND is_deleted = 0";
  $stmt = mysqli_prepare($conn, $sql);
  mysqli_stmt_bind_param($stmt, "i", $post_id);
  mysqli_stmt_execute($stmt);
  $result = mysqli_stmt_get_result($stmt);

  $post = mysqli_fetch_assoc($result);

  if ($post) {
    $post['topic'] = getPostTopic($post['id']);
  }
  htmlspecial_array($post);
  return $post;
}

function getAllTopics() {
  global $conn;
  // $sql = "SELECT * FROM topics";
  $sql = "SELECT * FROM John_blog_topics WHERE is_deleted = 'N' ";
  $result = mysqli_query($conn, $sql);
  $topics = mysqli_fetch_all($result, MYSQLI_ASSOC);
  return $topics;
}


?>