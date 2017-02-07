server {
    listen       80;
    server_name  _;
    location /kopf {
        alias         /kopf/_site;
    }
    
    location /kibana {
	rewrite /kibana/(.*)$ /$1 break;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass          http://localhost:5601;
        #proxy_set_header Authorization "Basic ZWxhc3RpYzpjaGFuZ2VtZQ==";
        proxy_read_timeout  90;        
    }

    location / {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass          http://{{ ELASTICSEARCH_HOST }}:9200;
        #proxy_set_header Authorization "Basic ZWxhc3RpYzpjaGFuZ2VtZQ==";
        proxy_read_timeout  90;
    }
}
