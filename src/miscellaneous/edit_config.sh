#!bin/bash

# KIBANA PWD
sed -ri "s/elasticsearch.password:[^\r\n]*/elasticsearch.password: $KIBANA_PWD/" /etc/kibana/kibana.yml
# ELASTICSEARCH URL
sed -ri "s/elasticsearch.url:[^\r\n]*/elasticsearch.url: http:\/\/$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/" /etc/kibana/kibana.yml
