FROM kibana:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack

COPY config/default.yml /etc/kibana/kibana.yml

ADD ./src/entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh

ENV kibanauser="kibanauser" \
    kibanauser_pwd="changeme"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
