# Seafile setup

1. Get compose yml: `wget -O "docker-compose.yml" "https://manual.seafile.com/docker/docker-compose/ce/11.0/docker-compose.yml"`.
2. change MySQL root password, db root password, timezone.
3. Change Seafile port to `8899:80` (access container's port `80` via `8899` localhost)

## Setup Seafile client + sync

- TODO: TBC for ubuntu 24 noble