#!/bin/bash

: <<DOCUMENTATIONXX

Usage:
  ${1} package <command> [arguments]

Commands:
  install <package>          Install packages from PyPI
  uninstall <package>        Uninstall packages
  local <path>               Install local packages
  status <package>           Check whether package exists
  list                       List installed packages
  init                       Initialize environment for packages
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
        venv_exec "*;*;package" pip3 install "$2"
        exit 0
        ;;
    uninstall)
        venv_exec "*;*;package" pip3 uninstall "$2"
        exit 0
        ;;
    local)
        venv_exec "*;*;*;path" pip3 install -e "$2"
        exit 0
        ;;
    status)
        venv_exec "*;*;*" python3 -c "import sys, pkgutil; print(1 if pkgutil.find_loader(\"$2\") else 0);"
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