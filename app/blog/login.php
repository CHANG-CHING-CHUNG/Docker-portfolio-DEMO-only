<?php require_once('config.php'); ?>
<?php require_once( ROOT_PATH . '/includes/head_section.php'); ?>
  <title>John 的部落格 | 登入</title>
</head>
<body>
  <!-- Navbar -->
  <?php include( ROOT_PATH . '/includes/navbar.php'); ?>

  <!-- Page content -->
  <section class="login">
    <form class="login-div" action="handle_login.php" method="POST">
      <span class="login-form-title">
        管理員登入
      </span>
      <?php if (!empty($_GET['errCode']) && $_GET['errCode'] > 0 && $_GET['errCode'] < 3) { ?>
        <?php
          $error;
          if ($_GET['errCode'] == "1") {
            $error = "帳號或密碼錯誤";
          } else if ($_GET['errCode'] == "2"){
            $error = "帳號及密碼不得為空";
          }
          
        ?>
        <div class="message error validation_errors">
            <p><?php echo $error ?></p>
        </div>
      <?php }?>
      <div class="input-wrapper">
        <i class="fa fa-user input-icon"></i>
        <input type="text" name="username" placeholder="User name" class="input user">
      </div>
      <div class="input-wrapper">
        <i class="fa fa-lock input-icon"></i>
        <input type="password" name="password" placeholder="Password" class="input password">
      </div>
      <div class="from-login-btn-container">
        <button class="login-btn">
          登入
        </button>
      </div>
    </form>
  </section>
  
  <!-- Footer -->
  <?php include( ROOT_PATH . '/includes/footer.php');?>
