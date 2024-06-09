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
4. Firefly: Personal finance tracking app
5. [TBD] Nextcloud: file storage
6. [TBD] Bitwarden: password manager
7. [TBD] Radarr: ???
8. [TBD] Jellyfin: Audio/video streaming service
9. [TBD] Jellyseerr: Overseerr fork for jellyfin. Manages requests for jellyfin library.
10. [TBD] Adguard: adblocker dns
11. [TBD] Paperless: document management
12. [TBD] Plausible: analytics
13. [TBD] Yacht: stop, start, delete, launch docker containers
14. [TBD] Uptime Kuma: website uptime
15. [TBD] OpnSense: firewall
16. [TBD] Crowdsec: security
17. [Maybe] N8n: Automation

## Costs

Compute:

- Zenbook idle power consumption: 5-10W @ $0.3427/kWh = $1-2/mo
  - Raspberry pi 5 runs @ 2.7W idle = $0.70/mo
- Digital ocean basic droplet: $4/mo

Cloudfare:

- $0

Domain name renewal:

- US$9.77/yr