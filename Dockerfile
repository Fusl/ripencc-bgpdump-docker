FROM alpine:edge
LABEL maintainer="Katie Holly <holly@fuslvz.ws>"
ENV BGPDUMP_VERSION 1.5.00.00
ADD tmp /build-tmp
RUN apk upgrade --no-cache \
 && apk add --no-cache curl autoconf gcc libc-dev zlib-dev bzip2-dev make \
 && curl -s -o /tmp/bgpdump.zip https://bitbucket.org/ripencc/bgpdump/get/${BGPDUMP_VERSION}.zip \
 && mkdir /tmp/bgpdump \
 && unzip /tmp/bgpdump.zip -d /tmp/bgpdump \
 && cd /tmp/bgpdump/* \
 && ./bootstrap.sh \
 && patch < /build-tmp/patch \
 && make \
 && make install \
 && cd / \
 && rm -rf /tmp/bgpdump.zip /tmp/bgpdump /build-tmp
ENTRYPOINT ["bgpdump"]