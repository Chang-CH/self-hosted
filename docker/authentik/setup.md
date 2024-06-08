# Authentik setup

1. Get the docker compose file ([download](wget https://goauthentik.io/docker-compose.yml)).
2. Create the .env:

```sh
echo "PG_PASS=$(openssl rand 36 | base64)" >> .env
echo "AUTHENTIK_SECRET_KEY=$(openssl rand 60 | base64)" >> .env
echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env
echo "AUTHENTIK_PORT_HTTP=9090" >> .env
echo "AUTHENTIK_PORT_HTTPS=9443" >> .env
```

3. [Optional]: Enable email (Setup TBD)
```sh
# SMTP Host Emails are sent to
AUTHENTIK_EMAIL__HOST=localhost
AUTHENTIK_EMAIL__PORT=25
# Optionally authenticate (don't add quotation marks to your password)
AUTHENTIK_EMAIL__USERNAME=
AUTHENTIK_EMAIL__PASSWORD=
# Use StartTLS
AUTHENTIK_EMAIL__USE_TLS=false
# Use SSL
AUTHENTIK_EMAIL__USE_SSL=false
AUTHENTIK_EMAIL__TIMEOUT=10
# Email address authentik will send from, should have a correct @domain
AUTHENTIK_EMAIL__FROM=authentik@localhost
```

4. Docker compose:
```sh
docker compose pull
docker compose up -d
```
5. Visit `http://<your server's IP or hostname>:9000/if/flow/initial-setup/` to set the initial password