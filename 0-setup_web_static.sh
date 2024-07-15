#!/usr/bin/env bash
# set up the NGINX config for web_static
# install nginx
sudo apt-get -y update
sudo apt-get -y install nginx
# make file structure
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "simple content, to test your Nginx configuration" >> /data/web_static/releases/test/index.html
ln -fs /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data
sed -i "/listen 80 default_server;/a location /hbnb_static {alias /data/web_static/current/;}" /etc/nginx/sites-available/default
sudo service nginx restart
