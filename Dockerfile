FROM kibana:latest

RUN apt-get update && apt-get install -y netcat

RUN kibana plugin --install elastic/sense
RUN kibana plugin --install elasticsearch/marvel/latest

CMD ["kibana"]
