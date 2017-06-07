FROM kibana:5.4.1

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana"

ENV KIBANA_VERSION 5.4.1

# Plugins
RUN /usr/share/kibana/bin/kibana-plugin install https://github.com/floragunncom/search-guard-kibana-plugin/releases/download/v$KIBANA_VERSION/searchguard-kibana-$KIBANA_VERSION-2.zip

RUN apt-get update -y \
# curl used to check elasticsearch is started
&&  apt-get install curl -y

RUN mkdir -p /.backup/kibana
COPY config/kibana.yml /.backup/kibana/kibana.yml
RUN rm -f /etc/kibana/kibana.yml

ADD ./src/ /run/
RUN chmod +x -R /run/

EXPOSE 5601

VOLUME /etc/kibana

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
