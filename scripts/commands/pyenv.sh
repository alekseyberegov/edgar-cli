#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} pyenv
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/pyenv.sh"

function usage() 
{
    print_doc "$1" "$client_name"
    exit 1
}

create_venv


