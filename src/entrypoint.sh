#!/bin/bash

set -m

/run/miscellaneous/restore_config.sh
/run/miscellaneous/wait_for_elasticsearch.sh

$@ &

fg
