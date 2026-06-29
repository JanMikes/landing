# landing

The **apex landing page** for `lily.srv.thedevs.cz` — a tiny static page served by
stock `nginx:alpine`.

## Why

The apex host had no Traefik router, so the bare domain answered with a self-signed
`TRAEFIK DEFAULT CERT` and a 404 — failing external uptime checks and giving anyone
who hit it a broken response. This repo's image gives the apex a real Let's Encrypt
cert, a `200` on `/` (and `HEAD`), and a friendly contact card instead of a raw 404.

## What's here

| File | Role |
|---|---|
| `index.html` | the page (self-contained: inline CSS, no external/CDN assets) |
| `Dockerfile` | `FROM nginx:alpine` + `COPY index.html` |
| `.github/workflows/release.yml` | push→`main` builds+pushes the ghcr image and triggers the deploy |

## Deploy

Fully automated (lily.srv platform, D23): push to `main` → CI builds
`ghcr.io/janmikes/landing` and HMAC-POSTs the deploy webhook → the box runs
`/srv/landing/deploy.sh`. The compose + deploy.sh live in the infra repo under
`apps/landing/`. To change the page, edit `index.html` and push.

## Local preview

```sh
docker build -t landing . && docker run --rm -p 8080:80 landing
# open http://localhost:8080
```
