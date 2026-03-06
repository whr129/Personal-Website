#!/usr/bin/env bash
# Phase 6: Theme, Static Pages, and Navigation
# Run this script as root on the VPS.
#
# Usage: sudo bash 05-theme-pages.sh

set -euo pipefail

WP_DIR="/var/www/howardwang129.com"
cd "${WP_DIR}"

echo "=== Phase 6: Theme, Static Pages, and Navigation ==="

echo "[1/4] Activating Twenty Twenty-Five theme..."
wp theme install flavor flavor --activate --allow-root 2>/dev/null || \
  wp theme activate flavor flavor --allow-root 2>/dev/null || \
  echo "Theme activation: using currently active theme."

echo "[2/4] Creating static pages..."
wp post create --post_type=page --post_title='Home' --post_status=publish --allow-root
wp post create --post_type=page --post_title='About' --post_status=publish --allow-root
wp post create --post_type=page --post_title='Resume' --post_status=publish --allow-root
wp post create --post_type=page --post_title='Blog' --post_status=publish --allow-root
wp post create --post_type=page --post_title='Contact' --post_status=publish --allow-root

echo "[3/4] Configuring front page and blog page..."
HOME_ID=$(wp post list --post_type=page --title='Home' --field=ID --allow-root)
BLOG_ID=$(wp post list --post_type=page --title='Blog' --field=ID --allow-root)
wp option update show_on_front 'page' --allow-root
wp option update page_on_front "${HOME_ID}" --allow-root
wp option update page_for_posts "${BLOG_ID}" --allow-root

echo "[4/4] Creating navigation menu..."
wp menu create "Primary Menu" --allow-root

for PAGE in Home About Resume Blog Contact; do
    PAGE_ID=$(wp post list --post_type=page --title="${PAGE}" --field=ID --allow-root)
    wp menu item add-post "Primary Menu" "${PAGE_ID}" --allow-root
done

wp menu location assign "Primary Menu" primary --allow-root 2>/dev/null || \
  echo "Note: Menu location 'primary' may differ by theme. Assign manually in Appearance > Menus."

echo ""
echo "=== Phase 6 Complete ==="
echo "Static pages created. Edit their content in WordPress admin or via WP-CLI."
echo "Next: bash 06-materialize-apply.sh"
