#!bin/bash

baseregexp="#[^\\n\\r]*"

if [ "$kibana_pwd" != "" ]; then
    sed -ri "s/$baseregexp\{pass\}/elasticsearch.password: $kibana_pwd/" /etc/kibana/kibana.yml
fi

cat /etc/kibana/kibana.yml