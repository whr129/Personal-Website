# Howard Wang - Personal Website

Content repository for [howardwang129.com](https://howardwang129.com), a WordPress-powered personal blog and portfolio site.

## Architecture

- **Hosting:** IONOS VPS (Ubuntu 24.04) with Nginx, MySQL, PHP
- **CMS:** WordPress, managed via WP-CLI
- **Content pipeline:** Markdown files in `content/` are compiled to WordPress posts using [wp-materialize](https://git.peisongxiao.com/peisongxiao/wp-materialize)

## Content Structure

```
content/
├── .wp-materialize.json       # root manifest
├── blog/                      # blog posts
│   ├── .wp-materialize.json
│   └── *.md
└── portfolio/                 # project entries
    ├── .wp-materialize.json
    └── *.md
```

## Writing a New Blog Post

1. Create a Markdown file in `content/blog/` with an `# H1` title
2. Add it to `content/blog/.wp-materialize.json` under `"files"`
3. Commit and push to `main`
4. On the VPS: `wp-materialize apply`

## VPS Setup Scripts

The `scripts/` directory contains one-time setup scripts for server provisioning.
