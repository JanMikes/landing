# syntax=docker/dockerfile:1
# Apex landing page for lily.srv.thedevs.cz — stock nginx serving one static file.
# Deployed on the lily.srv platform as app `landing` (infra repo: apps/landing/).
FROM nginx:alpine

# Link the ghcr package to this repo (shows the repo on the package page).
LABEL org.opencontainers.image.source="https://github.com/janmikes/landing"
LABEL org.opencontainers.image.description="Apex landing page for lily.srv.thedevs.cz"

# Replace nginx's default index with our page. nginx:alpine already serves
# /usr/share/nginx/html on :80 (GET + HEAD → 200) and ships busybox `wget`
# (the compose HEALTHCHECK uses it). No extra config needed.
COPY index.html /usr/share/nginx/html/index.html
