<?php require_once('config.php'); ?>
<?php require_once( ROOT_PATH . '/includes/public_functions.php')?>
<?php 
  $topics = getAllTopics();
?>
<?php require_once( ROOT_PATH . '/includes/head_section.php'); ?>
  <title>John 的部落格 | 分類專區</title>
</head>
<body>
  <div class="page-container">
    <div class="content-wrapper">
      <?php include( ROOT_PATH . '/includes/navbar.php'); ?>
      <?php include( ROOT_PATH . '/includes/banner.php'); ?>
      <div class="topics-area">
          <div class="topics-card">
            <div class="topics-card-header">
              <h1>主題</h1>
            </div>
            <div class="topics-card-content">
              <?php foreach ($topics as $topic): ?>
                <a class="topics-button"
                  href="<?php echo BASE_URL . 'filtered_posts.php?topic=' . $topic['id'] ?>">
                  <?php echo $topic['name']; ?>
                </a> 
              <?php endforeach ?>
            </div>
          </div>
        </div>
    </div>
    <?php include( ROOT_PATH . '/includes/footer.php');?>
  </div>