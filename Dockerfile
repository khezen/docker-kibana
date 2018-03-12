FROM alpine:3.6

ENV KIBANA_VERSION 6.2.2
ENV SG_VERSION 6.2.2-10

RUN apk --update add bash curl wget && \
    mkdir /opt && \
    curl -s https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz | tar zx -C /opt && \
    apk add nodejs && \
    rm -rf /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node && \
    mkdir -p /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin && \
    ln -sf /usr/bin/node /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/node && \
		/opt/kibana-${KIBANA_VERSION}-linux-x86_64/bin/kibana-plugin install "https://oss.sonatype.org/content/repositories/releases/com/floragunn/search-guard-kibana-plugin/$SG_VERSION/search-guard-kibana-plugin-$SG_VERSION.zip" && \
    rm "/opt/kibana-$KIBANA_VERSION-linux-x86_64/config/kibana.yml" && \
    rm -rf /var/cache/apk/*


ENV PATH /opt/kibana-${KIBANA_VERSION}-linux-x86_64/bin:$PATH

RUN mkdir -p /.backup/kibana
COPY config /.backup/kibana/config
RUN rm -f "/opt/kibana-$KIBANA_VERSION/config/kibana.yml"

ADD ./src/ /run/
RUN chmod +x -R /run/

ENV KIBANA_PWD="changeme" \ 
    ELASTICSEARCH_HOST="0-0-0-0" \ 
    ELASTICSEARCH_PORT="9200" \ 
	KIBANA_HOST="0.0.0.0" \
	ELASTICSEARCH_PROTOCOL="https"
		
EXPOSE 5601

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
