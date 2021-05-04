#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} module <command> [arguments] ...
Commands:
  install <module>      Install module from PyPI
  list                  List installed python modules
  init                  Initialize environment for modules
  help                  Show help
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/pyenv.sh"

command_script="$0"

function usage() 
{
    print_doc "${command_script}" "$client_name"
    exit 1
}

case $1 in
    help)
        usage
        ;;
    init)
        venv_create
        exit 0
        ;;
    install)
        if [[ -z "$2" ]]
        then
            printf -- "Error: missing module name\n"
            usage
        fi
        venv_run pip3 install "$2"
        exit 0
        ;;
    list)
        venv_run python3 -m pip list
        exit 0
        ;;
    *)
        printf -- "Unknown command: \"%s\"\n" $1
        usage
        ;;
esac