FROM kibana:4.6

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana marvel graph reporting"

RUN /usr/share/kibana/bin/kibana-plugin install x-pack

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kibana"]
