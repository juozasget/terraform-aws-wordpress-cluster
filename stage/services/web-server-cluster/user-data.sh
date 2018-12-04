#!/bin/bash

sudo apt update -y
sudo apt install -y docker.io
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
sudo apt-get -y install git-core
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
git config --global user.name "juozasget"
git config --global user.email "juozasget@gmail.com"
git clone https://github.com/juozasget/wordpress-nginx-docker /home/ubuntu/web
mkdir -p /home/ubuntu/web/webcerts/ /home/ubuntu/web/certs-data/ /home/ubuntu/web/logs/nginx/ /home/ubuntu/web/wordpress/

export WORDPRESS_DB_NAME="example_database"
export WORDPRESS_DB_HOST="terraform-20181204161249695500000001.c3drsrfy3jms.eu-west-1.rds.amazonaws.com:3306"
export WORDPRESS_DB_PASSWORD="databasepsw123"
export WORDPRESS_DB_USER="root"

cat > /home/ubuntu/web/variables.env <<EOF
WORDPRESS_DB_NAME=example_database
WORDPRESS_DB_HOST=terraform-20181204161249695500000001.c3drsrfy3jms.eu-west-1.rds.amazonaws.com:3306
WORDPRESS_DB_PASSWORD=databasepsw123
WORDPRESS_DB_USER=root
EOF

mkdir /home/ubuntu/web/success
sudo docker-compose -f /home/ubuntu/web/docker-compose.yml up -d
