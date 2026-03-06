#!/usr/bin/env bash
# Phase 2: WordPress Installation via WP-CLI
# Run this script as root on your IONOS VPS after 01-vps-setup.sh.
#
# Before running, edit the variables below with your actual values.
#
# Usage: sudo bash 02-wordpress-install.sh

set -euo pipefail

# ──────────────────────────────────────────────
# EDIT THESE VARIABLES
# ──────────────────────────────────────────────
DB_NAME="wordpress_db"
DB_USER="wp_user"
DB_PASS="CHANGE_ME_STRONG_DB_PASSWORD"
WP_DIR="/var/www/howardwang129.com"
VPS_IP="YOUR_VPS_IP_HERE"
WP_ADMIN_USER="admin"
WP_ADMIN_PASS="CHANGE_ME_ADMIN_PASSWORD"
WP_ADMIN_EMAIL="your@email.com"
# ──────────────────────────────────────────────

echo "=== Phase 2: WordPress Installation ==="

echo "[1/5] Creating MySQL database and user..."
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost'; FLUSH PRIVILEGES;"

echo "[2/5] Downloading WordPress..."
mkdir -p "${WP_DIR}"
cd "${WP_DIR}"
wp core download --allow-root

echo "[3/5] Configuring wp-config.php..."
wp config create \
  --dbname="${DB_NAME}" \
  --dbuser="${DB_USER}" \
  --dbpass="${DB_PASS}" \
  --allow-root

echo "[4/5] Running WordPress core install..."
wp core install \
  --url="http://${VPS_IP}" \
  --title="Howard Wang" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASS}" \
  --admin_email="${WP_ADMIN_EMAIL}" \
  --allow-root

wp rewrite structure '/%postname%/' --allow-root

chown -R www-data:www-data "${WP_DIR}"

echo "[5/5] Creating Nginx server block..."
cat > /etc/nginx/sites-available/howardwang129.com <<'NGINX'
server {
    listen 80;
    server_name howardwang129.com www.howardwang129.com;
    root /var/www/howardwang129.com;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }

    client_max_body_size 64M;
}
NGINX

ln -sf /etc/nginx/sites-available/howardwang129.com /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl reload nginx

echo ""
echo "=== Phase 2 Complete ==="
echo "WordPress is installed at http://${VPS_IP}"
echo "Admin login: http://${VPS_IP}/wp-admin"
echo "Next: sudo bash 03-ssl-security.sh"
