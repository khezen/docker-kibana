#!/bin/sh

set -e

node /reconfigure.js

exec /docker-entrypoint.sh "$@"