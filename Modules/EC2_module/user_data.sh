#!/bin/bash
set -e
sudo apt update
sudo apt install nginx -y
echo "my instance in" > /var/www/html/index.html
sudo service  nginx restart



