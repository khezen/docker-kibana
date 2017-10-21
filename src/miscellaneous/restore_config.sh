#!/bin/bash

if [ ! -f /etc/kibana/kibana.yml ]; then
    cp -r /.backup/kibana /etc/
    /run/miscellaneous/edit_config.sh
fi