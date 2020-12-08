<?php require_once('config.php'); ?>
<?php require_once( ROOT_PATH . '/includes/public_functions.php')?>
<?php if (!isset($_GET['page'])){ header("location: index.php?page=index"); }?>
<?php $posts = getFiveLatestPosts()?>
<?php require_once( ROOT_PATH . '/includes/head_section.php'); ?>
  <title>John 的部落格 | 首頁</title>
</head>
<body>
  <?php include( ROOT_PATH . '/includes/navbar.php'); ?>
  <?php include( ROOT_PATH . '/includes/banner.php'); ?>
  
  <section class="content">
    <div class="container">
      <div class="row column">
        <?php foreach($posts as $post): ?>
        <div class="case">
          <div class="row">
            <div class="img-box d-flex">
              <a href="single_post.php?id=<?php echo $post['id'];?>" class="img" style="background-image: url(<?php echo BASE_URL . 'static/images/' . $post['image'];?>);"></a>
            </div>
            <div class="text-box d-flex">
              <div class="text">
                <a href="<?php echo BASE_URL . 'filtered_posts.php?topic=' . $post['topic']['id']?>" class="subheading"><?php echo $post['topic']['name'];?></a>
                <h2>
                  <a href="single_post.php?id=<?php echo $post['id'];?>"><?php echo $post['title'];?></a>
                </h2>
                <div class="media-social">
                  <a href="#">
                    <span class="icon-github"></span>
                  </a>
                </div>
                <div class="meta">
                  <span class="date"><?php echo date("F j, Y", strtotime($post['created_at']))?></span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <?php endforeach ?>
      </div>
    </div>
  </section>
  <!-- Footer -->
  <?php include( ROOT_PATH . '/includes/footer.php');?>