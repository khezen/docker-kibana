FROM kibana:latest

RUN kibana plugin --install elastic/sense && \
    kibana plugin --install elasticsearch/marvel/latest && \
    kibana plugin --install elasticsearch/graph/latest && \
    kibana plugin --install kibana/reporting/latest

RUN apt-get update && apt-get install -y nodejs npm && \
    npm install -g yamljs

ADD ./reconfigure.js /reconfigure.js
RUN chmod +x /reconfigure.js
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kibana"]
