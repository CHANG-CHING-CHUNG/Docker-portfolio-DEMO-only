<?php  include('../config.php'); ?>
<?php if (!isset($_GET['page'])){ header("location: posts.php?page=admin"); }?>
<?php  include(ROOT_PATH . '/admin/includes/admin_functions.php'); ?>
<?php  include(ROOT_PATH . '/admin/includes/post_functions.php'); ?>
<?php include(ROOT_PATH . '/admin/includes/head_section.php'); ?>
<?php $posts = getAllPosts(); ?>
	<title>管理員 | 文章管理</title>
</head>
<body>
	<div class="page-container">
		<div class="content-wrap">
			<?php include(ROOT_PATH . '/admin/includes/navbar.php'); ?>
			<?php include(ROOT_PATH . '/admin/includes/header.php') ?>
		
			<div class="container">
				<?php include(ROOT_PATH . '/admin/includes/menu.php') ?>
		
				<div class="table-box center"  style="width: 80%;">
					<?php if (empty($posts)): ?>
						<h1 style="text-align: center; margin-top: 20px;">資料庫裡沒有任何文章存在</h1>
					<?php else: ?>
						<table class="users">
								<thead>
								<th>ID</th>
								<th>作者</th>
								<th>標題</th>
								<th><small>Edit</small></th>
								<th><small>Delete</small></th>
							</thead>
							<tbody>
							<?php foreach ($posts as $key => $post): ?>
								<tr>
									<td><?php echo $key + 1; ?></td>
									<td><?php echo $post['author']; ?></td>
									<td>
										<a 	target="_blank"
										href="<?php echo BASE_URL . 'single_post.php?id=' . $post['id'] ?>">
											<?php echo $post['title']; ?>	
										</a>
									</td>
									<td>
										<a class="fa fa-pencil btn edit"
											href="create_post.php?edit-post=<?php echo $post['id'] ?>">
										</a>
									</td>
									<td>
										<a  class="fa fa-trash btn delete" 
											href="create_post.php?delete-post=<?php echo $post['id'] ?>">
										</a>
									</td>
								</tr>
							<?php endforeach ?>
							</tbody>
						</table>
					<?php endif ?>
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