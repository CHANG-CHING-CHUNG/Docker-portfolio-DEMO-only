<?php
  require_once('config.php');
  $username;
  $password;
  $errors = array();
  if (!empty($_POST['username']) && !empty($_POST['password'])) {
    $username = esc($_POST['username']);
    $password = esc($_POST['password']);
  }

  if (empty($_POST['username']) || empty($_POST['password'])) {
    array_push($errors, "帳號及密碼不得為空");
    header('location: ' . BASE_URL . 'login.php?page=login&errCode=2');
    die("帳號及密碼不得為空");
  }

  if (empty($errors)) {
    $user = getUser($username, $password);
    if($user) {
      $_SESSION['user'] = $user;

      if (in_array($_SESSION['user']['role'], ["Admin", "Author"])) {
        $_SESSION['message'] = "登入成功";
        header('location: ' . BASE_URL . 'admin/admin.php');
        exit(0);
      }
    } else {
      header('location: ' . BASE_URL . 'login.php?page=login&errCode=1');
      die("帳號或密碼錯誤");
    }
  } else {
    header('location: ' . BASE_URL . 'login.php?page=login&errCode=1');
    die("帳號及密碼不得為空");
  }

  function esc(String $value) {
    global $conn;

    $val = trim($value);
    $val = mysqli_real_escape_string($conn, $value);

    return $val;
  }

  function getUser($username, $password) {
    global $conn;
    $sql = "SELECT * FROM John_blog_users WHERE username='$username' and password='$password'";

    $result = mysqli_query($conn, $sql);
    $user = mysqli_fetch_assoc($result);
    
    return $user;
  }
?>