<?php require_once('config.php'); ?>
<?php require_once( ROOT_PATH . '/includes/public_functions.php')?>
<?php require_once( ROOT_PATH . '/includes/head_section.php'); ?>
  <title>John 的部落格 | 關於我</title>
</head>
<body>
  <div class="page-container">
    <div class="content-wrapper">
      <?php include( ROOT_PATH . '/includes/navbar.php'); ?>
      <div class="container about-container">
        <div class="about-img">
          <img src="./static/images/profile.jpg" alt="about me">
        </div>
        <div class="about-content">
          <div class="about-card">
            <div class="about-header">
              <h1>簡介</h1>
            </div>
            <div class="about-text">
              <p>
                我是 Huli 程式導師第四期的學生，目前在新竹園區工作，
                喜歡重訓、游泳以及愛看恐怖電影，當然，還有閱讀囉。
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <?php include( ROOT_PATH . '/includes/footer.php');?>
  </div>