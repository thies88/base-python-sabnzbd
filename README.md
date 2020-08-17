# Sabnzbd

Alpine based Image for creating docker container with Sabnzbd [sabnzbd.org](https://sabnzbd.org/) and monitored by s6-overlay.

[![Sabnzbd](https://github.com/thies88/docker-container-images/blob/master/Sabnzbd/2020-08-17%2001_56_31-SABnzbd%20Config.png)

#### weekly builds @Saturday at 3:00 (AM)
* Rebuilds new base image from scratch @http://nl.alpinelinux.org/alpine (Alpine 3.12)
  * Base OS is updated
  * Packages are updated
  * Application within image(container) gets updated if new release is available. 
  * Don't manual update Application within container unless you know what you're 		doing.
  * Application settings are restored if mapped correctly to a host folder, your /config folder and settings will be preserved

### docker setup

```
docker create \
  --name=sabnzbd \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Amsterdam \
  -p 8080:8080 \
  -p 9090:9090 `#optional` \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  -v /path/to/incomplete-downloads:/incomplete-downloads \
  -v /path/to/nzb:/nzb \
  --restart unless-stopped \
  thies88/sabnzbd
```

### update your container:

Via Docker Run/Create

    -Update the image: docker pull thies88/containername
    -Stop the running container: docker stop containername
    -Delete the container: docker rm containername
    -Recreate a new container with the same docker create parameters used at the setup of the container (if mapped correctly to a host folder, your /config folder and settings will be preserved)
    -Start the new container: docker start containername
    -You can also remove the old dangling images: docker image prune

Unraid users can use "Check for updates" within Unraid WebGui

&nbsp;

A custom base image built with [Alpine linux][https://alpinelinux.org/] and [S6 overlay](https://github.com/just-containers/s6-overlay) Based on: https://github.com/linuxserver/docker-baseimage-alpine
