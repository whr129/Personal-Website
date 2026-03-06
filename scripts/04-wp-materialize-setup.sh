#!/usr/bin/env bash
# Phase 4: Install and Configure wp-materialize
# Run as your regular user (not root) on the VPS.
#
# Usage: bash 04-wp-materialize-setup.sh

set -euo pipefail

echo "=== Phase 4: wp-materialize Setup ==="

echo "[1/3] Cloning and installing wp-materialize in a virtual environment..."
cd "${HOME}"
if [ -d "wp-materialize" ]; then
    echo "wp-materialize directory already exists, pulling latest..."
    cd wp-materialize && git pull
else
    git clone https://git.peisongxiao.com/peisongxiao/wp-materialize.git
    cd wp-materialize
fi
python3 -m venv "${HOME}/wp-materialize-venv"
source "${HOME}/wp-materialize-venv/bin/activate"
pip install -e .
pip install -r requirements.txt
deactivate

echo "Creating wrapper script at /usr/local/bin/wp-materialize..."
sudo tee /usr/local/bin/wp-materialize > /dev/null <<WRAPPER
#!/usr/bin/env bash
exec ${HOME}/wp-materialize-venv/bin/wp-materialize "\$@"
WRAPPER
sudo chmod +x /usr/local/bin/wp-materialize

echo "[2/3] Creating repo storage directory..."
mkdir -p "${HOME}/wp-materialize-repos"

echo "[3/3] Creating global config..."
mkdir -p "${HOME}/.config/wp-materialize"
cat > "${HOME}/.config/wp-materialize/config.json" <<EOF
{
  "wordpress_root": "/var/www/howardwang129.com",
  "repo_storage_dir": "${HOME}/wp-materialize-repos",
  "renderer": "default",
  "hard_line_breaks": false,
  "block_html": false,
  "git_repositories": [
    {
      "name": "howard-content",
      "url": "https://github.com/whr129/Personal-Website.git",
      "branch": "main",
      "root_subdir": "content"
    }
  ],
  "directories": []
}
EOF

echo ""
echo "Config written to: ${HOME}/.config/wp-materialize/config.json"
echo ""
echo "=== Phase 4 Complete ==="
echo "Next: Push the content/ directory to GitHub, then run:"
echo "  sudo bash 05-theme-pages.sh"
