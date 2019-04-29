#!/bin/bash

CONF="/kibana/config/kibana.yml"

if [ ! -f "$CONF" ]; then
    cp -r /.backup/kibana/config/kibana.yml "$CONF"
    /run/miscellaneous/edit_config.sh
fi