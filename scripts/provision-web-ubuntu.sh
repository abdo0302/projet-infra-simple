#!/usr/bin/env bash
set -eux

REPO_URL=${REPO_URL:-"https://github.com/abdo0302/site-Brief-Projet-.git"}
WWW_DIR=/var/www/html


apt-get update -y
apt-get upgrade -y
apt-get install -y nginx git


if [ ! -d "$WWW_DIR/.git" ]; then
  rm -rf ${WWW_DIR}/*
  git clone --depth 1 "${REPO_URL}" /tmp/site || true

  cp -r /tmp/site/* ${WWW_DIR}/ || true
  chown -R www-data:www-data ${WWW_DIR}
fi


cat > /etc/nginx/sites-available/default <<'NGINX'
server {
  listen 80 default_server;
  listen [::]:80 default_server;
  root /var/www/html;
  index index.html index.htm;
  server_name _;
  location / {
    try_files $uri $uri/ =404;
  }
}
NGINX

systemctl enable --now nginx

if command -v ufw >/dev/null 2>&1; then
  ufw allow 'Nginx Full' || true
fi

echo "Web provisioning done."
