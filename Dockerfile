FROM alpine:3.8

ENV KIBANA_VERSION 6.5.4
ENV SG_VERSION 6.5.4-17

RUN apk --update add bash curl wget && \
    mkdir /opt && \
    curl -s https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz | tar zx -C /opt && \
    apk add nodejs && \
    rm -rf /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node && \
    mkdir -p /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin && \
    ln -sf /usr/bin/node /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/node && \
		/opt/kibana-${KIBANA_VERSION}-linux-x86_64/bin/kibana-plugin install "https://oss.sonatype.org/content/repositories/releases/com/floragunn/search-guard-kibana-plugin/$SG_VERSION/search-guard-kibana-plugin-$SG_VERSION.zip" && \
    rm -rf /var/cache/apk/*

ENV PATH /opt/kibana-${KIBANA_VERSION}-linux-x86_64/bin:$PATH

RUN mkdir -p /.backup/kibana
COPY config /.backup/kibana/config

ADD ./src/ /run/
RUN chmod +x -R /run/

ENV KIBANA_PWD="changeme" \ 
    ELASTICSEARCH_HOST="0-0-0-0" \ 
    ELASTICSEARCH_PORT="9200" \ 
	KIBANA_HOST="0.0.0.0" \
	ELASTICSEARCH_PROTOCOL="https"
		
EXPOSE 5601

# See https://github.com/elastic/kibana/issues/6057
COPY config/kibana.yml /opt/kibana-$KIBANA_VERSION-linux-x86_64/config/kibana.yml
RUN /opt/kibana-${KIBANA_VERSION}-linux-x86_64/bin/kibana 2>&1 | grep -m 1 "Optimization of .* complete in .* seconds"
RUN rm -f /opt/kibana-$KIBANA_VERSION-linux-x86_64/config/kibana.yml

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
