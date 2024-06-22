# Home server setup

This document covers the architecture and services hosted.

1. Cloudfare: DNS, proxy.
   - Cloudfare allows us to hide the ip of our machine. The ip resolved for the website is cloudfare's proxy.
2. Nginx: reverse proxy
   - Allows us to host multiple domains on our machine.
   - We can proxy `sub.domain.com` to `localhost:9000`, for example.
   - Authentication is fairly lacklustre (consider Traefik maybe?)
   1. Nginx proxy manager: Web UI to manage Nginx configurations
3. [WIP] Authentik: Route authentication
   - Allows us to do proxy authentication
4. Firefly: Personal finance tracking app
5. [WIP] Crowdsec: crowd sourced security
6. Yacht: stop, start, delete, launch docker containers
7. Seafile: file storage
6. [TBD] Bitwarden: password manager
7. [TBD] Radarr: ???
8. [TBD] Jellyfin: Audio/video streaming service
9. [TBD] Jellyseerr: Overseerr fork for jellyfin. Manages requests for jellyfin library.
11. [TBD] Paperless: document management
12. [TBD] Plausible: analytics
14. [TBD] Uptime Kuma: website uptime
15. [TBD] OpnSense: firewall
16. [Maybe] N8n: Automation

## TBD

- backup 
   - `/var/lib/docker/volumes`: docker
   - `pg_dumpall`: postgres
   - `/etc/nginx`: nginx config
   - seafile directory

- Table of contents directory (express website + authentik?)
- Todo list app

## Costs

Compute:

- Zenbook idle power consumption: 5-10W @ $0.3427/kWh = $1-2/mo
  - Raspberry pi 5 runs @ 2.7W idle = $0.70/mo
- Digital ocean basic droplet: $4/mo

Cloudfare:

- $0

Domain name renewal:

- US$9.77/yr
