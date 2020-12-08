<?php require_once('config.php'); ?>
<?php require_once( ROOT_PATH . '/includes/public_functions.php')?>
<?php 
  if(isset($_GET['id'])) {
    $post = getPost($_GET['id']);
  }
  $topics = getAllTopics();
?>

<?php require_once( ROOT_PATH . '/includes/head_section.php'); ?>

<title><?php echo $post['title']?> | John 的部落格</title>
</head>
<body>
  <!-- Navbar -->
  <?php include( ROOT_PATH . '/includes/navbar.php'); ?>

  <div class="content">
    <div class="container">
      <div class="row content-wrapper">
        <div class="full-post-div">
            <span class="topic"><?php echo $post['topic']['name'];?></span>
            <span class="created-time"><?php echo $post['created_at']?></span>
            <div class="post-img-box">
              <img class="post-img" src="<?php echo BASE_URL . 'static/images/' . $post['image'];?>" alt="">
            </div>
            <h2 class="post-title"><?php echo $post['title']; ?></h2>
            <div class="post-body-div">
              <?php echo html_entity_decode($post['body']); ?>
            </div>
        </div>
        <div class="post-sidebar">
          <div class="card">
            <div class="card-header">
              <h3>主題</h3>
            </div>
            <?php foreach ($topics as $topic): ?>
            <div class="card-content">
                <a 
                  href="<?php echo BASE_URL . 'filtered_posts.php?topic=' . $topic['id'] ?>">
                  <?php echo $topic['name']; ?>
                  <span class="arrow-forward">></span>
                </a> 
              </div>
              <?php endforeach ?>
          </div>
        </div>
      </div>
    </div>
  </div>

 


  <?php include( ROOT_PATH . '/includes/footer.php');?>