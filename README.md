# Supported tags and respective `Dockerfile` links

* `5.6.3`, `5.6`, `5` [(5.6/Dockerfile)](https://github.com/Khezen/docker-kibana/blob/5.6/Dockerfile)
* `6.1.3`, `6.1` [(6.1/Dockerfile)](https://github.com/Khezen/docker-kibana/blob/6.1/Dockerfile)
* `6.2.2`, `6.2` [(6.2/Dockerfile)](https://github.com/Khezen/docker-kibana/blob/6.2/Dockerfile)
* `6.5.4`, `6.5`, `6`, `latest` [(6.5/Dockerfile)](https://github.com/Khezen/docker-kibana/blob/6.5/Dockerfile) [![](https://images.microbadger.com/badges/image/khezen/kibana.svg)](https://hub.docker.com/r/khezen/kibana/)
# What is Kibana?
Kibana lets you visualize your Elasticsearch data and navigate the Elastic Stack, so you can do anything from learning why you're getting paged at 2:00 a.m. to understanding the impact rain might have on your quarterly numbers.

[<img src="https://static-www.elastic.co/fr/assets/blt282ae2420e32fc38/icon-kibana-bb.svg?q=802" width="144" height="144">](https://www.elastic.co/fr/products/kibana)

# How To Use

```
docker run -d -p 5601:5601 khezen/kibana:latest   
```

### [File Descriptors and MMap](https://www.elastic.co/guide/en/elasticsearch/guide/current/_file_descriptors_and_mmap.html)

run the following command on your host:
```
sysctl -w vm.max_map_count=262144
```
You can set it permanently by modifying `vm.max_map_count` setting in your `/etc/sysctl.conf`.
# Environment Variables

##### KIBANA_HOST | `0-0-0-0`
##### KIBANA_PWD | `changeme`
password for elasticsearch built-in user *kibana*.

##### ELASTICSEARCH_HOST | `0-0-0-0`
##### ELASTICSEARCH_PORT | `9200`

# Configure Kibana

Configuration file is located in `/etc/kibana/kibana.yml` if you follow the same volume mapping as in docker-compose examples above.

You can find default config [there](https://github.com/khezen/docker-kibana/blob/master/config/kibana.yml).

You can find help with kibana configuration [there](https://www.elastic.co/guide/en/kibana/current/settings.html).

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-kibana/issues).
