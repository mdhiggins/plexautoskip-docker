# PlexAutoSkip Official Docker Container

 Docker container for PlexAutoSkip

## Version Tags

|Tag|Description|
|---|---|
|latest|Stable release|

## Usage

### docker-compose
```
  plexautoskip:
    image: ghcr.io/mdhiggins/plexautoskip-docker
    container_name: plexautoskip
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
    volumes:
      - /opt/appdata/plexautoskip:/config
    restart: unless-stopped
```

### config.ini
- Mount config.ini containing directory to `/config` using volumes, this should also contain your `logging.ini` file and any generated log files will be included in this directory

## Environment Variables
|Variable|Description|
|---|---|
|PUID|User ID|
|PGID|Group ID|
|HOST|Local IP address for callback requests, default `127.0.0.1`|
|SMA_PATH|`/usr/local/sma`|
|SMA_UPDATE|Default `false`. Set `true` to pull git update of SMA on restart|
