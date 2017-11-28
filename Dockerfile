FROM alpine:3.6

ENV KIBANA_VERSION 6.0.0

# Kibana
RUN apk --update add curl && \
    mkdir /opt && \
    curl -s https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz | tar zx -C /opt && \
    apk add nodejs && \
    rm -rf /opt/kibana-${KIBANA_VERSION}/node && \
    mkdir -p /opt/kibana-${KIBANA_VERSION}/node/bin && \
    ln -sf /usr/bin/node /opt/kibana-${KIBANA_VERSION}/node/bin/node && \
    rm -rf /var/cache/apk/*

# Plugins
RUN /opt/kibana-${KIBANA_VERSION}/node/bin/kibana-plugin install https://github.com/floragunncom/search-guard-kibana-plugin/releases/download/v$KIBANA_VERSION-4/searchguard-kibana-$KIBANA_VERSION-4.zip
ENV PATH /opt/kibana-${KIBANA_VERSION}/node/bin:$PATH

RUN mkdir -p /.backup/kibana
COPY config/kibana.yml /.backup/kibana/kibana.yml
RUN rm -f /etc/kibana/kibana.yml

ADD ./src/ /run/
RUN chmod +x -R /run/

EXPOSE 5601

VOLUME /etc/kibana

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="0-0-0-0" \
    ELASTICSEARCH_PORT="9200" \
		KIBANA_HOST="0.0.0.0" 

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
