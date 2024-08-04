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

3. run the service:

```sh
docker compose pull
docker compose up -d
```

4. Visit `http://<your server's IP or hostname>:9000/if/flow/initial-setup/` to set the initial password

## Email setup

You can enable email for alerts, recovery, email confirmation, etc.

1.  Copy the following into the .env. Create a gmail app password following the steps in [this link](https://support.google.com/accounts/answer/185833?hl=en)
2.  If outgoing port 25 is blocked, your ISP has blocked outgoing SMTP. Use an SMTP relay (`smtp-relay.gmail.com`) with a different port to bypass.
3.  Based on [this link](https://www.reddit.com/r/selfhosted/comments/10c6w7j/notes_about_email_setup_with_authentik/), the following configurations are tested to work with `smtp-relay.gmail.com`:
    1. Port `25`, TLS = `true`, SSL = `false` (no relay)
    2. Port `487`, TLS = `false`, SSL = `true` (relay)
    3. Port `487`, TLS = `true`, SSL = `false` (relay)

```sh
# SMTP Host Emails are sent to
AUTHENTIK_EMAIL__HOST=smtp.gmail.com
AUTHENTIK_EMAIL__PORT=25
# Optionally authenticate (don't add quotation marks to your password)
AUTHENTIK_EMAIL__USERNAME=username@gmail.com
AUTHENTIK_EMAIL__PASSWORD=gmail_app_password
# Use StartTLS
AUTHENTIK_EMAIL__USE_TLS=SEE_ABOVE
# Use SSL
AUTHENTIK_EMAIL__USE_SSL=SEE_ABOVE
AUTHENTIK_EMAIL__TIMEOUT=10
# Email address authentik will send from, should have a correct @domain
AUTHENTIK_EMAIL__FROM=authentik@domain.com
```

To send from an alias (`EMAIL__FROM`), enable email routing in cloudfare by adding the custom address with the
necessary mx, dkim records etc., then add your email in settings > accounts and import > send mail as.
set server as `smtp.gmail.com`, port `25`, `TLS`.
