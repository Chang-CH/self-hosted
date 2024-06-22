# Setup documentation

## Setup Git

Prerequisite: install git + gh (`apt install git -y`, `apt install gh -y`)

```sh
git config --global user.email $git_email
git config --global user.name $git_username
gh auth login
echo "Generating SSH keys"
ssh-keygen -t rsa -b 4096
```

## Setup port forwarding

1. Access your router admin panel (Singtel: `192.168.1.254`). Enable port 80 and 443 forward to your machine's internal ip (`192.168.1.x`). Port forward other ports if necessary (e.g. `22` for ssh)
2. find machine ip with `ifconfig`. machine should be accesible from other devices outside of network.

## Setup dynamic dns

Since we do not have a static ip, we need to constantly update our public ip whenever our ip changes.

1. Install ddclient: `apt-get install ddclient`.
2. Get cloudfare API token (Alternatively, use global API key)
   1. Go to [dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens) and click `Create Token`.
   2. At the very top of the list is the 'Edit Zone DNS' template, click 'Use Template'
   3. You should be able to leave nearly everything as default, just make sure to change the Zone Resources to say Include > All zones from an account > 'Your account'
   4. Click 'Continue to summary' at the bottom of the page once you're satisfied with your setup
   5. You will obtain your API **token** (Not key!)
3. Edit `/etc/ddclient.conf`:

```sh
# ddclient.conf
#
# Gets IP over HTTPS
ssl=yes
# Refreshes every 5 minutes
daemon=5m

# Router/IP finding service
use=web
# The default web does not support https, freedns does.
web=freedns

protocol=cloudflare, \
zone=yourdomain.com, \
ttl=1, \
password=cloudflareapitoken \
yourdomain.com,sub.yourdomain.com,sub2.yourdomain.com
# If using API key (e.g. global key, include login=your@cloudfare_email.com before password)
```

4. Test `ddclient`: `sudo ddclient -daemon=0 -debug -verbos -no-quiet`.
5. Auto start ddclient:
   1. `sudo vim /etc/default/ddclient`, and set `run_daemon="true"` and `daemon_interval="5m"`.
   2. add as service: `sudo systemctl start ddclient.service`.
   3. run on restart: `sudo update-rc.d ddclient enable`.

## Setting up reserve ip in DHCP

1. enter router admin panel
2. Navigate to `Home Network Configuration` > `Manual Devices Reservation` > enter mac, hostname,ip.

## [Optional] Setting up pgadmin

```sh
echo "Setting up PostgreSQL"
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

# Specific to Ubuntu 24: https://github.com/pgadmin-org/pgadmin4/issues/7437
# search normal installation methods for other versions
sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/mantic pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
apt install pgadmin4
add-apt-repository ppa:deadsnakes/ppa
apt update
apt install python3.11
```
