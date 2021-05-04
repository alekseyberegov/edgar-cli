#!/usr/bin/env bash

set -e
export ETIPME_WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export client_name=${0##*/}
export client_version=$(cat ${ETIPME_WORKDIR}/etipme.version)

# Includes
. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/logger.sh"

: <<DOCUMENTATIONXX

ETIPME client (${2}) <https://github.com/alekseyberegov/edgar-cli>
usage: ${1} <command> [parameters]
commands:
  list      List index files
  index     View index file
  cache     View cache directory
  module    Manage python modules
  *         help
DOCUMENTATIONXX

function help() {
    print_doc "$0" "${client_name}" "${client_version}"
    exit 1
}

if [[ $# -eq 0 ]]
then
    help
fi

command_script="${ETIPME_WORKDIR}/commands/$1.sh"
shift

if [[  ! -f "${command_script}"  ]]
then
    help
fi


# Load configuration
CONFIG_ENV=${ETIPME_WORKDIR}/config/edgar.env
set -a; source ${CONFIG_ENV}; set +a 

# Run the command
"${command_script}" "$@"
