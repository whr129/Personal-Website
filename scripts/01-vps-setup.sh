#!/usr/bin/env bash
# Phase 1: IONOS VPS Server Setup
# Run this script as root (or with sudo) on your IONOS VPS (Ubuntu 24.04).
#
# Usage: sudo bash 01-vps-setup.sh

set -euo pipefail

echo "=== Phase 1: VPS Server Setup ==="

echo "[1/4] Running system updates..."
apt update && apt upgrade -y

echo "[2/4] Installing LEMP stack (before firewall so profiles are available)..."
apt install -y nginx
systemctl enable nginx
systemctl start nginx

apt install -y mysql-server
systemctl enable mysql
systemctl start mysql

apt install -y php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd \
  php8.3-mbstring php8.3-xml php8.3-zip php8.3-imagick

systemctl enable php8.3-fpm
systemctl start php8.3-fpm

echo "[3/5] Installing Python 3, pip, and git..."
apt install -y python3 python3-pip python3-venv git

echo "[4/5] Installing WP-CLI..."
if ! command -v wp &> /dev/null; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi
wp --info

echo "[5/5] Configuring UFW firewall..."
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
ufw status

echo ""
echo "=== Phase 1 Complete ==="
echo "Next steps:"
echo "  1. Run: sudo mysql_secure_installation"
echo "  2. Run: sudo bash 02-wordpress-install.sh"
