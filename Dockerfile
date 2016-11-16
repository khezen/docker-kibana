FROM kibana:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana x-pack marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack \
&&  apt-get update -y \
# curl used to check elasticsearch is started
&&  apt-get install curl -y \
# dependencies for reporting 
&& apt-get install libfontconfig libfreetype6 -y

RUN mkdir -p /.backup
COPY config/kibana.yml /.backup/kibana/kibana.yml

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/kibana

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
