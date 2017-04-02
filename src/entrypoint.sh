#!/bin/bash

set -m

/run/miscellaneous/restore_config.sh
/run/miscellaneous/wait_for_elasticsearch.sh

# Run as user "logstash" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	set -- gosu kibana tini -- "$@"
fi
$@ &

fg
