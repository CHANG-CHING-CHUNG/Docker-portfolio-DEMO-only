<?php include('../config.php');?>
<?php if (!isset($_GET['page'])){ header("location: admin.php?page=admin"); }?>
<?php if (!isset($_SESSION['user']) && $_SESSION['user']['role'] != "Admin") { header("location:" . BASE_URL . "index.php?page=index"); }?>
<?php include(ROOT_PATH . '/admin/includes/admin_functions.php'); ?>
<?php include(ROOT_PATH . '/admin/includes/post_functions.php'); ?>
<?php include(ROOT_PATH . '/admin/includes/head_section.php'); ?>
  <title>管理員 | 管理後台</title>
</head>
<body>
  <div class="page-container">
    <div class="content-wrap">
      <?php include(ROOT_PATH . '/admin/includes/navbar.php'); ?>
    
      <?php include(ROOT_PATH . '/admin/includes/header.php'); ?>
    
      <div class="container dashboard">
        <div class="stats">
          <a href="posts.php">
            <span>目前總共有 <?php echo count(getAllposts())?> 篇文章</span>
          </a>
        </div>
        <br>
        <div>
          <a  class="admin-btn" href="posts.php">文章管理</a>
        </div>
      </div>
    </div>

    <div class="row admin-footer">
      <div class="footer-text text-center">
        <p>
          Copyright ©2020 All rights reserved
        </p>
      </div>
    </div>
  </div>
</body>
</html>
</body>
<html>