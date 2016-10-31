#!bin/bash

# KIBANA PWD
sed -ri "s/\{kibana_pwd\}/$kibana_pwd/" /etc/kibana/kibana.yml
# ELASTICSEARCH URL
sed -ri "s/\{elasticsearch_host\}/$elasticsearch_host/" /etc/kibana/kibana.yml
sed -ri "s/\{elasticsearch_port\}/$elasticsearch_port/" /etc/kibana/kibana.yml

cat /etc/kibana/kibana.yml