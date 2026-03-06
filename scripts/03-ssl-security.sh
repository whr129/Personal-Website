#!/usr/bin/env bash
# Phase 3: SSL and Security
# Run this script as root AFTER DNS is pointing to the VPS
# (or skip SSL steps and run them later in 08-dns-cutover.sh).
#
# Usage: sudo bash 03-ssl-security.sh

set -euo pipefail

WP_DIR="/var/www/howardwang129.com"

echo "=== Phase 3: SSL and Security ==="

echo "[1/3] Installing Certbot..."
apt install -y certbot python3-certbot-nginx

echo "[2/3] Installing security plugins via WP-CLI..."
cd "${WP_DIR}"
wp plugin install wordfence --activate --allow-root
wp plugin install wps-hide-login --activate --allow-root

echo "[3/3] SSL note..."
echo ""
echo "SSL certificates require DNS to point to this server first."
echo "After DNS propagation, run:"
echo "  sudo certbot --nginx -d howardwang129.com -d www.howardwang129.com"
echo "  sudo certbot renew --dry-run"
echo ""
echo "=== Phase 3 Complete ==="
echo "Next: sudo bash 04-wp-materialize-setup.sh"
