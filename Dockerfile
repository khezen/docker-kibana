FROM kibana:latest

RUN apt-get update && apt-get install -y netcat

RUN kibana plugin --install elastic/sense && \
    kibana plugin --install elasticsearch/marvel/latest && \
    kibana plugin --install elasticsearch/graph/latest && \
    kibana plugin --install kibana/reporting/latest && \

CMD ["kibana"]
