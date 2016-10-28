FROM kibana:4.6

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana marvel graph reporting"


RUN kibana plugin --install elastic/sense && \
    kibana plugin --install elasticsearch/marvel/latest && \
    kibana plugin --install elasticsearch/graph/latest && \
    kibana plugin --install kibana/reporting/latest

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kibana"]
