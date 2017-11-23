FROM alpine:3.7

COPY [ \
  "./docker-extras/*", \
  "/tmp/docker-build/" \
]

RUN \
  # apk
  apk update && \
  \
  apk add alpine-baselayout && \
  apk add alpine-sdk && \
  apk add vim && \
  \
  mkdir -p /var/cache/distfiles && \
  adduser -D -u 500 builder && \
  addgroup builder abuild && \
  chgrp abuild /var/cache/distfiles && \
  chmod g+w /var/cache/distfiles && \
  echo "builder    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  su -l builder -c "git config --global user.email Builder" && \
  su -l builder -c "git config --global user.name builder@lambda2" && \
  \
  sed -i -e "/^#PACKAGER.*$/d" /etc/abuild.conf && \
  echo 'PACKAGER="Builder <builder@lambda2>"' >> /etc/abuild.conf && \
  \
  # Enable this when generating new keys
  # su -l builder -c "abuild-keygen -a -n" && \
  su -l builder -c "mkdir .abuild" && \
  su -l builder -c "cp /tmp/docker-build/home-builder-.abuild-abuild.conf .abuild/abuild.conf" && \
  su -l builder -c "cp /tmp/docker-build/home-builder-.abuild-Builder-59ffc9b9.rsa .abuild/Builder-59ffc9b9.rsa" && \
  su -l builder -c "cp /tmp/docker-build/home-builder-.abuild-Builder-59ffc9b9.rsa.pub .abuild/Builder-59ffc9b9.rsa.pub" && \
  su -l builder -c "chmod 640 .abuild/Builder-59ffc9b9.rsa" && \
  cp /home/builder/.abuild/*.rsa.pub /etc/apk/keys && \
  \
  # cleanup
  cd /root && \
  rm -rf /tmp/* && \
  rm -f /var/cache/apk/*
