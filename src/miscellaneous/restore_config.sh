#!/bin/bash

CONF="/opt/kibana-$KIBANA_VERSION-linux-x86_64/config/kibana.yml"

if [ ! -f "$CONF" ]; then
    cp -r /.backup/kibana "/opt/kibana-$KIBANA_VERSION-linux-x86_64"
    /run/miscellaneous/edit_config.sh
fi