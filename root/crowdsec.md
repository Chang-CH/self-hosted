# Crowdsec setup

Install repositories:

```sh
curl -s https://install.crowdsec.net | sudo sh
```

Install crowdsec:

```sh
apt install crowdsec
```

## Setting up bouncers

Cloudfare free plan has rate limits so until that is resolved we only use bouncers on Nginx Proxy Manager

[Reference](https://www.crowdsec.net/blog/crowdsec-with-nginx-proxy-manager)

1. modify `/etc/crowdsec/config.yaml`: `listen_uri: 0.0.0.0:8080` under `server` section.
2. generate api key: `sudo cscli bouncers add npm-proxy` ()
3. Modify Nginx proxy manager to use image `Lepresidente/nginxproxymanager` (`jc21` drop in replacement)
4. [TBD]: Modify `data/crowdsec/crowdsec-openresty-bouncer.conf` with:
```sh
ENABLED=true
##Change this to where CrowdSec is listening
API_URL=http://:8080
API_KEY=
# ReCaptcha Secret Key
SECRET_KEY=
# Recaptcha Site key
SITE_KEY=
```
5. [TBD] Modify crowdsec `profiles.yaml` to use recaptcha
```sh
name: captcha_remediation
filters:
- Alert.Remediation == true && Alert.GetScope() == "Ip" && Alert.GetScenario() contains "http"
decisions:
- type: captcha
  duration: 4h
on_success: break
---
```