#!/usr/bin/env bash
# Sets up a web server for deployment of web_static.

function install() {
	command -v "$1" &> /dev/null

	#shellcheck disable=SC2181
	if [ $? -ne 0 ]; then
		sudo apt-get update -y -qq && \
			sudo apt-get install -y "$1" -qq
	else
		echo -e "	${1} is already installed.\n"
	fi
}

install nginx #install nginx

# allowing nginx on firewall
sudo ufw allow 'Nginx HTTP'

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location /redirect_me {
        return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
