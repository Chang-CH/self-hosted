# Jellyfin setup

This setup includes setting up jellyfin, as well as all the other services required to run jellyfin.

This guide follows the original [dmc guide](https://github.com/EdyTheCow/docker-media-center), albeit modified a little.

We will be using the below domains:

| Sub domain              | Record | Target         |
| ----------------------- | ------ | -------------- |
| dmc.domain.com          | A      | Your server IP |
| jellyfin.domain.com     | CNAME  | dmc.domain.com |
| transmission.domain.com | CNAME  | dmc.domain.com |
| jellyseer.domain.com    | CNAME  | dmc.domain.com |
| radarr.domain.com       | CNAME  | dmc.domain.com |
| sonarr.domain.com       | CNAME  | dmc.domain.com |
| prowlarr.domain.com     | CNAME  | dmc.domain.com |

CNAME aliases the main `dmc.domain.com` ip. update `ddclient.conf` ddns (see dynamic dns) to update the root address.

This assumes you wish to have all services exposed. In most cases, jellyfin and jellyseer are the only services that need to be exposed. The rest can be accessed internally.

## Pricing

If you do not wish to torrent, you can choose to setup usenet. Usenet requires a provider and an indexer.
Indexers are services that tell you where to find the files you want to download. Providers are services that host the files you want to download.

- `NZBGeek`: 5$/6mo or $80/lifetime
- `Eweka` provider: 50$/15mo

## Services

### Jellyfin

Jellyfin's role is the media library. Watch your shows here. It listens to new files added to the media folders and updates the library accordingly.

_Configuration_

Navigate to `jellyfin.domain.com` in your browser and follow the instructions. When selecting library folder follow these paths:

| Library  | Path                |
| -------- | ------------------- |
| Movies   | /data/media/movies  |
| TV Shows | /data/media/tvshows |

Create the folders manually if they cannot be found.

### Transmission

The torrent downloader. It listens to the watch folders and downloads torrents to the incomplete folder. Once the download is complete, it moves the files to the complete folder.

_Configuration_
Navigate to `transmission.domain.com` in your browser, you should be asked to login using the credentials for basic auth you set-up earlier. Under `Preferences -> Torrents` make sure your download paths look like this: `/data/downloads/complete` and `/data/downloads/incomplete`. This will be important later on for hardlinks.

### Sabnzbd

The usenet downloader. Works just like transmission but for usenet.

_Configuration_
Navigate to `localhost:5858` you should see a setup wizard. Configure the download colders: `/data/downloads/complete` and `/data/downloads/incomplete`.
Enter your usenet provider details as required.

Once done, head to `0.0.0.0:5858/config/general` and copy the API key. This will be used for radarr and sonarr later.

Also head to the `0.0.0.0:5858/config/special`. Under host_whitelist, add `sabnzbd` so sonarr and radarr may access sabnzbd with its docker hostname. You may also add your local machine hostname so you can access it at `hostname:5858`.

Lastly head to the `0.0.0.0:5858/config/categories`. rename `tv` to `tvshows`.

### Radarr

The movie download manager. Searches for movies and downloads them using transmission or sabnzbd.

_Configuration_

Navigate to `radarr.domain.com` in your browser, in the panel under `Media Management` section and add the root folder by simply selecting `/data/media/movies` directory.

Under `Download Clients` add a new client by selecting Transmission. Change these settings:

| Setting  | Value        |
| -------- | ------------ |
| Name     | Transmission |
| Host     | transmission |
| Category | movies       |

Host `transmission` will resolve the local IP of the container, do not use a domain or public IP. It's more convenient and secure to connect services locally. Since the connection is local, you do not need to insert any other credentials. Click `Test` to make sure it works and add the client.

Under `Download Clients` add a new client by selecting SABnzbd. Change these settings:

| Setting | Value   |
| ------- | ------- |
| Name    | SABnzbd |
| Host    | sabnzbd |
| Port    | 8080    |
| API Key | \*      |

### Sonarr

The TV show download manager. Searches for TV shows and downloads them using transmission or sabnzbd.

_Configuration_
Navigate to `sonarr.domain.com` in your browser, in the panel under `Media Management` section and add the root folder by simply selecting `/data/media/tvshows` directory.

Under `Download Clients` add new client by selecting Transmission. Change these settings:

| Setting  | Value        |
| -------- | ------------ |
| Name     | Transmission |
| Host     | transmission |
| Category | tvshows      |

Host `transmission` will resolve the local IP of the container, do not use a domain or public IP. It's more convenient and secure to connect services locally. Since the connection is local, you do not need to insert any other credentials. Click `Test` to make sure it works and add the client.

Under `Download Clients` add a new client by selecting SABnzbd. Change these settings:

| Setting  | Value   |
| -------- | ------- |
| Name     | SABnzbd |
| Host     | sabnzbd |
| Port     | 8080    |
| API Key  | \*      |
| Category | tvshows |

### Prowlarr

Prowlarr is a proxy that sits between Sonarr/Radarr and the indexers. It allows you to add multiple indexers and have them all sync with Sonarr and Radarr.

_Configuration_
Navigate to `prowlarr.domain.com` in your browser, under `Settings -> Apps` add Sonarr and Radarr.

| Setting         | Value                |
| --------------- | -------------------- |
| Name            | Radarr               |
| Sync Level      | Full Sync            |
| Prowlarr Server | http://prowlarr:9696 |
| Radarr Server   | http://radarr:7878   |

Instructions for adding Sonarr are exactly the same, just change the name to `Sonarr` and use `http://sonarr:8989` for `Sonarr Server`. You'll find API keys for both under `Settings -> General` in their respective panels.

Navigate to `Indexers` and click `Add Indexer` to add public or private indexers. Once added, these will automatically sync with Sonarr and Radarr.

### Jellyseerr

Jellyseerr is a fork of overseerr. Its job is media discovery, allowing you to search and request for movies and TV shows.
The requests, when approved, get downloaded by Radarr and Sonarr.

_Configuration_
Navigate to `jellyseerr.domain.com` in your browser, select option to use `Jellyfin account` and proceed by providing url and account details for your jellyfin installation. Scan and enable libraries.

<b>Adding radarr / sonarr</b><br />
Most importantly, do not use the actual url or IP of radarr / sonarr. Simply use `radarr` or `sonarr` for the hostname. This will resolve the local IP of the container rather than the public one. Since we're running everything on the same server, it's more secure and convenient to connect these services locally. Make sure to uncheck `Use SSL` option too for the local connection to work.

Below are the important settings you should edit, the instructions for sonarr are exactly the same. Just make sure to replace `radarr` with `sonarr` and you should be good to go.

| Setting                | Value                                                       |
| ---------------------- | ----------------------------------------------------------- |
| Default Server         | Checked                                                     |
| Server Name            | Radarr                                                      |
| Hostname or IP Address | radarr                                                      |
| Use SSL                | Unchecked                                                   |
| API Key                | Can be found under General section in radarr / sonarr panel |
