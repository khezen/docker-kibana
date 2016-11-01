#!/bin/bash

set -m

if [ ! -f /etc/kibana/kibana.yml ]; then
    cp -r /.backup/kibana /etc/
fi

/run/edit_config.sh
/docker-entrypoint.sh "$@" &

fg