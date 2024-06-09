# Miscellaneous notes

A collection of useful troubleshooting commands and guides

## Networking

- Finding ip of a machine
  - windows: `ipconfig`.
  - unix: `ifconfig`.
- Setting hostname of machine: `hostnamectl set-hostname your-hostname`.
- Getting hostname of machine: `hostname`.
- Testing connection to machine: `ping machine-hostname -4`.

## Nginx

- serving subdirectory as root of another page:

```sh
# chown -R root:root /etc/nginx if access denied
location /route {
   # port 9000 receives URL :9000/...
   #  instead of :9000/route/...
   proxy_pass  http://127.0.0.1:9000/;
}
```

Note that the app must still be configured as a subdirectory (otherwise `app/route1` will go to `:9000/route1` not `:9000/app/route1`)

- [error] duplicate default_server: This happens when there are two of `listen 80 default_server;`. We can only have 1 `default_server` for each port (i.e. we can have another `listen [::]:80 default_server;`)
  1. 2 config files using conflicting defaults: `grep -R default_server /etc/nginx` to search.
  2. same file is included twice in `nginx.conf`: `include file.config; include *.*;` includes `file.config` twice.

## Docker

- show all containers: `docker ps -a` allows us to find container id.
- get the ip of the container: `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id` prints the ip.
- open shell in container: `docker exec -it conainer_id bash`: opens `bash` in the container.

## Postgres

- Ubuntu 24 (noble) with pgadmin4: Ubuntu 24 is not yet supported by pgadmin.
  1. Use `mantic` instead of `noble`. (`sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/mantic pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'` and `sudo apt install pgadmin4`)
  2. Install python 3.11 (`sudo add-apt-repository ppa:deadsnakes/ppa`, `sudo apt update`, `sudo apt install python3.11`)
