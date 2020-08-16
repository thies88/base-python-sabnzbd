FROM thies88/base-

MAINTAINER thies88

#ENV SABNZBD_UID=""
#ENV SABNZBD_GID=""
ENV CONFIG="/config/config.ini"
ENV LISTEN="0.0.0.0:8080"
ENV HTTPS="9090"
ENV USER="sabnzbd"

ENV VERSION 2.3.9
ENV PAR2 0.8.0
#PYTHONIOENCODING=utf-8

# Create user and group for SABnzbd.
RUN addgroup -S -g 912 sabnzbd \
    && adduser -S -u 912 -G sabnzbd -h /sabnzbd -s /bin/sh sabnzbd

# Install Dependencies
RUN apk add --no-cache ca-certificates openssl unzip unrar p7zip \
					   libgomp \
    && wget -O- https://codeload.github.com/sabnzbd/sabnzbd/tar.gz/$VERSION | tar -zx \
    && mv sabnzbd-*/* sabnzbd \
	&& /usr/bin/python3 /sabnzbd/tools/make_mo.py
    
RUN apk add --no-cache --virtual temp build-base automake autoconf python3-dev alpine-sdk \
    && wget -O- https://github.com/Parchive/par2cmdline/archive/v$PAR2.tar.gz | tar -zx \
    && cd par2cmdline-$PAR2 \
    && aclocal \
    && automake --add-missing \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf par2cmdline-$PAR2 \
    && pip --no-cache-dir install --upgrade cheetah sabyenc requests pynzb chardet apprise enum34 cffi six cryptography openssl \
    && apk del temp py-pip \
	# create symbolic link so sabnzbd can find par2
	&& ln -s /usr/local/bin/par2 /usr/bin/par2

RUN rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

# Define container settings.
VOLUME ["/config", "/downloads", "/incomplete-downloads", "/nzb"]

EXPOSE 8080

# add local files
COPY root/ /



