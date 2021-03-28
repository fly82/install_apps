#!/usr/bin/env bash

PKG_TYPE=linux-amd64
PKG_GITHUB=kelseyhightower/confd/releases/latest
URL_APP=$(curl -s https://api.github.com/repos/${PKG_GITHUB} |\
    jq -r ".assets[] | select(.name | test(\"${PKG_TYPE}\")) | .browser_download_url")
wget -Nq $URL_APP -O confd || exit 1
sha256sum --quiet -c <(curl -sL https://github.com/${PKG_GITHUB} |\
    awk '/<pre>/,/<\/pre>/'|grep ${PKG_TYPE}|sed 's/-.*$//')
test $? -eq 0 && chmod +x confd
exit $?
