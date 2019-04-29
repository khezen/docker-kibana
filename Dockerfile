FROM alpine:3.8 as build
ENV KIBANA_VERSION 6.5.4
ENV SG_VERSION "17"
ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana"
ENV KIBANA_TARBAL "${DOWNLOAD_URL}/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz"
# Install kibana
RUN apk --update add bash curl nodejs
RUN mkdir /install \
&&  cd /install
RUN curl -o kibana.tar.gz -Lkj "${KIBANA_TARBAL}";
RUN tar -xzvf kibana.tar.gz
RUN mv kibana-$KIBANA_VERSION-linux-x86_64 /kibana
RUN rm -rf /kibana/node \
&&  mkdir -p /kibana/node/bin \
&&  ln -sf /usr/bin/node /kibana/node/bin/node
# Install searchguard
RUN /kibana/bin/kibana-plugin install "https://oss.sonatype.org/content/repositories/releases/com/floragunn/search-guard-kibana-plugin/$KIBANA_VERSION-$SG_VERSION/search-guard-kibana-plugin-$KIBANA_VERSION-$SG_VERSION.zip"
# Copy files
RUN mkdir -p /.backup/kibana
COPY config /.backup/kibana/config
ADD ./src/ /run/
RUN chmod +x -R /run/
# See https://github.com/elastic/kibana/issues/6057
# COPY config/kibana.yml /kibana/config/kibana.yml
# RUN /kibana/bin/kibana 2>&1 | grep -m 1 "Optimization of .* complete in .* seconds"
# RUN rm -f /kibana/config/kibana.yml

FROM alpine:3.8
RUN apk --update add bash curl ca-certificates
COPY --from=build /run /run
COPY --from=build /.backup/kibana/config /.backup/kibana/config
COPY --from=build /usr/bin/node /usr/bin/node
COPY --from=build /kibana /kibana
RUN ln -sf /usr/bin/node /kibana/node/bin/node
ENV PATH="/kibana/bin:$PATH" \
    KIBANA_PWD="changeme" \ 
    ELASTICSEARCH_HOST="0-0-0-0" \ 
    ELASTICSEARCH_PORT="9200" \ 
	  KIBANA_HOST="0.0.0.0" \
	  ELASTICSEARCH_PROTOCOL="https"
EXPOSE 5601
ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
