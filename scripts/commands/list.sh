#!/bin/bash

curl -s "${base_url}/daily-index/2021/QTR1/" \
    -H "User-Agent: ${user_agent}" | \
    sed -n 's:.*<a href=\"\(.*\)\"><img.*:\1:p' | \
    grep idx