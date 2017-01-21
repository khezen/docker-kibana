FROM kibana:4.6

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana"

RUN apt-get update -y \
# curl used to check elasticsearch is started
&&  apt-get install curl -y

RUN mkdir -p /.backup/kibana/config
COPY config/kibana.yml /.backup/kibana/config/kibana.yml
RUN rm -f /opt/kibana/config/kibana.yml

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/kibana

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
