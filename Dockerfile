FROM kibana:latest

RUN kibana plugin --install elastic/sense && \
    kibana plugin --install elasticsearch/marvel/latest && \
    kibana plugin --install elasticsearch/graph/latest && \
    kibana plugin --install kibana/reporting/latest

RUN apt-get update && apt-get install -y nodejs npm && \
    npm install -g yamljs


ADD ./entrypoint.js /entrypoint.js
RUN chmod +x /entrypoint.js
ENTRYPOINT ["/entrypoint.js"]
CMD ["kibana"]
