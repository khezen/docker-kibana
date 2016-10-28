FROM kibana:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack

ADD ./src/entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["kibana"]
