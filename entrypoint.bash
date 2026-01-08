#! /bin/bash
# Copyright (C) 2018 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the MIT license

set -e -u

cd /var/www/distrowatch-gentoo-ev-org/

if [[ $# -gt 0 ]]; then
    exec "$@"
fi

while true; do
    if emerge-webrsync; then
        echo -n 'Generating... '
        /root/gentoo_x86_latest
        echo 'DONE.'
        ls -lh htdocs/x86/latest_*.txt
    fi

    if [[ ${LOOP:-} == false ]]; then
        exit 0
    fi

    sleep 12h
done
