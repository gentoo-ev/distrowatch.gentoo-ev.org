#! /bin/bash
# Copyright (C) 2018 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the MIT license

set -e

cd /var/www/distrowatch-gentoo-ev-org/

if [[ $# -gt 0 ]]; then
    exec "$@"
fi

while true; do
    if emerge-webrsync; then
        echo -n 'Generating... '
        /root/gentoo_x86_latest
        echo 'DONE.'
    fi
    sleep 12h
done
