#!/usr/bin/env bash

set -e
export ETIPME_WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Includes
. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/logger.sh"

function help() {
  client_name=${0##*/}
  printf -- "
ETIPME client ($(cat ${ETIPME_WORKDIR}/etipme.version)) <https://github.com/alekseyberegov/edgar-cli>
usage: $client_name <command> [parameters]
commands:
  list      list EDGAR archive
  *         help
"
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
