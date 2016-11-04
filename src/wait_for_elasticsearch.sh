#!/bin/bash
RET=1
while [[ RET -ne 0 ]]; do
    echo "Stalling for Elasticsearch..."
    curl -XGET -u "kibana:$kibana_pwd" "http://$elasticsearch_host:$elasticsearch_port/_xpack/security/_authenticate" >/dev/null 2>&1
    RET=$?
    sleep 5
done