#!/bin/bash

if [ ! -f /etc/kibana/kibana.yml ]; then
    cp -r /.backup/kibana /etc/
fi