#!/usr/bin/env bash
# Phase 7: Materialize Content
# Run as root (wp-materialize needs WP-CLI access to WordPress).
# Make sure the content/ directory has been pushed to GitHub first.
#
# Usage: sudo bash 06-materialize-apply.sh

set -euo pipefail

echo "=== Phase 7: Materialize Content ==="

echo "[1/2] Validating content (dry-run)..."
wp-materialize validate

echo ""
echo "[2/2] Applying content to WordPress..."
wp-materialize apply

echo ""
echo "=== Phase 7 Complete ==="
echo "Blog and portfolio posts are now live in WordPress."
echo "Next: sudo bash 07-plugins.sh"
