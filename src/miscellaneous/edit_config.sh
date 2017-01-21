#!bin/bash

# KIBANA PWD
sed -ri "s|elasticsearch.password:[^\r\n]*|elasticsearch.password: $KIBANA_PWD|" /opt/kibana/config/kibana.yml
# ELASTICSEARCH URL
sed -ri "s|elasticsearch.url:[^\r\n]*|elasticsearch.url: https://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT|" /opt/kibana/config/kibana.yml
# SSL
sed -ri "s|elasticsearch.ssl.verify:[^\r\n]*|elasticsearch.ssl.verify: true|" /opt/kibana/config/kibana.yml
sed -ri "s|elasticsearch.ssl.ca:[^\r\n]*|elasticsearch.ssl.ca: /etc/elasticsearch/searchguard/ssl/ca/root-ca.pem|" /opt/kibana/config/kibana.yml
