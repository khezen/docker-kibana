FROM kibana:5.1

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="kibana"

RUN /usr/share/kibana/bin/kibana-plugin install https://github.com/floragunncom/search-guard-kibana-plugin/releases/download/v5.1.2-alpha/searchguard-kibana-alpha-5.1.2.zip

# curl used to check elasticsearch is started
RUN apt-get update -y \
&&  apt-get install curl supervisor python-pip nginx -y

RUN pip install envtpl

ENV KOPF_VERSION 2.1.3
RUN curl -s -L "https://github.com/lshahar/elasticsearch-kopf/archive/v${KOPF_VERSION}.tar.gz" | \
    tar xz -C /tmp && mv "/tmp/elasticsearch-kopf-${KOPF_VERSION}" /kopf
    

RUN mkdir -p /.backup/kibana
COPY config/kibana.yml /.backup/kibana/kibana.yml
COPY config/supervisord.conf /etc/supervisord.conf
COPY config/nginx.conf.tpl /etc/nginx/conf.d/nginx.conf.tpl
RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/kibana/kibana.yml

ENV KIBANA_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200" \
    ELASTICSEARCH_PROTOCOL="http"
    
ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/kibana

#ENTRYPOINT ["/run/entrypoint.sh"]
#CMD ["kibana"]
RUN chown 999:999 -R /usr/share/kibana

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
