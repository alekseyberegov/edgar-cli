#!/usr/bin/env bash

: <<DOCUMENTATIONXX

ETIPME client (${2}) <https://github.com/alekseyberegov/edgar-cli>
Usage: ${1} <command> [parameters]
Commands:
  list      List index files
  index     View index file
  cache     View cache directory
  package   Manage python packages
  *         Show help
DOCUMENTATIONXX

function help() {
    print_doc "$0" "${client_name}" "${client_version}"
    exit 1
}

set -e
export ETIPME_WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export client_name=${0##*/}
export client_version=$(cat ${ETIPME_WORKDIR}/etipme.version)

# Includes
. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/logger.sh"

if [[ $# -eq 0 ]]
then
    help
fi

command="${ETIPME_WORKDIR}/commands/$1.sh"; shift

if [[ ! -f "${command}"  ]]
then
    help
fi

# Load configuration
CONFIG_ENV=${ETIPME_WORKDIR}/config/edgar.env
set -a; source ${CONFIG_ENV}; set +a 

# Run the command
"${command}" "$@"
