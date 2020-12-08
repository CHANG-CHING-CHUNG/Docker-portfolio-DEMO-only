<?php

$post_id = 0;
$isEditingPost = false;
$title = "";
$body = "";
$featured_image = "";
$post_topic = "";

function getAllPosts(){
  global $conn;

  if ($_SESSION['user']['role'] == 'Admin') {
    // $sql = "SELECT * FROM posts WHERE is_deleted = 0";
    $sql = "SELECT * FROM John_blog_posts WHERE is_deleted = 0";
  }

  $result = mysqli_query($conn, $sql);
  $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

  $final_posts = array();
  foreach ($posts as $post) {
    $post['author'] = getPostAuthorById($post['user_id']);
    array_push($final_posts,$post);
  }

  return $final_posts;
}


function getPostAuthorById($user_id) {
  global $conn;
  // $sql = "SELECT nickname FROM users WHERE id=$user_id";
  $sql = "SELECT nickname FROM John_blog_users WHERE id=$user_id";
  $result = mysqli_query($conn, $sql);
  if ($result) {
    return mysqli_fetch_assoc($result)['nickname'];
  } else {
    return null;
  }
}

if (isset($_POST['create_post'])) {
  createPost($_POST);
}

if (isset($_GET['edit-post'])) {
  $isEditingPost = true;
  $post_id = $_GET['edit-post'];
  editPost($post_id);
}
if (isset($_POST['update_post'])) {
  updatePost($_POST);
}
if (isset($_GET['delete-post'])) {
  $post_id = $_GET['delete-post'];
  deletePost($post_id);
}

function createPost($request_values) {
  global $conn, $title, $featured_image, $topic_id, $body;
  $title = esc($request_values['title']);
  $body = htmlentities(esc($request_values['body']));
  if (isset($request_values['topic_id'])) {
    $topic_id = esc($request_values['topic_id']);
  }

  if (empty($title)) {
    header('location: create_post.php?page=admin&errCode=1');
    die("文章標題不得為空");
  }
  if (empty($body)) {
    header('location: create_post.php?page=admin&errCode=2');
    die("文章內容不得為空");
  }
  if (empty($topic_id)) {
    header('location: create_post.php?page=admin&errCode=3');
    die("文章類別不得為空");
  }
  $featured_image = $_FILES['featured_image']['name'];
  if (empty($featured_image)) {
    header('location: create_post.php?page=admin&errCode=4');
    die("文章圖片不得為空");
  }
  $target = "../static/images/" . basename($featured_image);
  if (!move_uploaded_file($_FILES['featured_image']['tmp_name'], $target)) {
    header('location: create_post.php?page=admin&errCode=5');
    die("圖片上傳失敗，請檢查伺服器設定");
  }

  // $post_check_query = "SELECT * FROM posts WHERE title = '$title'";
  $post_check_query = "SELECT * FROM John_blog_posts WHERE title = '$title'";
  $result = mysqli_query($conn, $post_check_query);

  if (mysqli_num_rows($result) > 0) {
    header('location: create_post.php?page=admin&errCode=6');
    die("同標題的文章已經存在");
  }

  // $query = "INSERT INTO posts (user_id, title, image, body) VALUES(1, '$title', '$featured_image', '$body')";
  $query = "INSERT INTO John_blog_posts (user_id, title, image, body) VALUES(1, '$title', '$featured_image', '$body')";
  if (mysqli_query($conn, $query)) {
    $inserted_post_id = mysqli_insert_id($conn);

    // $sql = "INSERT INTO post_topic (post_id, topic_id) VALUES($inserted_post_id, $topic_id)";
    $sql = "INSERT INTO John_blog_post_topic (post_id, topic_id) VALUES($inserted_post_id, $topic_id)";
    mysqli_query($conn, $sql);

    header('location: posts.php?page=admin');
    exit(0);
  }
}

function editPost($post_id) {
  global $conn, $title, $body;
  // $sql = "SELECT * FROM posts WHERE id = $post_id LIMIT 1";
  $sql = "SELECT * FROM John_blog_posts WHERE id = $post_id LIMIT 1";
  $result = mysqli_query($conn, $sql);
  $post = mysqli_fetch_assoc($result);

  $title = $post['title'];
  $body = $post['body'];
}

function updatePost($request_values) {
  global $conn, $post_id, $title, $featured_image, $topic_id, $body;
  
  $title = esc($request_values['title']);
  $body = esc($request_values['body']);
  $post_id = esc($request_values['post_id']);
  if (isset($request_values['topic_id'])) {
    $topic_id = esc($request_values['topic_id']);
  }

  if (empty($title)) {
    header('location: create_post.php?page=admin&errCode=1');
    die("文章標題不得為空");
  }
  if (empty($body)) {
    header('location: create_post.php?page=admin&errCode=2');
    die("文章內容不得為空");
  }


  $featured_image = $_FILES['featured_image']['name'];
  $target = "../static/images/" . basename($featured_image);
  if ( !empty($featured_image)) {
    if (!move_uploaded_file($_FILES['featured_image']['tmp_name'], $target)) {
      header('location: create_post.php?page=admin&errCode=5');
      die("圖片上傳失敗，請檢查伺服器設定");
    }
  }
  if (empty($featured_image)) {
    // $query = "UPDATE posts SET title = '$title', body = '$body' WHERE id = $post_id";
    $query = "UPDATE John_blog_posts SET title = '$title', body = '$body' WHERE id = $post_id";
  } else {
    // $query = "UPDATE posts SET title = '$title', image = '$featured_image', body = '$body' WHERE id = $post_id";
    $query = "UPDATE John_blog_posts SET title = '$title', image = '$featured_image', body = '$body' WHERE id = $post_id";
  }

  if (mysqli_query($conn, $query)) {
    if (isset($topic_id)) {
      // $sql = "UPDATE post_topic SET topic_id = $topic_id WHERE post_id = $post_id";
      $sql = "UPDATE John_blog_post_topic SET topic_id = $topic_id WHERE post_id = $post_id";
      mysqli_query($conn, $sql);
      header("location: posts.php?page=admin");
      exit(0);
    }
  }
  header("location: posts.php?page=admin");
  exit(0);

}

function deletePost($post_id) {
  global $conn;
  // $sql = "UPDATE posts SET is_deleted = 1 WHERE id = $post_id";
  $sql = "UPDATE John_blog_posts SET is_deleted = 1 WHERE id = $post_id";
  if (mysqli_query($conn, $sql)) {
    header("location: posts.php?page=admin");
    exit(0);
  }
}





?>