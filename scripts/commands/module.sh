#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} module <command> [arguments] ...
Commands:
  install <module>      Install python module from PyPI
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
    install)
        if [[ -z "$2" ]]
        then
            printf -- "Error: missing module name\n"
            usage
        fi
        install_python_module "$2"
        exit 0
        ;;
    *)
        printf -- "Unknown command: \"%s\"\n" $1
        usage
        ;;
esac