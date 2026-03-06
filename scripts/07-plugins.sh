#!/usr/bin/env bash
# Phase 8: Essential Plugins
# Run this script as root on the VPS.
#
# Usage: sudo bash 07-plugins.sh

set -euo pipefail

WP_DIR="/var/www/howardwang129.com"
cd "${WP_DIR}"

echo "=== Phase 8: Essential Plugins ==="

echo "[1/5] Installing Yoast SEO..."
wp plugin install wordpress-seo --activate --allow-root

echo "[2/5] Installing WP Super Cache..."
wp plugin install wp-super-cache --activate --allow-root

echo "[3/5] Installing Contact Form 7..."
wp plugin install contact-form-7 --activate --allow-root

echo "[4/5] Installing ShortPixel Image Optimizer..."
wp plugin install shortpixel-image-optimiser --activate --allow-root

echo "[5/5] Installing UpdraftPlus Backups..."
wp plugin install updraftplus --activate --allow-root

echo ""
echo "=== Phase 8 Complete ==="
echo "Configure each plugin in WordPress admin (Settings pages)."
echo "Next: Update DNS records, then run: sudo bash 08-dns-cutover.sh"
