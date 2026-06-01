#!/bin/bash

sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1>Hello World</h1>" > /var/www/html/index.html
