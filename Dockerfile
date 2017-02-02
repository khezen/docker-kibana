FROM kibana:5.1

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana"

RUN /usr/share/kibana/bin/kibana-plugin install https://github.com/floragunncom/search-guard-kibana-plugin/releases/download/v5.1.2-alpha/searchguard-kibana-alpha-5.1.2.zip

RUN apt-get update -y \
# curl used to check elasticsearch is started
&&  apt-get install curl -y

RUN mkdir -p /.backup/kibana
COPY config/kibana.yml /.backup/kibana/kibana.yml
RUN rm -f /etc/kibana/kibana.yml

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200" \
    ELASTICSEARCH_PROTOCOL="http"
    
ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/kibana

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
