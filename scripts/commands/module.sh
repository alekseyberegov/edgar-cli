#!/bin/bash

: <<DOCUMENTATIONXX

Usage:
  ${1} module <command> [arguments]

Commands:
  install <module>           Install modules from PyPI
  uninstall <module>         Uninstall modules
  local <path>               Install local modules
  list                       List installed modules
  init                       Initialize environment for modules
  help                       Show help
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
        venv_exec "*;*;module" pip3 install "$2"
        exit 0
        ;;
    uninstall)
        venv_exec "*;*;module" pip3 uninstall "$2"
        exit 0
        ;;
    local)
        venv_exec "*;*;*;path" pip3 install -e "$2"
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