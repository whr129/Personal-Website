#!/usr/bin/env bash
# Phase 9: Domain DNS Migration (post-DNS-change steps)
# Run this AFTER you've updated DNS records at your registrar to point
# howardwang129.com to your VPS IP.
#
# Manual steps BEFORE running this script:
#   1. Log into your domain registrar
#   2. Remove the CNAME record pointing to whr129.github.io
#   3. Add an A record: howardwang129.com -> YOUR_VPS_IP
#   4. Add an A record or CNAME: www.howardwang129.com -> YOUR_VPS_IP
#   5. Wait for DNS propagation (check with: dig howardwang129.com)
#
# Usage: sudo bash 08-dns-cutover.sh

set -euo pipefail

WP_DIR="/var/www/howardwang129.com"

echo "=== Phase 9: DNS Cutover ==="

echo "[1/3] Checking DNS resolution..."
echo "Current A record for howardwang129.com:"
dig +short howardwang129.com A || echo "(dig not available, skipping check)"

echo ""
echo "[2/3] Obtaining SSL certificate..."
certbot --nginx -d howardwang129.com -d www.howardwang129.com
certbot renew --dry-run

echo "[3/3] Updating WordPress URLs to HTTPS..."
cd "${WP_DIR}"
wp option update siteurl 'https://howardwang129.com' --allow-root
wp option update home 'https://howardwang129.com' --allow-root

echo ""
echo "=== Phase 9 Complete ==="
echo "Your site is now live at https://howardwang129.com"
