[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/snipt](https://github.com/linuxserver/docker-snipt)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/snipt.svg)](https://microbadger.com/images/linuxserver/snipt "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/snipt.svg)](https://microbadger.com/images/linuxserver/snipt "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/snipt.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/snipt.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-snipt/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-snipt/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/snipt/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/snipt/latest/index.html)

[Snipt](https://github.com/alex-phillips/snipt) is a watchdog for your cron jobs. It's a web server that listens for pings from your cron jobs, plus a web interface.


[![snipt](https://raw.githubusercontent.com/alex-phillips/snipt/master/static/img/welcome.png)](https://github.com/alex-phillips/snipt)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `linuxserver/snipt` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=snipt \
  -e PUID=1000 \
  -e PGID=1000 \
  -e SITE_HOST=<SITE_HOST> \
  -p 8000:8000 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/snipt
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  snipt:
    image: linuxserver/snipt
    container_name: snipt
    environment:
      - PUID=1000
      - PGID=1000
      - SITE_HOST=<SITE_HOST>
    volumes:
      - <path to data>:/config
    ports:
      - 8000:8000
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8000` | will map the container's port 8000 to port 8000 on the host |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e SITE_HOST=<SITE_HOST>` | The site's host (i.e., snipt.example.com) |
| `-v /config` | database and snipt config |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Access the WebUI at <your-ip>:8000. For more information, check out [snipt](https://github.com/alex-phillips/snipt).



## Support Info

* Shell access whilst the container is running: `docker exec -it snipt /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f snipt`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' snipt`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/snipt`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Run/Create
* Update the image: `docker pull linuxserver/snipt`
* Stop the running container: `docker stop snipt`
* Delete the container: `docker rm snipt`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start snipt`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot snipt
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull snipt`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d snipt`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **03.03.18:** - Initial Release.
