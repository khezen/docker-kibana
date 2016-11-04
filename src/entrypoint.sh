#!/bin/bash

set -m

if [ ! -f /etc/kibana/kibana.yml ]; then
    cp -r /.backup/kibana /etc/
fi
/run/edit_config.sh

/run/wait_for_elasticsearch.sh

if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi
if [ "$1" = 'kibana' ]; then
	set -- gosu kibana tini -- "$@"
fi
$@ &

fg