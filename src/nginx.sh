#!/bin/sh

set -e

envtpl --keep-template /etc/nginx/conf.d/nginx.conf.tpl


exec nginx
