-- --------------------------------------------------------
-- Host:                         mentor-program.co
-- Server version:               5.6.49-cll-lve - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for mtr04group2
CREATE DATABASE IF NOT EXISTS `mtr04group2` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mtr04group2`;

-- Dumping structure for table mtr04group2.John_blog_posts
CREATE TABLE IF NOT EXISTS `John_blog_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(64) NOT NULL,
  `image` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table mtr04group2.John_blog_posts: ~2 rows (approximately)
DELETE FROM `John_blog_posts`;
/*!40000 ALTER TABLE `John_blog_posts` DISABLE KEYS */;
INSERT INTO `John_blog_posts` (`id`, `user_id`, `title`, `image`, `body`, `created_at`, `is_deleted`) VALUES
	(18, 1, 'Docker for beginners', 'logo.webp', '<p>Learn to build and deploy your distributed applications easily to the cloud with Docker</p>\r\n\r\n<p>Written and developed by&nbsp;<a href="https://prakhar.me/">Prakhar Srivastav</a></p>\r\n\r\n<h2>INTRODUCTION</h2>\r\n\r\n<h3>What is Docker?</h3>\r\n\r\n<p>Wikipedia defines&nbsp;<a href="https://www.docker.com/">Docker</a>&nbsp;as</p>\r\n\r\n<blockquote>\r\n<p>an open-source project that automates the deployment of software applications inside&nbsp;<strong>containers</strong>&nbsp;by providing an additional layer of abstraction and automation of&nbsp;<strong>OS-level virtualization</strong>&nbsp;on Linux.</p>\r\n</blockquote>\r\n\r\n<p>Wow! That&#39;s a mouthful. In simpler words, Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called&nbsp;<em>containers</em>) to run on the host operating system i.e. Linux. The key benefit of Docker is that it allows users to&nbsp;<strong>package an application with all of its dependencies into a standardized unit</strong>&nbsp;for software development. Unlike virtual machines, containers do not have high overhead and hence enable more efficient usage of the underlying system and resources.</p>\r\n\r\n<h3>What are containers?</h3>\r\n\r\n<p>The industry standard today is to use Virtual Machines (VMs) to run software applications. VMs run applications inside a guest Operating System, which runs on virtual hardware powered by the server&rsquo;s host OS.</p>\r\n\r\n<p>VMs are great at providing full process isolation for applications: there are very few ways a problem in the host operating system can affect the software running in the guest operating system, and vice-versa. But this isolation comes at great cost &mdash; the computational overhead spent virtualizing hardware for a guest OS to use is substantial.</p>\r\n\r\n<p>Containers take a different approach: by leveraging the low-level mechanics of the host operating system, containers provide most of the isolation of virtual machines at a fraction of the computing power.</p>\r\n\r\n<h3>Why use containers?</h3>\r\n\r\n<p>Containers offer a logical packaging mechanism in which applications can be abstracted from the environment in which they actually run. This decoupling allows container-based applications to be deployed easily and consistently, regardless of whether the target environment is a private data center, the public cloud, or even a developer&rsquo;s personal laptop. This gives developers the ability to create predictable environments that are isolated from the rest of the applications and can be run anywhere.</p>\r\n\r\n<p>From an operations standpoint, apart from portability containers also give more granular control over resources giving your infrastructure improved efficiency which can result in better utilization of your compute resources.</p>\r\n\r\n<p><img alt="Docker interest over time" src="https://d33wubrfki0l68.cloudfront.net/7ab09bbf5dbd56cffdddd1ae653395053a985228/7b180/images/interest.png" style="height:364px; width:768px" /></p>\r\n\r\n<p>Google Trends for Docker</p>\r\n\r\n<p>Due to these benefits, containers (&amp; Docker) have seen widespread adoption. Companies like Google, Facebook, Netflix and Salesforce leverage containers to make large engineering teams more productive and to improve utilization of compute resources. In fact, Google credited containers for eliminating the need for an entire data center.</p>\r\n\r\n<h3>What will this tutorial teach me?</h3>\r\n\r\n<p>This tutorial aims to be the one-stop shop for getting your hands dirty with Docker. Apart from demystifying the Docker landscape, it&#39;ll give you hands-on experience with building and deploying your own webapps on the Cloud. We&#39;ll be using&nbsp;<a href="http://aws.amazon.com/">Amazon Web Services</a>&nbsp;to deploy a static website, and two dynamic webapps on&nbsp;<a href="https://aws.amazon.com/ec2/">EC2</a>&nbsp;using&nbsp;<a href="https://aws.amazon.com/elasticbeanstalk/">Elastic Beanstalk</a>&nbsp;and&nbsp;<a href="https://aws.amazon.com/ecs/">Elastic Container Service</a>. Even if you have no prior experience with deployments, this tutorial should be all you need to get started.</p>\r\n\r\n<hr />\r\n<h2>GETTING STARTED</h2>\r\n\r\n<p>This document contains a series of several sections, each of which explains a particular aspect of Docker. In each section, we will be typing commands (or writing code). All the code used in the tutorial is available in the&nbsp;<a href="http://github.com/prakhar1989/docker-curriculum">Github repo</a>.</p>\r\n\r\n<blockquote>\r\n<p>Note: This tutorial uses version&nbsp;<strong>18.05.0-ce</strong>&nbsp;of Docker. If you find any part of the tutorial incompatible with a future version, please raise an&nbsp;<a href="https://github.com/prakhar1989/docker-curriculum/issues">issue</a>. Thanks!</p>\r\n</blockquote>\r\n\r\n<h3>Prerequisites</h3>\r\n\r\n<p>There are no specific skills needed for this tutorial beyond a basic comfort with the command line and using a text editor. This tutorial uses&nbsp;<code>git clone</code>&nbsp;to clone the repository locally. If you don&#39;t have Git installed on your system, either install it or remember to manually download the zip files from Github. Prior experience in developing web applications will be helpful but is not required. As we proceed further along the tutorial, we&#39;ll make use of a few cloud services. If you&#39;re interested in following along, please create an account on each of these websites:</p>\r\n\r\n<ul>\r\n	<li><a href="http://aws.amazon.com/">Amazon Web Services</a></li>\r\n	<li><a href="https://hub.docker.com/">Docker Hub</a></li>\r\n</ul>\r\n\r\n<h3>Setting up your computer</h3>\r\n\r\n<p>Getting all the tooling setup on your computer can be a daunting task, but thankfully as Docker has become stable, getting Docker up and running on your favorite OS has become very easy.</p>\r\n\r\n<p>Until a few releases ago, running Docker on OSX and Windows was quite a hassle. Lately however, Docker has invested significantly into improving the on-boarding experience for its users on these OSes, thus running Docker now is a cakewalk. The&nbsp;<em>getting started</em>&nbsp;guide on Docker has detailed instructions for setting up Docker on&nbsp;<a href="https://docs.docker.com/docker-for-mac/install">Mac</a>,&nbsp;<a href="https://docs.docker.com/install/linux/docker-ce/ubuntu">Linux</a>&nbsp;and&nbsp;<a href="https://docs.docker.com/docker-for-windows/install">Windows</a>.</p>\r\n\r\n<p>Once you are done installing Docker, test your Docker installation by running the following:</p>\r\n\r\n<pre>\r\n<code>$ docker run hello-world\r\n\r\nHello from Docker.\r\nThis message shows that your installation appears to be working correctly.\r\n...</code></pre>\r\n\r\n<hr />\r\n<h2>HELLO WORLD</h2>\r\n\r\n<h3>Playing with Busybox</h3>\r\n\r\n<p>Now that we have everything setup, it&#39;s time to get our hands dirty. In this section, we are going to run a&nbsp;<a href="https://en.wikipedia.org/wiki/BusyBox">Busybox</a>&nbsp;container on our system and get a taste of the&nbsp;<code>docker run</code>&nbsp;command.</p>\r\n\r\n<p>To get started, let&#39;s run the following in our terminal:</p>\r\n\r\n<pre>\r\n<code>$ docker pull busybox</code></pre>\r\n\r\n<blockquote>\r\n<p>Note: Depending on how you&#39;ve installed docker on your system, you might see a&nbsp;<code>permission denied</code>&nbsp;error after running the above command. If you&#39;re on a Mac, make sure the Docker engine is running. If you&#39;re on Linux, then prefix your&nbsp;<code>docker</code>&nbsp;commands with&nbsp;<code>sudo</code>. Alternatively, you can&nbsp;<a href="https://docs.docker.com/engine/installation/linux/linux-postinstall/">create a docker group</a>&nbsp;to get rid of this issue.</p>\r\n</blockquote>\r\n\r\n<p>The&nbsp;<code>pull</code>&nbsp;command fetches the busybox&nbsp;<a href="https://hub.docker.com/_/busybox/"><strong>image</strong></a>&nbsp;from the&nbsp;<a href="https://hub.docker.com/explore/"><strong>Docker registry</strong></a>&nbsp;and saves it to our system. You can use the&nbsp;<code>docker images</code>&nbsp;command to see a list of all images on your system.</p>\r\n\r\n<pre>\r\n<code>$ docker images\r\nREPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE\r\nbusybox                 latest              c51f86c28340        4 weeks ago         1.109 MB</code></pre>\r\n\r\n<h3>Docker Run</h3>\r\n\r\n<p>Great! Let&#39;s now run a Docker&nbsp;<strong>container</strong>&nbsp;based on this image. To do that we are going to use the almighty&nbsp;<code>docker run</code>&nbsp;command.</p>\r\n\r\n<pre>\r\n<code>$ docker run busybox\r\n$</code></pre>\r\n\r\n<p>Wait, nothing happened! Is that a bug? Well, no. Behind the scenes, a lot of stuff happened. When you call&nbsp;<code>run</code>, the Docker client finds the image (busybox in this case), loads up the container and then runs a command in that container. When we run&nbsp;<code>docker run busybox</code>, we didn&#39;t provide a command, so the container booted up, ran an empty command and then exited. Well, yeah - kind of a bummer. Let&#39;s try something more exciting.</p>\r\n\r\n<pre>\r\n<code>$ docker run busybox echo &quot;hello from busybox&quot;\r\nhello from busybox</code></pre>\r\n\r\n<p>Nice - finally we see some output. In this case, the Docker client dutifully ran the&nbsp;<code>echo</code>&nbsp;command in our busybox container and then exited it. If you&#39;ve noticed, all of that happened pretty quickly. Imagine booting up a virtual machine, running a command and then killing it. Now you know why they say containers are fast! Ok, now it&#39;s time to see the&nbsp;<code>docker ps</code>&nbsp;command. The&nbsp;<code>docker ps</code>&nbsp;command shows you all containers that are currently running.</p>\r\n\r\n<pre>\r\n<code>$ docker ps\r\nCONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES</code></pre>\r\n\r\n<p>Since no containers are running, we see a blank line. Let&#39;s try a more useful variant:&nbsp;<code>docker ps -a</code></p>\r\n\r\n<pre>\r\n<code>$ docker ps -a\r\nCONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES\r\n305297d7a235        busybox             &quot;uptime&quot;            11 minutes ago      Exited (0) 11 minutes ago                       distracted_goldstine\r\nff0a5c3750b9        busybox             &quot;sh&quot;                12 minutes ago      Exited (0) 12 minutes ago                       elated_ramanujan\r\n14e5bd11d164        hello-world         &quot;/hello&quot;            2 minutes ago       Exited (0) 2 minutes ago                        thirsty_euclid</code></pre>\r\n\r\n<p>So what we see above is a list of all containers that we ran. Do notice that the&nbsp;<code>STATUS</code>&nbsp;column shows that these containers exited a few minutes ago.</p>\r\n\r\n<p>You&#39;re probably wondering if there is a way to run more than just one command in a container. Let&#39;s try that now:</p>\r\n\r\n<pre>\r\n<code>$ docker run -it busybox sh\r\n/ # ls\r\nbin   dev   etc   home  proc  root  sys   tmp   usr   var\r\n/ # uptime\r\n 05:45:21 up  5:58,  0 users,  load average: 0.00, 0.01, 0.04</code></pre>\r\n\r\n<p>Running the&nbsp;<code>run</code>&nbsp;command with the&nbsp;<code>-it</code>&nbsp;flags attaches us to an interactive tty in the container. Now we can run as many commands in the container as we want. Take some time to run your favorite commands.</p>\r\n\r\n<blockquote>\r\n<p><strong>Danger Zone</strong>: If you&#39;re feeling particularly adventurous you can try&nbsp;<code>rm -rf bin</code>&nbsp;in the container. Make sure you run this command in the container and&nbsp;<strong>not</strong>&nbsp;in your laptop/desktop. Doing this will make any other commands like&nbsp;<code>ls</code>,&nbsp;<code>uptime</code>&nbsp;not work. Once everything stops working, you can exit the container (type&nbsp;<code>exit</code>&nbsp;and press Enter) and then start it up again with the&nbsp;<code>docker run -it busybox sh</code>&nbsp;command. Since Docker creates a new container every time, everything should start working again.</p>\r\n</blockquote>\r\n\r\n<p>That concludes a whirlwind tour of the mighty&nbsp;<code>docker run</code>&nbsp;command, which would most likely be the command you&#39;ll use most often. It makes sense to spend some time getting comfortable with it. To find out more about&nbsp;<code>run</code>, use&nbsp;<code>docker run --help</code>&nbsp;to see a list of all flags it supports. As we proceed further, we&#39;ll see a few more variants of&nbsp;<code>docker run</code>.</p>\r\n\r\n<p>Before we move ahead though, let&#39;s quickly talk about deleting containers. We saw above that we can still see remnants of the container even after we&#39;ve exited by running&nbsp;<code>docker ps -a</code>. Throughout this tutorial, you&#39;ll run&nbsp;<code>docker run</code>&nbsp;multiple times and leaving stray containers will eat up disk space. Hence, as a rule of thumb, I clean up containers once I&#39;m done with them. To do that, you can run the&nbsp;<code>docker rm</code>&nbsp;command. Just copy the container IDs from above and paste them alongside the command.</p>\r\n\r\n<pre>\r\n<code>$ docker rm 305297d7a235 ff0a5c3750b9\r\n305297d7a235\r\nff0a5c3750b9</code></pre>\r\n\r\n<p>On deletion, you should see the IDs echoed back to you. If you have a bunch of containers to delete in one go, copy-pasting IDs can be tedious. In that case, you can simply run -</p>\r\n\r\n<pre>\r\n<code>$ docker rm $(docker ps -a -q -f status=exited)</code></pre>\r\n\r\n<p>This command deletes all containers that have a status of&nbsp;<code>exited</code>. In case you&#39;re wondering, the&nbsp;<code>-q</code>&nbsp;flag, only returns the numeric IDs and&nbsp;<code>-f</code>&nbsp;filters output based on conditions provided. One last thing that&#39;ll be useful is the&nbsp;<code>--rm</code>&nbsp;flag that can be passed to&nbsp;<code>docker run</code>&nbsp;which automatically deletes the container once it&#39;s exited from. For one off docker runs,&nbsp;<code>--rm</code>&nbsp;flag is very useful.</p>\r\n\r\n<p>In later versions of Docker, the&nbsp;<code>docker container prune</code>&nbsp;command can be used to achieve the same effect.</p>\r\n\r\n<pre>\r\n<code>$ docker container prune\r\nWARNING! This will remove all stopped containers.\r\nAre you sure you want to continue? [y/N] y\r\nDeleted Containers:\r\n4a7f7eebae0f63178aff7eb0aa39f0627a203ab2df258c1a00b456cf20063\r\nf98f9c2aa1eaf727e4ec9c0283bcaa4762fbdba7f26191f26c97f64090360\r\n\r\nTotal reclaimed space: 212 B</code></pre>\r\n\r\n<p>Lastly, you can also delete images that you no longer need by running&nbsp;<code>docker rmi</code>.</p>\r\n\r\n<h3>Terminology</h3>\r\n\r\n<p>In the last section, we used a lot of Docker-specific jargon which might be confusing to some. So before we go further, let me clarify some terminology that is used frequently in the Docker ecosystem.</p>\r\n\r\n<ul>\r\n	<li><em>Images</em>&nbsp;- The blueprints of our application which form the basis of containers. In the demo above, we used the&nbsp;<code>docker pull</code>&nbsp;command to download the&nbsp;<strong>busybox</strong>&nbsp;image.</li>\r\n	<li><em>Containers</em>&nbsp;- Created from Docker images and run the actual application. We create a container using&nbsp;<code>docker run</code>&nbsp;which we did using the busybox image that we downloaded. A list of running containers can be seen using the&nbsp;<code>docker ps</code>&nbsp;command.</li>\r\n	<li><em>Docker Daemon</em>&nbsp;- The background service running on the host that manages building, running and distributing Docker containers. The daemon is the process that runs in the operating system which clients talk to.</li>\r\n	<li><em>Docker Client</em>&nbsp;- The command line tool that allows the user to interact with the daemon. More generally, there can be other forms of clients too - such as&nbsp;<a href="https://kitematic.com/">Kitematic</a>&nbsp;which provide a GUI to the users.</li>\r\n	<li><em>Docker Hub</em>&nbsp;- A&nbsp;<a href="https://hub.docker.com/explore/">registry</a>&nbsp;of Docker images. You can think of the registry as a directory of all available Docker images. If required, one can host their own Docker registries and can use them for pulling images.</li>\r\n</ul>\r\n', '2020-09-17 11:29:45', 0),
	(19, 1, '程式導師實驗計劃第四期開始報名囉！', '0_XSsBHNBIe02MwNtz.png', '<p>之前在<a href="https://medium.com/@hulitw/mentor-program-3rd-result-df178bb55f4">第三期的心得</a>裡面說過暫時不會有第四期，不過世事難料，我自己的個人規劃也是變來變去，在今年二月的文章<a href="https://medium.com/@hulitw/i-failed-9386c6b0a681">提早出關，大家安安</a>裡面，已經預告了第四期的復活。</p>\r\n\r\n<p>然後依照規劃好的時間軸，今天，也就是 5/1，程式導師實驗計畫第四期正式開放報名囉！</p>\r\n\r\n<p>而且新期新氣象，這一期特地找了第三期的學生來做了程式導師實驗計畫的官網，你想知道的東西都寫在那裡了：</p>\r\n\r\n<h2><a href="https://bootcamp.lidemy.com/" target="_blank">Lidemy 程式導師實驗計畫第四期</a></h2>\r\n\r\n<h3><a href="https://bootcamp.lidemy.com/" target="_blank">不喊口號也不誇大成效，開放透明的 網頁前後端線上學習計畫用六個月的時間，培養出一個找得到工作且基礎紮實的網頁工程師。 技術脈絡&hellip;</a></h3>\r\n\r\n<p><a href="https://bootcamp.lidemy.com/" target="_blank">bootcamp.lidemy.com</a></p>\r\n\r\n<p><strong>強烈建議大家可以點進去觀看，過往的資訊也都在裡面，內容也會比這篇文章豐富許多。</strong></p>\r\n\r\n<p>這次會想要做網站，主要是因為這個計畫跑了三期之後累積了不少資源，例如說每一期的心得跟檢討啦，每一期的簡章啦，還有每一期學生的心得，其實都滿多東西的，而目前這些東西很分散，你沒辦法在一個地方就找到這些資源。</p>\r\n\r\n<p>因此就想說來做個網站，可以把資源集中，要找東西的時候也會好找很多。</p>\r\n\r\n<p>不過既然文章都寫了，我這篇文章還是簡單描述一下程式導師實驗計畫到底在幹嘛好了。可是底下只是稍微介紹而已，詳細的規則請參考<a href="https://bootcamp.lidemy.com/">官方網站</a>。</p>\r\n\r\n<h1>計畫詳情</h1>\r\n\r\n<p>這個計畫的目標是：</p>\r\n\r\n<blockquote>\r\n<p>六個月內，把你培養成一個找得到工作的網頁工程師（前端或後端）</p>\r\n</blockquote>\r\n\r\n<p>教的東西很多，想看課綱可以參考：<a href="https://bootcamp.lidemy.com/syllabus.html">簡化版的課綱</a>（適合外行人觀看）或是<a href="https://github.com/Lidemy/mentor-program-4th">詳細版課綱</a>（適合工程師觀看）。</p>\r\n\r\n<p>雖然六個月看似很長但其實不然，這種高密集性的課程需要許多時間的投入。想要達成以上目標，我的建議是一週要能付出 30 小時以上的時間學習，所以對於那些想要兼職學習的人來說，這基本上辦不到。</p>\r\n\r\n<p>可是別擔心，這並不代表你不能報名這個課程。</p>\r\n\r\n<p>過往其實就有些案例是課程剛開始時兼職學習，等到<strong>兩個月試用期</strong>結束之後，確定自己對程式有興趣而且想要轉職，才辭掉工作專心投入，這樣也是完全 ok 的。</p>\r\n\r\n<p>再來是這一期多了一個直接花錢買課程的付費方案，是給已經是工程師卻還是想加強基礎，或是需要兼顧工作，只能把學習時間拉長的人用的。所以就算你不想轉職，你只是想學個技能或因為其他原因想學習程式，也都有機會進來這個計畫。</p>\r\n\r\n<h1>教學方式</h1>\r\n\r\n<p>課程一共 26 週，前 24 週上課，最後 2 週做 final project，如果發現兩週做不完會再延長。進度的部分會按照 26 六周來切，每週都會有我錄好的線上課程影片還有作業，基本上就是看影片然後做作業，然後我或是助教會批改並且給予意見。進度主要是讓六個月後想轉職的人參考的，如果沒有想轉職，按照自己的步調來就行了。</p>\r\n\r\n<p>有些週的課程可能不會有影片，就會提供一些參考資源或是讓大家自己找資料，培養查資料的能力。我也會不定期開直播幫大家解惑，有什麼疑難雜症都可以提問。</p>\r\n\r\n<p>課程會有一個學生專屬的學習系統，每天都可以看見其他同學做了什麼，讓你學習起來不孤單。</p>\r\n\r\n<p>如果你覺得只看課程影片就好了，可以自己跟著學，其他這些學習社群、導師、批改作業跟直播你都不太需要，那可以直接上&nbsp;<a href="https://lidemy.com/">Lidemy</a>&nbsp;購買課程並且搭配<a href="https://github.com/Lidemy/mentor-program-4th">課程大綱</a>來學習，或是也可以直接去 Udemy 買，或去看免費的開放式課程，這樣也很不錯，而且經濟上划算許多。</p>\r\n\r\n<h1>收費方式</h1>\r\n\r\n<p>這次分成兩個方案，「A 方案：求職方案」與「 B 方案：買斷方案」。</p>\r\n\r\n<p>A 求職方案是這個計畫的亮點之一：</p>\r\n\r\n<blockquote>\r\n<p>在結業後兩個月內找到工作的話，學費總額是一個半月的薪水；沒找到工作的話費用全免。</p>\r\n</blockquote>\r\n\r\n<p>但想參與的人有條件限制，必須要：</p>\r\n\r\n<ol>\r\n	<li>有求職意願，願意在結業後去找軟體工程師相關工作</li>\r\n	<li>一週要能付出 30 小時以上在這個計畫</li>\r\n</ol>\r\n\r\n<p>如果不符合以上條件，只能選擇 B 買斷方案，基本上就是花錢買課程，學費總額是 55000 元，第三個月開始每個月分期付款 12500 元，中途可以退出，後續的學費就不會再收。</p>\r\n\r\n<p>然後我要再次強調一點，那就是我知道很多想轉職的人在金錢上可能不是那麼有餘裕，所以收費方式很彈性。</p>\r\n\r\n<p>第一，被選進來的話前兩個月都免費上課，在兩個月後可以決定是否要留下，不留的話就珍重再見期待再相逢，要留的話就付 5000 元保證金。</p>\r\n\r\n<p>第二，A 求職方案的學費會在你工作以後才分期付款，大家基本上都是分六期，一期一萬之類的。如果你經濟上有些問題，等試用期三個月過了以後再分期付款也可以，或想要分更多期都可以再討論。</p>\r\n\r\n<p>第三，B 買斷方案第三個月開始每個月付一次錢，這樣經濟壓力應該不會這麼大，但因為仍然不是筆小數目，如果想要分更多期都可以再討論，真的很彈性。</p>\r\n\r\n<p>我希望大家都是開心地繳學費，而且是真的認為這個課程有幫助所以付錢，因此才有了兩個月試用期、就業成功後才繳錢等等這些規則。</p>\r\n\r\n<h1>跟上一期有哪些不同</h1>\r\n\r\n<ol>\r\n	<li>收費模式有了滿大的改動</li>\r\n	<li>作業以「漸進增強」的理念重新設計，取代零散小作業</li>\r\n	<li>作業完整度增加</li>\r\n	<li>新增助教制度，有助教會來幫忙改作業</li>\r\n	<li>引入產品以及開發流程相關課程</li>\r\n</ol>\r\n\r\n<h1>計畫時程表</h1>\r\n\r\n<p>報名日期：即日起至 2020/06/05 晚上 11:59 分（五）<br />\r\n報名結果公告：2020/06/08（一）<br />\r\n開課日期：2020/06/12（五）<br />\r\n繳交保證金新台幣 5000 元（兩個月）：2020/08/12（三）<br />\r\n選擇「B 買斷方案」的同學開始分期付款：2020/09/12（六）<br />\r\n結業日期：2020/12/12（六）<br />\r\n求職截止日（在這時間點前找到工作都必須付學費）：2021/02/12（五）</p>\r\n\r\n<h1>報名方式</h1>\r\n\r\n<p>會需要你去&nbsp;<a href="https://forms.gle/JqCqJHHyd7U2KHBv9">Google 表單</a>填寫一些基本資訊，然後去研究 Scratch 做一個小作品出來，接著自學一點程式，去&nbsp;<a href="https://github.com/Lidemy/mentor-program/blob/master/codewar.md">codewar</a>&nbsp;上面解出三題題目並且寫一下解題心得。</p>\r\n\r\n<p>做完之後寫信到 huli@lidemy.com</p>\r\n\r\n<p>標題請打：[報名] 程式導師實驗計畫第四期 &mdash; huli<br />\r\n（請把 huli 換成你自己的暱稱）</p>\r\n\r\n<p>信件內容請附上：</p>\r\n\r\n<ol>\r\n	<li>自我介紹（讓我更瞭解你）</li>\r\n	<li>報名這個計畫的理由</li>\r\n	<li>若成功錄取之後，你的時間安排為何（例如說目前待業，每天都有 8 小時可以寫程式；或是目前在職，但是晚上七點到十點會自學等等）</li>\r\n	<li>你未來想做什麼？（純粹好奇而已）</li>\r\n	<li>平時有寫東西的習慣嗎？（像是部落格、讀書心得、電影心得或者是旅遊日記都可以，有的話可以多談談這部分或附上網址，沒有的話也沒關係）</li>\r\n	<li>Scratch 作品連結 &amp; 做完 Scratch 作品的心得</li>\r\n	<li>Codewar 帳號 &amp;解 Codewar 題目的心得</li>\r\n	<li>任何你想跟我分享的東西（例如說你寫的小說、你畫的圖、你的一篇廢文等等。）</li>\r\n	<li>其他（其他任何你想補充的東西）</li>\r\n</ol>\r\n\r\n<p>更多資訊請參考：<a href="https://bootcamp.lidemy.com/course-info.html#anchor-registration">https://bootcamp.lidemy.com/course-info.html#anchor-registration</a></p>\r\n\r\n<h1>總結</h1>\r\n\r\n<p>我怕寫太多會跟官網內容太過於重複，內容又不想全部都複製貼上過來，因此以上都只是隨意介紹一下而已。</p>\r\n\r\n<p>更多資訊在官網裡面都可以找到，例如說那時做官網的一大動力是過往的檢討文章連結跟學習成效，以前每發一次文就要貼一次然後一堆連結，現在終於有個地方可以看到全貌了！</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt="Image for post" src="https://miro.medium.com/max/1146/1*PPNKt4NjYTs7GJGDKauafg.png" style="height:459px; width:680px" /></p>\r\n\r\n<p>各期改進內容</p>\r\n\r\n<p><a href="https://bootcamp.lidemy.com/achievement.html#anchor-experience">學生心得</a>也是，整理起來一目瞭然：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt="Image for post" src="https://miro.medium.com/max/965/1*ajH9Vr9IVl2xiTclm4Prdg.png" style="height:623px; width:679px" /></p>\r\n\r\n<p><a href="https://bootcamp.lidemy.com/achievement.html#anchor-experience">https://bootcamp.lidemy.com/achievement.html#anchor-experience</a></p>\r\n\r\n<p>計畫介紹、課綱、導師介紹、報名方式、常見問題都在網站裡面寫清楚了，如果有碰到什麼問題都可以留言跟我說或是寄信給我。</p>\r\n\r\n<p>最後，感謝這次網站的幕後功臣們：&nbsp;<a href="https://medium.com/u/1b8faea10a91?source=post_page-----39f58a00067c--------------------------------" target="_blank">Yakim Hsu</a>,&nbsp;<a href="https://medium.com/u/c7713dd3b6f6?source=post_page-----39f58a00067c--------------------------------" target="_blank">Min</a>&nbsp;還有&nbsp;<a href="https://chihyang41.github.io/">ChihYang</a>。</p>\r\n', '2020-09-17 11:40:50', 0);
/*!40000 ALTER TABLE `John_blog_posts` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_blog_post_topic
CREATE TABLE IF NOT EXISTS `John_blog_post_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_id` (`post_id`),
  KEY `PK_topic_id` (`topic_id`),
  CONSTRAINT `PK_post_id` FOREIGN KEY (`post_id`) REFERENCES `John_blog_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PK_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `John_blog_topics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table mtr04group2.John_blog_post_topic: ~2 rows (approximately)
DELETE FROM `John_blog_post_topic`;
/*!40000 ALTER TABLE `John_blog_post_topic` DISABLE KEYS */;
INSERT INTO `John_blog_post_topic` (`id`, `post_id`, `topic_id`) VALUES
	(61, 18, 10),
	(62, 19, 9);
/*!40000 ALTER TABLE `John_blog_post_topic` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_blog_topics
CREATE TABLE IF NOT EXISTS `John_blog_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_deleted` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table mtr04group2.John_blog_topics: ~4 rows (approximately)
DELETE FROM `John_blog_topics`;
/*!40000 ALTER TABLE `John_blog_topics` DISABLE KEYS */;
INSERT INTO `John_blog_topics` (`id`, `name`, `is_deleted`) VALUES
	(9, '前端應用', 'N'),
	(10, '後端應用', 'N'),
	(11, '視覺設計', 'N'),
	(12, '雜談', 'N');
/*!40000 ALTER TABLE `John_blog_topics` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_blog_users
CREATE TABLE IF NOT EXISTS `John_blog_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `nickname` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role` enum('Admin','Author') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table mtr04group2.John_blog_users: ~1 rows (approximately)
DELETE FROM `John_blog_users`;
/*!40000 ALTER TABLE `John_blog_users` DISABLE KEYS */;
INSERT INTO `John_blog_users` (`id`, `username`, `nickname`, `password`, `role`, `created_at`) VALUES
	(1, 'admin', 'John', 'admin', 'Admin', '2020-08-24 23:09:44');
/*!40000 ALTER TABLE `John_blog_users` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_comments
CREATE TABLE IF NOT EXISTS `John_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `site_key` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;

-- Dumping data for table mtr04group2.John_comments: 95 rows
DELETE FROM `John_comments`;
/*!40000 ALTER TABLE `John_comments` DISABLE KEYS */;
INSERT INTO `John_comments` (`id`, `nickname`, `username`, `content`, `is_deleted`, `created_at`, `site_key`) VALUES
	(139, 'John', 'admin', '表情測試\r\n\r\n????????????????', NULL, '2020-08-18 20:30:05', 'john'),
	(138, 'John', 'admin', '留言版測試~', NULL, '2020-08-18 20:29:47', 'john'),
	(140, 'John', 'admin', '\r\n表情測試\r\n😊🥺😉😍😘😚😜😂😝😳😁😣😢😭😰🥰', NULL, '2020-08-18 20:34:54', ''),
	(141, 'John', 'admin', '# MarkDown 測試\r\n\r\n## 測試\r\n\r\n### 我是誰', NULL, '2020-08-18 20:35:56', ''),
	(142, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:33', ''),
	(143, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:39', ''),
	(144, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:42', ''),
	(145, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:45', ''),
	(146, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:48', ''),
	(147, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:52', ''),
	(148, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:41:56', ''),
	(149, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:00', ''),
	(150, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:06', ''),
	(151, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:08', ''),
	(152, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:11', ''),
	(153, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:13', ''),
	(154, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:16', ''),
	(155, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:20', ''),
	(156, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:34', ''),
	(157, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:36', ''),
	(158, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:40', ''),
	(159, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:42:45', ''),
	(160, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:50:33', ''),
	(161, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:58:45', ''),
	(162, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:58:52', ''),
	(163, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:58:56', ''),
	(164, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:58:59', ''),
	(165, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:59:04', ''),
	(166, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:59:08', ''),
	(167, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:59:11', ''),
	(168, '換nickname', 'admin', '測試分頁', NULL, '2020-08-18 20:59:15', ''),
	(169, '換nickname', 'admin', '132123', NULL, '2020-08-18 21:01:58', ''),
	(170, '換nickname', 'admin', '132123', NULL, '2020-08-18 21:02:02', ''),
	(171, '換nickname', 'admin', '1231231', NULL, '2020-08-18 21:02:06', ''),
	(172, '換nickname', 'admin', '2312312312312', NULL, '2020-08-18 21:02:12', ''),
	(173, '換nickname', 'admin', '3123123', NULL, '2020-08-18 21:02:18', ''),
	(174, '換nickname', 'admin', '13132', NULL, '2020-08-18 21:02:28', ''),
	(175, '換nickname', 'admin', '34234324', NULL, '2020-08-18 21:02:34', ''),
	(176, '換nickname', 'admin', 'FGHFGHFG', NULL, '2020-08-18 21:02:40', ''),
	(177, '換nickname', 'admin', 'FGHFGHFGFGHFGHFGFGHFGHFGFGHFGHFGFGHFGHFG', NULL, '2020-08-18 21:02:52', ''),
	(178, '換nickname', 'admin', 'FGHFGHFG', NULL, '2020-08-18 21:03:08', ''),
	(179, '千千萬萬個我', '千千', '編輯留言測試\r\n\r\n編輯後', 1, '2020-08-18 21:47:27', ''),
	(180, 'ALAN', '', '被我改了', 1, '2020-08-18 21:57:38', 'john'),
	(181, '換nickname', 'admin', '😊🥺😉😍😘😚😜😂😝😳😁😣😢😭😰🥰\r\n\r\nemoji 測試', NULL, '2020-08-18 22:04:22', ''),
	(182, 'qqq', 'qqq', '😊🥺😉😍😘😚😜😂😝😳😁😣😢😭😰🥰', 1, '2020-08-21 21:23:39', ''),
	(183, 'ian', 'ian', 'yoyo', NULL, '2020-08-27 11:38:30', ''),
	(184, '火柴人', 'heybro', '._________________.\r\n   |.---------------.|\r\n   ||     .         ||\r\n   ||   ..   O      ||\r\n   ||       \\|/     ||\r\n   ||  ...   |      ||\r\n   ||       / \\     ||\r\n   ||_______________||\r\n   /.-.-.-.-.-.-.-.-.\\\r\n  /.-.-.-.-.-.-.-.-.-.\\\r\n /.-.-.-.-.-.-.-.-.-.-.\\\r\n/______/__________\\___o_\\ \r\n\\_______________________/謝謝火柴人  ', 1, '2020-08-29 01:04:45', ''),
	(185, '火柴人', 'heybro', '修改壞了 忘記改 table 的名字 哈哈\r\n\r\nFatal error: Uncaught Error: Call to a member function bind_param() on boolean in /home/gk0bzeoh7dod/public_html/mtr04group2/John/week11/hw1-board/update_comment.php:43 Stack trace: #0 {main} thrown in /home/gk0bzeoh7dod/public_html/mtr04group2/John/week11/hw1-board/update_comment.php on line 43\r\n\r\nQQ(John)', NULL, '2020-08-29 01:10:31', ''),
	(186, '火柴人', 'heybro', '|.-.-.-.O-.-.-.|\r\n|.-.-.-\\|/.-.-.|\r\n|.-.-.-.|.-.-._|\r\n|.-.-.-/_\\.-.-.|\r\n\r\n謝謝火柴人', 1, '2020-08-29 01:12:38', ''),
	(187, '火柴人', 'heybro', '謝謝火柴人\r\n\r\n~o/    _o\r\n/|      |\\\r\n/ \\    / >', 1, '2020-08-29 01:15:28', ''),
	(188, '火柴人', 'heybro', '謝謝火柴人\r\n.._o\r\n...|\\\r\n../.>', 1, '2020-08-29 01:16:52', ''),
	(189, '火柴人', 'heybro', '謝謝火柴人\r\n_o\r\n...|\\\r\n../.>', 1, '2020-08-29 01:17:11', ''),
	(190, '火柴人', 'heybro', '謝謝火柴人\r\n\r\no+<', NULL, '2020-08-29 01:18:10', ''),
	(191, '火柴人', 'heybro', '```\r\n+--------------+\r\n   |.------------.|\r\n   ||     O      ||\r\n   ||     |/     ||\r\n   ||    /|      ||\r\n   ||    / \\     ||\r\n   |+------------+|\r\n   +-..--------..-+\r\n   .--------------.\r\n  / /============\\ \\\r\n / /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', 1, '2020-08-29 01:23:36', ''),
	(192, '火柴人', 'heybro', '``` javascript\r\n+--------------+\r\n   |.------------.|\r\n   ||     O      ||\r\n   ||     |/     ||\r\n   ||    /|      ||\r\n   ||    / \\     ||\r\n   |+------------+|\r\n   +-..--------..-+\r\n   .--------------.\r\n  / /============\\ \\\r\n / /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', 1, '2020-08-29 01:24:01', ''),
	(193, '火柴人', 'heybro', '``` javascript\r\n+--------------+\r\n...|.------------.|\r\n...||.....O......||\r\n...||.....|/.....||\r\n...||..../|......||\r\n...||..../.\\.....||\r\n...|+------------+|\r\n...+-..--------..-+\r\n....--------------.\r\n../ /============\\ \\\r\n./ /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', 1, '2020-08-29 01:25:17', ''),
	(194, '火柴人', 'heybro', '``` javascript\r\n...+==============+\r\n...|.============.|\r\n...||.....O......||\r\n...||.....|/.....||\r\n...||..../|......||\r\n...||..../.\\.....||\r\n...|+============+|\r\n...+-==--------==-+\r\n....--------------.\r\n../ /============\\ \\\r\n./ /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', 1, '2020-08-29 01:26:10', ''),
	(195, '火柴人', 'heybro', '```\r\n火柴 火柴\r\n...+==============+\r\n...|.============.|\r\n...||.....O......||\r\n...||.....|/.....||\r\n...||..../|......||\r\n...||..../.\\.....||\r\n...|+============+|\r\n...+-==--------==-+\r\n....--------------.\r\n../ /============\\ \\\r\n./ /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', 1, '2020-08-29 01:26:36', ''),
	(196, '火柴人', 'heybro', '火柴 火柴\r\n...+==============+\r\n...|.============.|\r\n...||.....O......||\r\n...||.....|/.....||\r\n...||..../|......||\r\n...||..../.\\.....||\r\n...|+============+|\r\n...+-==--------==-+\r\n../ /============\\ \\\r\n./ /==============\\ \\\r\n/____________________\\\r\n\\____________________/', 1, '2020-08-29 01:27:00', ''),
	(197, '火柴人', 'heybro', '```\r\n火柴 火柴\r\n...+==============+\r\n...|.============.|\r\n...||.....O......||\r\n...||.....|/.....||\r\n...||..../|......||\r\n...||..../.\\.....||\r\n...|+============+|\r\n...+-==--------==-+\r\n../ /============\\ \\\r\n./ /==============\\ \\\r\n/____________________\\\r\n\\____________________/\r\n```', NULL, '2020-08-29 01:27:13', ''),
	(198, '火柴人', 'heybro', '\r\n![](https://i.imgur.com/Yiw5zKh.gif)', NULL, '2020-08-29 01:45:49', ''),
	(199, 'Cian', 'ccccc', '測一下～～\r\n\r\n<script>alert("Yoyoyo")</script>', NULL, '2020-08-30 23:28:16', 'john'),
	(200, 'Cian', 'ccccc', '```\r\ncode\r\n```', NULL, '2020-08-30 23:28:35', 'john'),
	(201, '早安', 'jay', '今天早餐吃些甚麼', 1, '2020-08-31 00:53:28', ''),
	(202, '早安', 'jay', '今天吃早餐了嗎', 1, '2020-08-31 00:57:11', ''),
	(203, 'Test', 'Test', '修正成功', NULL, '2020-08-31 08:03:40', ''),
	(204, 'John', 'admin', '謝謝 bngandan 同學告知我留言板有問題，讓我得以修正^_^', 1, '2020-08-31 08:53:16', ''),
	(205, '@@', '', '@@', NULL, '2020-08-31 21:45:41', 'john'),
	(206, '@@', '', '@@', NULL, '2020-08-31 21:45:45', 'john'),
	(207, '你好！ 今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早', '666', '早', NULL, '2020-09-01 08:42:33', ''),
	(208, '7879879878984565612948561245612348561285612894561298456129845619', '123456789123456789123456789', '123', NULL, '2020-09-01 08:45:25', 'john'),
	(209, 'rere', 'rere', '123123', NULL, '2020-09-02 23:32:38', ''),
	(210, 'rere', 'rere', '安安\r\n<script>alert(\'123\')</script>', NULL, '2020-09-02 23:32:56', ''),
	(211, '\' or \'admin', '\'or\'admin', 'qwd', NULL, '2020-09-05 20:44:31', 'john'),
	(212, 'tt', '', 'tt', NULL, '2020-09-06 14:40:55', ''),
	(213, 'aaa', '', 'aaa', NULL, '2020-09-06 23:27:07', ''),
	(214, 'yrd', '', '<h1>test</h1>', NULL, '2020-09-09 10:45:49', ''),
	(215, '<h1>test</h1>', '', '<h1>test</h1>', NULL, '2020-09-09 10:45:54', 'john'),
	(216, '123', '', '123', NULL, '2020-09-10 21:27:47', 'john'),
	(217, 'Don\'t use this code', '', 'Hey~!', NULL, '2020-09-10 21:31:26', 'john'),
	(218, '\' \'', '', '\' \'', NULL, '2020-09-10 22:12:52', 'john'),
	(219, 'tt', '', 'tt', NULL, '2020-09-10 23:00:09', ''),
	(220, 'bb', '', 'bb', NULL, '2020-09-10 23:21:11', 'huli'),
	(221, 'qq', '', 'qq', NULL, '2020-09-10 23:21:17', 'huli'),
	(222, '13', '', '13', NULL, '2020-09-12 12:21:43', 'john'),
	(223, '14', '', '14', NULL, '2020-09-12 12:21:59', 'john'),
	(224, 'tt', '', 'tt', NULL, '2020-09-12 12:33:10', 'test'),
	(225, '15', '', '15', NULL, '2020-09-12 15:28:02', 'john'),
	(226, 'q', '', 'q', NULL, '2020-09-12 15:41:04', 'huli'),
	(227, 'w', '', 'w', NULL, '2020-09-12 21:55:11', 'huli'),
	(228, 'y', '', 'y', NULL, '2020-09-12 21:55:18', 'john'),
	(229, 'aa', 'aa', '\'), (\'gg\', (select password from users limit 1))#', 1, '2020-09-13 20:05:26', ''),
	(230, '\'), (\'gg\', (select password from users limit 1))#', 'aa', '\'), (\'gg\', (select password from users limit 1))#', 1, '2020-09-13 20:06:09', ''),
	(231, '#', 'aa', '////', NULL, '2020-09-13 20:06:34', ''),
	(232, 's', NULL, 's', NULL, '2020-09-16 20:02:03', 'john');
/*!40000 ALTER TABLE `John_comments` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_lists
CREATE TABLE IF NOT EXISTS `John_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- Dumping data for table mtr04group2.John_lists: 54 rows
DELETE FROM `John_lists`;
/*!40000 ALTER TABLE `John_lists` DISABLE KEYS */;
INSERT INTO `John_lists` (`id`, `data`) VALUES
	(1, '[{"title":"321","completed":"true"},{"title":"123","completed":"true"},{"title":"ff","completed":"false"},{"title":"ww","completed":"false"},{"title":"test","completed":"false"}]'),
	(2, '[{"title":"222","completed":"false"}]'),
	(3, '[{"title":"aa","completed":"true"},{"title":"bb","completed":"false"},{"title":"cc","completed":"false"}]'),
	(4, '[{"title":"aa","completed":"true"},{"title":"bb","completed":"false"},{"title":"cc","completed":"false"}]'),
	(5, '[{"title":"<script>alert(\\"123\\")<\\/script>","completed":"true"},{"title":"bb","completed":"false"},{"title":"cc","completed":"false"}]'),
	(6, '[{"title":"<script>alert(\\"123\\")<\\/script>","completed":"true"},{"title":"test","completed":"false"},{"title":"cc","completed":"false"}]'),
	(7, '[{"title":"<script>alert(\\"123\\")<\\/script>","completed":"true"},{"title":"test","completed":"true"},{"title":"cc","completed":"false"}]'),
	(8, '[{"title":"<script>alert(\\"123\\")<\\/script>","completed":"true"},{"title":"test","completed":"true"},{"title":"cc","completed":"true"}]'),
	(9, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(10, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(11, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(12, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(13, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(14, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(15, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(16, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(17, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(18, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(19, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(20, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(21, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(22, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(23, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(24, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(25, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(26, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(27, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(28, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(29, '[{"title":"gbcvh","completed":"false"},{"title":"gbcvhghm gnhvnhv","completed":"false"}]'),
	(30, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"}]'),
	(31, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"}]'),
	(32, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"}]'),
	(33, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"}]'),
	(34, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115\\u3111\\u3114fgregrg","completed":"false"}]'),
	(35, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115\\u3111\\u3114fgregrg","completed":"false"}]'),
	(36, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115\\u3111\\u3114fgregrg","completed":"false"}]'),
	(37, '[{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115","completed":"false"},{"title":"\\u310e\\u3111\\u3111\\u3115\\u3111\\u3114fgregrg","completed":"false"}]'),
	(38, '[{"title":"555","completed":"false"}]'),
	(39, '[{"title":"555","completed":"false"},{"title":"556888","completed":"false"}]'),
	(40, '[{"title":"555","completed":"false"},{"title":"556888","completed":"false"}]'),
	(41, '[{"title":"cccc55","completed":"false"},{"title":"cccc55123","completed":"true"},{"title":"cccc55123555","completed":"false"},{"title":"5566","completed":"false"}]'),
	(42, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"}]'),
	(43, '[{"title":"132313","completed":"false"},{"title":"1323135","completed":"false"},{"title":"1323135s","completed":"false"},{"title":"sad","completed":"false"},{"title":"sadsad","completed":"false"}]'),
	(44, '[{"title":"ee","completed":"true"},{"title":"eee","completed":"false"},{"title":"eee","completed":"false"}]'),
	(45, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"},{"title":"11","completed":"false"}]'),
	(46, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"},{"title":"11","completed":"false"}]'),
	(47, '[{"title":"<h1>test<\\/h1>","completed":"false"},{"title":"<img src=\\"xxx\\"\\/>","completed":"false"},{"title":"<img src=\\"xxx\\" onerror=\\"google.com\\"\\/>","completed":"false"}]'),
	(48, '[{"title":"<h1>test<\\/h1>","completed":"true"},{"title":"<img src=\\"xxx\\"\\/>","completed":"true"},{"title":"<img src=\\"xxx\\" onerror=\\"google.com\\"\\/>","completed":"true"}]'),
	(49, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"},{"title":"11","completed":"false"},{"title":"dd","completed":"false"}]'),
	(50, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"},{"title":"11","completed":"false"},{"title":"dd","completed":"false"}]'),
	(51, '[{"title":"d","completed":"false"},{"title":"ddd","completed":"false"},{"title":"11","completed":"false"},{"title":"dd","completed":"false"}]'),
	(52, '[{"title":"a","completed":"false"}]'),
	(53, '[{"title":"a","completed":"false"}]'),
	(54, '[{"title":"dwdwdwdaaaadwdwdqawdwadawdwad","completed":"false"},{"title":"dwdwdwdaaaadwdwdqawdwadawdwad","completed":"false"},{"title":"dwdwdwdaaaadwdwdqawdwadawdwad","completed":"false"},{"title":"dwdwdwdaaaadwdwdqawdwadawdwad","completed":"false"},{"titl');
/*!40000 ALTER TABLE `John_lists` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_roles
CREATE TABLE IF NOT EXISTS `John_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) NOT NULL,
  `chinese_role_name` varchar(64) NOT NULL DEFAULT '',
  `add_post` tinyint(4) NOT NULL DEFAULT '1',
  `delete_self_post` tinyint(4) NOT NULL DEFAULT '1',
  `delete_any_post` tinyint(4) NOT NULL DEFAULT '0',
  `edit_self_post` tinyint(4) NOT NULL DEFAULT '1',
  `edit_any_post` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table mtr04group2.John_roles: ~4 rows (approximately)
DELETE FROM `John_roles`;
/*!40000 ALTER TABLE `John_roles` DISABLE KEYS */;
INSERT INTO `John_roles` (`id`, `role_name`, `chinese_role_name`, `add_post`, `delete_self_post`, `delete_any_post`, `edit_self_post`, `edit_any_post`) VALUES
	(1, 'admin', '管理員', 1, 1, 1, 1, 1),
	(2, 'normal', '一般使用者', 1, 1, 0, 1, 0),
	(3, 'suspended', '遭停權使用者', 0, 1, 0, 1, 0),
	(5, 'editor', '編輯者', 1, 1, 0, 1, 1);
/*!40000 ALTER TABLE `John_roles` ENABLE KEYS */;

-- Dumping structure for table mtr04group2.John_users
CREATE TABLE IF NOT EXISTS `John_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'normal',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

-- Dumping data for table mtr04group2.John_users: 18 rows
DELETE FROM `John_users`;
/*!40000 ALTER TABLE `John_users` DISABLE KEYS */;
INSERT INTO `John_users` (`id`, `nickname`, `username`, `password`, `created_at`, `role`) VALUES
	(48, 'qqq', 'qqq', '$2y$10$rtCLkNJt.A3Ax4AG/NKH1eGsiG9VQ32AzIr7ixjnmeVVXO6guIpzK', '2020-08-21 21:23:27', 'normal'),
	(47, 'ALAN', 'aaa', 'aaa', '2020-08-18 21:57:20', 'normal'),
	(46, '千千萬萬個我', '千千', '$2y$10$5ZZ9Y7gi4jgkMlw6MFbJ9ObXubdJJ55L8J3NXrkh/p0CCVibv1cEi', '2020-08-18 21:04:23', 'editor'),
	(45, 'John', 'admin', '$2y$10$DiWAkQlnAoDmvv.IJNgJGeexpYr0vkgiSaVsdsuY.IxoqKZQ3oEEO', '2020-08-18 20:29:23', 'admin'),
	(49, '臥龍先生', 'liang', '$2y$10$VFc.iTBF/mL4EIz.NxVanOlHdhDF3HQhd4gyB38E2K3lV9e.0qh3e', '2020-08-24 02:08:13', 'normal'),
	(50, 'ian', 'ian', '$2y$10$mINRrDMRcFAh3enhDn2GZeHAJ/ZjaxnMEQgoDOBKYFOOB9YIKuHsm', '2020-08-27 11:37:47', 'normal'),
	(51, '火柴人', 'heybro', '$2y$10$LxntVVm34FLXcEeuDLjNAeSjMq5ZKWBQym6M1/BG0kUFIMU0w6nTe', '2020-08-29 00:47:39', 'normal'),
	(52, 'www', 'www', '$2y$10$btJbnKEaMozcdtitF5AXOuwwwWbq08yLdoFuW5wbdqurgw8kszoXa', '2020-08-29 09:21:30', 'normal'),
	(53, 'Cian', 'ccccc', '$2y$10$OmY0DsPOdIFkzKqg.W9Q9eDxO/YHzKlGAFygeo4TCxwOFq6w36DJG', '2020-08-30 23:28:02', 'normal'),
	(54, '早安', 'jay', '$2y$10$Qlp6uIuYTvIUnsxz3wsLBuCe3qTdd6oyiK85pU0eKQzrreTVh439y', '2020-08-31 00:52:53', 'normal'),
	(55, 'Test', 'Test', '$2y$10$0VCYalasNFtTKDGhI46ngOMZenh24vYeyNNDpCBSqmoj6dBDh.pzG', '2020-08-31 08:03:16', 'normal'),
	(56, 'nick', 'nick', '$2y$10$9bfKTxcs/Xi79dceVDPUOOeDbg1G5kWdcNTM9j/MIGnMXynHXveN.', '2020-08-31 21:01:17', 'normal'),
	(57, '你好！ 今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早餐了嗎今天的你吃早', '666', '$2y$10$8hoAJYUi0VRo..Q7wyzuIeP11QpucXDmpoXZvhKIBB0onuaa54E66', '2020-09-01 08:42:07', 'normal'),
	(58, '7879879878984565612948561245612348561285612894561298456129845619', '123456789123456789123456789', '$2y$10$sSNdmFBXrx/WvhgsUfVgxu8cUna0uKvjv.7OMpuq4qXoQ8R55S4pi', '2020-09-01 08:44:34', 'normal'),
	(59, 'rere', 'rere', '$2y$10$nzwwk67omus8lAIXi7aAQeU/su.DcEfww4gamg3.4a4d6HvBJxYEW', '2020-09-02 23:32:29', 'normal'),
	(60, '<script>alert("hacked by huli")</script>', '<script>alert("hackedbyhuli")</script>', '$2y$10$yM6Fb5ruiW4sXB25uEgDMOeGtmhYFtInjNFtTEer3rGOJGvn5oahG', '2020-09-05 18:37:09', 'normal'),
	(61, '\' or \'admin', '\'or\'admin', '$2y$10$FYaVdWkevoVbZh2bDG9WMu0STckY8LP8RE1e0jlyFaMS9MGsO3k0e', '2020-09-05 20:44:24', 'normal'),
	(62, '#', 'aa', '$2y$10$D.aRQVk09REJ6QjVTGK4SeNwK/Gnsia3ZdS9x1qshH1rZUNiKCbTu', '2020-09-13 20:05:04', 'normal');
/*!40000 ALTER TABLE `John_users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
