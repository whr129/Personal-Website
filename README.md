# Howard Wang - Personal Website

Content repository for [howardwang129.com](https://howardwang129.com), a WordPress-powered personal blog and portfolio site.

## Architecture

- **Hosting:** IONOS VPS (Ubuntu 24.04) with Nginx, MySQL, PHP
- **CMS:** WordPress, managed via WP-CLI
- **Content pipeline:** Markdown files in `content/` are compiled to WordPress posts using [wp-materialize](https://git.peisongxiao.com/peisongxiao/wp-materialize)

## Content Structure

```
content/
├── .wp-materialize.json    # root manifest
├── blog/                   # blog posts (Markdown)
│   ├── .wp-materialize.json
│   └── *.md
└── portfolio/              # project entries (Markdown)
    ├── .wp-materialize.json
    └── *.md
```

## Writing a New Blog Post

1. Create a Markdown file in `content/blog/` with an `# H1` title
2. Register it in `content/blog/.wp-materialize.json` under `"files"`
3. Commit and push to `main`
4. On the VPS, run `wp-materialize apply`

## VPS Setup Scripts

The `scripts/` directory contains numbered shell scripts for server provisioning:

| Script | Purpose |
|--------|---------|
| `01-vps-setup.sh` | System updates, firewall, LEMP stack |
| `02-wordpress-install.sh` | MySQL database, WordPress via WP-CLI, Nginx config |
| `03-ssl-security.sh` | Certbot SSL, security plugins |
| `04-wp-materialize-setup.sh` | wp-materialize installation and global config |
| `05-theme-pages.sh` | Theme activation, static pages, navigation menu |
| `06-materialize-apply.sh` | Validate and apply Markdown content |
| `07-plugins.sh` | SEO, caching, contact form, backup plugins |
| `08-dns-cutover.sh` | SSL cert, WordPress URL update after DNS change |
