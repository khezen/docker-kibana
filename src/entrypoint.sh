#!/bin/bash

set -m

/run/edit_config.sh

/docker-entrypoint.sh "$@" &

fg