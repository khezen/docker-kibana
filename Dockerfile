FROM kibana:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack

COPY config/default.yml /etc/kibana/kibana.yml

ADD ./src/ /run/
RUN chmod +x -R /run/

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
