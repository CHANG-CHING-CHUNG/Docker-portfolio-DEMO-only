<?php  include('../config.php'); ?>
<?php  include(ROOT_PATH . '/admin/includes/admin_functions.php'); ?>
<?php  include(ROOT_PATH . '/admin/includes/post_functions.php'); ?>
<?php include(ROOT_PATH . '/admin/includes/head_section.php'); ?>
<?php $topics = getAllTopics();	?>
	<title>管理員 | 新增文章</title>
</head>
<body>
  <div class="page-container">
    <div class="content-wraper">
      <?php include(ROOT_PATH . '/admin/includes/navbar.php'); ?>
      <?php include(ROOT_PATH . '/admin/includes/header.php') ?>
    
      <div class="container">
    
        <?php include(ROOT_PATH . '/admin/includes/menu.php') ?>
        
        <div class="action create-post-div">
          <div class="create-post-wrapper">
            <h1 class="page-title">新增/編輯 文章</h1>
            <?php if (!empty($_GET['errCode']) && $_GET['errCode'] > 0 && $_GET['errCode'] < 7) { ?>
              <?php
                $error;
                if ($_GET['errCode'] == "1") {
                  $error = "文章標題不得為空";
                } else if ($_GET['errCode'] == "2"){
                  $error = "文章內容不得為空";
                } else if ($_GET['errCode'] == "3"){
                  $error = "文章類別不得為空";
                } else if ($_GET['errCode'] == "4"){
                  $error = "文章圖片不得為空";
                } else if ($_GET['errCode'] == "5"){
                  $error = "圖片上傳失敗，請檢查伺服器設定";
                } else if ($_GET['errCode'] == "6"){
                  $error = "同標題的文章已經存在";
                }
                
              ?>
              <div class="message error validation_errors">
                  <p><?php echo $error ?></p>
              </div>
            <?php }?>
            <form method="post" enctype="multipart/form-data" action="<?php echo BASE_URL . 'admin/create_post.php'; ?>" >
              <?php if ($isEditingPost === true): ?>
                <input type="hidden" name="post_id" value="<?php echo $post_id; ?>">
              <?php endif ?>
      
              <input class="text" type="text" name="title" value="<?php echo $title; ?>" placeholder="標題">
              <div class="upload-img-btn">
                <label style="float: left; margin: 5px auto 5px;">文章圖片</label>
                <label class="create-btn">
                  <input class="file" type="file" name="featured_image" >
                  <i class="fa fa-photo"></i> 上傳圖片
                </label>
              </div>
              <textarea name="body" id="body" cols="30" rows="10"><?php echo $body; ?></textarea>
    
              <div>
                <select name="topic_id">
                  <option value="" selected disabled>選擇類別</option>
                  <?php foreach ($topics as $topic): ?>
                    <option value="<?php echo $topic['id']; ?>">
                      <?php echo $topic['name']; ?>
                    </option>
                  <?php endforeach ?>
                </select>
                <?php if ($isEditingPost === true): ?> 
                  <button type="submit" class="btn" name="update_post">更新</button>
                <?php else: ?>
                  <button type="submit" class="btn" name="create_post">新增文章</button>
                <?php endif ?>
        
              </div>
            </form>
          </div>
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

<script>
  CKEDITOR.replace('body');

</script>