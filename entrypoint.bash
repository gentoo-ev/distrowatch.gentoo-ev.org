#! /bin/bash
# Copyright (C) 2018 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the MIT license

if [[ $# -gt 0 ]]; then
    exec "$@"
fi


set -e

mkdir -p /usr/portage/metadata/
echo $'[gentoo]\nmasters = gentoo' > /usr/portage/metadata/layout.conf

cd /var/www/distrowatch-gentoo-ev-org/

while true; do
    emerge-webrsync && /root/gentoo_x86_latest
    sleep 12h
done
