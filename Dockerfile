FROM kibana:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana x-pack marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack

COPY config/default.yml /etc/kibana/kibana.yml

ENV kibana_pwd="changeme" \
    elasticsearch_host="elasticsearch" \
    elasticsearch_port="9200"

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/kibana

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
