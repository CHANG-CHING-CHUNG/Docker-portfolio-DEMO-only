<nav class="navbar">
    <div class="container">
      <a href="<?php echo BASE_URL . 'index.php?page=index';?>" class="navbar-brand">John's <span>Blog</span></a>
      <div class="navbar-links">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item  <?php if($_GET['page'] == "index") { echo "active"; }?>">
            <a href="index.php?page=index" class="nav-link">首頁</a>
          </li>
          <li class="nav-item  <?php if($_GET['page'] == "post_list") { echo "active"; }?>">
            <a href="post_list.php?page=post_list" class="nav-link">文章列表</a>
          </li>
          <li class="nav-item <?php if($_GET['page'] == "topics_area") { echo "active"; }?>">
            <a href="topics_area.php?page=topics_area" class="nav-link">分類專區</a>
          </li>
          <li class="nav-item <?php if($_GET['page'] == "about") { echo "active"; }?>">
            <a href="about.php?page=about" class="nav-link">關於我</a>
          </li>
          <?php if (!empty($_SESSION['user']) && $_SESSION['user']['role'] == "Admin") { ;?>
          <li class="nav-item <?php if($_GET['page'] == "admin") { echo "active"; }?>">
            <a href="admin/admin.php?page=admin" class="nav-link">管理後台</a>
          </li>
          <?php }?>
          <li class="nav-item <?php if($_GET['page'] == "login" || $_GET['page'] == "logout") { echo "active"; }?>">
            <?php if (empty($_SESSION['user'])){?>
              <a href="login.php?page=login" class="nav-link">登入</a>
            <?php } else { ?>
              <a href="logout.php?page=logout" class="nav-link">登出</a>
            <?php }?>
          </li>
        </ul>
      </div>
    </div>
  </nav>
