#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo apt install unzip -y
cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page296/healet.zip
unzip /tmp/healet.zip
sudo mv /tmp/healet-html/ /var/www/html/healet