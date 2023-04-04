# Copyright (C) 2023 Sebastian Pipping <sebastian@pipping.org>
# SPDX-License-Identifier: MIT

FROM debian:bullseye-slim

RUN apt-get update && apt-get install --no-install-recommends --yes -V \
        lighttpd

# Activate access log
# https://github.com/moby/moby/issues/6880#issuecomment-344114520
RUN ln -s ../conf-available/10-accesslog.conf /etc/lighttpd/conf-enabled/
RUN ln -s ../conf-available/10-dir-listing.conf /etc/lighttpd/conf-enabled/
RUN mkfifo -m 600 /var/log/lighttpd/access.log
RUN chown www-data:www-data /var/log/lighttpd/access.log
EXPOSE 80
CMD ["sh", "-c", "cat <> /var/log/lighttpd/access.log & lighttpd -D -f /etc/lighttpd/lighttpd.conf"]

# Apply system upgrades last
# .. to not be turned into a no-op by Docker cache most of the time
RUN apt-get update && apt-get --yes dist-upgrade
