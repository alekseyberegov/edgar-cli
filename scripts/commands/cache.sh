#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} cache
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/cache.sh"

ls -l $(get_cache_dir)