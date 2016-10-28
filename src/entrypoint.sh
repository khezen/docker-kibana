#!/bin/bash

set -m

/docker-entrypoint.sh "$@" &

fg