# 使用 Docker 容器化的 Lidemy 作業集
[作業集主頁](https://www.mentor4th-john.tw/)
![](https://i.imgur.com/XeY7YZS.png)


## 資料夾結構
* /app - 放置 php 作業以及 html 作業以及作業集的主頁
* /mysql - 放置 mysql 的 Dockerfile 以及 mysql 初始化資料檔
* /nginx - 放置 nginx 的 Dockerfile 以及 server 設定檔
* /node - 放置 node 的 Dockerfile 、 wait-for-it.sh 腳本以及使用 express+sequelize 建立的 Just A Bite 餐聽網站資料夾
* /php-cil 放置 php-cli 的 Dockerfile
* /php-fpm 放置 php-fpm 的 Dockerfile

## 主機系統

* 主機：AWS EC2
* 系統：Amazon Linux 2
* 使用 scp 或是 sftp 的方式，將檔案上傳 aws 主機。

## 實作方式
1. 將 MySQL, Nginx, Node, PHP-CLI 及 PHP-FPM 的 Dockerfile 寫好，建立好上述工具的 image 檔
2. 建立 docker-compose.yml 檔，指定要使用的 docker-compose 版本
3. 定義容器間的 networks
4. 定義 services 區塊，範例
```
docker-nginx:
    build:
      context: ./nginx
    # defines the port mapping
    # corresponds to the "-p" flag
    depends_on:
      - docker-mysql
      - docker-node
    ports:
      - "80:8080"
    tty: true
    volumes:
      - ./app:/var/www
      - ./nginx/conf.d:/etc/nginx/conf.d
    networks:
      - web-network
```
* build 指的是使用 /nginx 底下的 dockerfile 當作 image 來源
* depends_on 則是讓 docker-mysql 以及 docker-node 的容器啟動順序優先於 nginx
* ports 則是將電腦的 port 對應到 nginx 容器的 port ，例如，我從外面輸入 example.com:80 會對應到 docker 容器的 example.com:8080
* tty:true 則是分配一個虛擬終端機並綁定到該容器上的標準輸入
* volumes 則是將本地端資料夾對應到該容器底下的某個資料夾，例如:./app:/var/www 就是把本地端/app資料下對應到該容器底下的/var/www資料夾，我們可以在該容器底下的/var/www 看到本地端/app資料夾裡的所有檔案
* networks 則是將該容器加入至容器網路中，這樣我們就可以透過容器名稱直接連接到別的容器。
* 最後則是建立一個 volumes 容器，裡面存放需要被永久保存的資料庫數據，這樣一來就不會停止容器後，連資料庫的檔案都不見了
