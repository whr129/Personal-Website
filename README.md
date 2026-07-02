# Howard Wang Portfolio

Static new Vite React portfolio for [howardwang129.com](https://howardwang129.com). The site builds to `dist/` and is deployed to an IONOS Ubuntu VPS running Nginx by GitHub Actions.

## Local Development

```bash
npm ci
npm run dev
```

Use Node.js 20 or newer. GitHub Actions uses the current LTS release.

Useful checks:

```bash
npm run lint
npm run typecheck
npm run build
npm run preview
```

## Project Structure

```text
src/
├── App.tsx
├── data/
│   └── projects.ts
├── main.tsx
└── styles.css
```

Project cards are edited in `src/data/projects.ts`. Contact links and page sections are edited in `src/App.tsx`.

## Required GitHub Secrets

- `IONOS_HOST`
- `IONOS_USER`
- `IONOS_SSH_KEY`
- `IONOS_PORT`, optional, defaults to `22`
- `IONOS_DEPLOY_PATH`, optional, defaults to `/var/www/personal-site`

## VPS Layout

The deploy user needs write access to this path:

```text
/var/www/personal-site/
├── current -> releases/<active-release>
├── releases/
└── shared/
```

Nginx should serve `/var/www/personal-site/current` with SPA fallback:

```nginx
server {
    listen 80;
    server_name example.com www.example.com;

    root /var/www/personal-site/current;
    index index.html;

    access_log /var/log/nginx/personal-site.access.log;
    error_log /var/log/nginx/personal-site.error.log;

    gzip on;
    gzip_types text/plain text/css application/javascript application/json image/svg+xml;

    location /assets/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
        try_files $uri =404;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

After DNS points to the VPS, install HTTPS:

```bash
sudo certbot --nginx -d example.com -d www.example.com
```

## Deployment

Pushes to `main` run `.github/workflows/deploy.yml`. The workflow installs dependencies, lints, builds, uploads `dist/` to a timestamped release directory, switches `current` atomically, reloads Nginx, and keeps only the active release plus one previous release.

Rollback on the VPS:

```bash
cd /var/www/personal-site/releases
PREVIOUS="$(ls -1dt */ | sed -n '2p')"
ln -sfn "/var/www/personal-site/releases/${PREVIOUS%/}" /var/www/personal-site/current
sudo systemctl reload nginx
```
