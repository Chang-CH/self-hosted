# Home server setup

This document covers the architecture and services hosted.

1. Cloudfare: DNS, proxy.
   - Cloudfare allows us to hide the ip of our machine. The ip resolved for the website is cloudfare's proxy.
2. Nginx: reverse proxy
   - Allows us to host multiple domains on our machine.
   - We can proxy `sub.domain.com` to `localhost:9000`, for example.
   - Authentication is fairly lacklustre (consider Traefik maybe?)
   1. Nginx proxy manager: Web UI to manage Nginx configurations
3. Authentik: Route authentication
   - Allows us to do proxy authentication
4. Crowdsec: crowd sourced security

### Services

1. Firefly 3: Personal finance tracking app
2. Yacht: stop, start, delete, launch docker containers
3. Seafile (disabled): file storage
4. Jellyfin: \*arr library
5. Jellyseerr: Overseerr fork for jellyfin. Manages requests for jellyfin library.
6. Prowlarr: manages Radarr + Sonarr
7. Radarr: Movies
8. Sonarr: TV shows
9. Transmission: p2p downloader
10. SABnzbd: NZB downloader
11. N8N: automation

## TBD

- [ ] backup
  - `/var/lib/docker/volumes`: docker
  - `pg_dumpall`: postgres
  - `/etc/nginx`: nginx config
  - seafile directory
- [ ] Table of contents (WIP): [vite-local](https://github.com/Chang-CH/vite-local)
- [ ] power statistics monitoring

## Costs

Compute:

- Zenbook idle power consumption: 5-10W @ $0.3427/kWh = $1-2/mo

  - Raspberry pi 5 runs @ 2.7W idle = $0.70/mo

- Cloudfare: $0
- Domain name renewal: US$9.77/yr
- `NZBGeek`: 5$/6mo or $80/lifetime
- `Eweka` provider: 50$/15mo
