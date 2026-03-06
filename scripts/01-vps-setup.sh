#!/usr/bin/env bash
# Phase 1: IONOS VPS Server Setup
# Run this script as root (or with sudo) on your IONOS VPS (Ubuntu 24.04).
#
# Usage: sudo bash 01-vps-setup.sh

set -euo pipefail

echo "=== Phase 1: VPS Server Setup ==="

echo "[1/4] Running system updates..."
apt update && apt upgrade -y

echo "[2/4] Configuring UFW firewall..."
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable
ufw status

echo "[3/4] Installing LEMP stack..."
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

echo "[4/4] Installing Python 3, pip, and git..."
apt install -y python3 python3-pip python3-venv git

echo ""
echo "=== Phase 1 Complete ==="
echo "Next steps:"
echo "  1. Run: sudo mysql_secure_installation"
echo "  2. Run: sudo bash 02-wordpress-install.sh"
