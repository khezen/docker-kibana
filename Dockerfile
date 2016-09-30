FROM kibana:5.0

RUN bin/kibana-plugin install x-pack

RUN apt-get update && apt-get install -y nodejs npm && \
    npm install -g yamljs

ADD ./reconfigure.js /reconfigure.js
RUN chmod +x /reconfigure.js
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kibana"]
