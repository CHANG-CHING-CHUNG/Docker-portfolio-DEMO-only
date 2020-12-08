<section class="admin-header">
    <div class="container">
      <div class="logo">
        <h1>John's <span class="yellow">Blog</span>- <span class="chinese-font">管理後台<span></h1>
      </div>
      <?php if (!empty($_SESSION['user'])): ?>
        <div class="user-info">
          <span>你好，管理員 <?php echo $_SESSION['user']['nickname']?></span>
        </div>
      <?php endif ?>
    </div>
  </section>