#!/bin/bash

CONF="/opt/kibana-$KIBANA_VERSION/config/kibana.yml"

if [ ! -f "$CONF" ]; then
    cp -r /.backup/kibana "/opt/kibana-$KIBANA_VERSION"
    /run/miscellaneous/edit_config.sh
fi