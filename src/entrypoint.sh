#!/bin/bash

set -m

baseregexp="#[^\\n\\r]*"

if [ "$kibanauser" != "" ]; then
    sed -ri "s/$baseregexp\{user\}/elasticsearch.username: $kibanauser/" /etc/kibana/kibana.yml
    sed -ri "s/$baseregexp\{pass\}/elasticsearch.password: $kibanauser_pwd/" /etc/kibana/kibana.yml
fi
cat /etc/kibana/kibana.yml
/docker-entrypoint.sh "$@" &

fg