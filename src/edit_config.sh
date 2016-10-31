#!bin/bash

anything_but_crlf="[^\\n\\r]"
baseregexp="#$anything_but_crlf*"

# KIBANA PWD
sed -ri "s/$baseregexp\{pass\}/elasticsearch.password: $kibana_pwd/" /etc/kibana/kibana.yml
# ELASTICSEARCH URL
sed -ri "s/$baseregexp\{url\}/elasticsearch.url: 'http:\/\/$elasticsearch_host:$elasticsearch_port'/" /etc/kibana/kibana.yml
