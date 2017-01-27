#!/bin/bash

if [ ! -f /opt/kibana/config/kibana.yml ]; then
    cp -r /.backup/kibana/config /opt/kibana
fi