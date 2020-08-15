FROM lsiobase/alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SNIPT_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="alex-phillips"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	gcc \
	git \
	make \
	musl-dev \
	postgresql-dev \
	py3-pip \
	python3-dev \
	zlib-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	python3 \
	uwsgi \
	uwsgi-python3 && \
 echo "**** install snipt ****" && \
 if [ -z ${SNIPT_VERSION+x} ]; then \
	SNIPT_VERSION=$(curl -sX GET https://api.github.com/repos/nicksergeant/snipt/commits/master \
	| awk '/sha/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 	/tmp/snipt.tar.gz -L \
	"https://github.com/nicksergeant/snipt/archive/${SNIPT_VERSION}.tar.gz" && \
 mkdir -p \
	/app/snipt \
	/defaults/snipt-conf && \
 tar xf \
 	/tmp/snipt.tar.gz -C \
	/app/snipt --strip-components=1 && \
 echo "**** install pip packages ****" && \
 cd /app/snipt && \
 pip3 install --no-cache-dir -r requirements.txt && \
 make && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8000
VOLUME /config
