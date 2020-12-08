<?php  include('../config.php'); ?>
<?php if (!isset($_GET['page'])){ header("location: topics.php?page=admin"); }?>
<?php  include(ROOT_PATH . '/admin/includes/admin_functions.php'); ?>
<?php include(ROOT_PATH . '/admin/includes/head_section.php'); ?>
<?php $topics = getAllTopics();	?>
	<title>管理員 | 類別管理</title>
</head>
<body>
	<div class="page-container">
		<div class="content-wrap">
			<?php include(ROOT_PATH . '/admin/includes/navbar.php'); ?>
			
			<?php include(ROOT_PATH . '/admin/includes/header.php') ?>
			<div class="container">
				<?php include(ROOT_PATH . '/admin/includes/menu.php') ?>
		
				<div class="action">
					<h1 class="page-title">新增/編輯 類別</h1>
					<form method="post" action="<?php echo BASE_URL . 'admin/topics.php?page=admin'; ?>" >
						<?php if ($isEditingTopic === true): ?>
							<input type="hidden" name="topic_id" value="<?php echo $topic_id; ?>">
						<?php endif ?>
						<input type="text" name="topic_name" value="<?php echo $topic_name; ?>" placeholder="類別名稱">
						<?php if ($isEditingTopic === true): ?> 
							<button type="submit" class="login-btn" name="update_topic">更新</button>
						<?php else: ?>
							<button type="submit" class="login-btn" name="create_topic">新增</button>
						<?php endif ?>
					</form>
				</div>
		
				<div class="table-box">
					<?php if (empty($topics)): ?>
						<h1>資料庫裡沒有任何類別存在</h1>
					<?php else: ?>
						<table class="users">
							<thead>
								<th>ID</th>
								<th>類別名稱</th>
								<th>編輯</th>
								<th>刪除</th>
							</thead>
							<tbody>
							<?php foreach ($topics as $key => $topic): ?>
								<tr>
									<td><?php echo $key + 1; ?></td>
									<td><?php echo $topic['name']; ?></td>
									<td>
										<a class="fa fa-pencil btn edit"
											href="topics.php?page=admin&edit-topic=<?php echo $topic['id'] ?>">
										</a>
									</td>
									<td>
										<a class="fa fa-trash btn delete"								
											href="topics.php?page=admin&delete-topic=<?php echo $topic['id'] ?>">
										</a>
									</td>
								</tr>
							<?php endforeach ?>
							</tbody>
						</table>
					<?php endif ?>
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
	</div>
</body>
</html>