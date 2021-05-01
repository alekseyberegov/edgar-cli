#!/bin/bash

. $(dirname "$0")/functions/base.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIG_ENV=${SCRIPT_DIR}/config/edgar.env

set -a; source ${CONFIG_ENV}; set +a

curl -s "${base_url}/daily-index/2021/QTR1/" \
    -H "User-Agent: ${user_agent}" | sed -n 's:.*<a href=\"\(.*\)\"><img.*:\1:p'

