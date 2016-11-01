#!bin/bash

# KIBANA PWD
sed -ri "s/elasticsearch.password:[^\r\n]*/elasticsearch.password: $kibana_pwd/" /etc/kibana/kibana.yml
# ELASTICSEARCH URL
sed -ri "s/elasticsearch.url:[^\r\n]*/elasticsearch.url: http://$elasticsearch_host:$elasticsearch_port/" /etc/kibana/kibana.yml
