#!/bin/bash

: <<DOCUMENTATIONXX

command: list [--year|-y year] [--quarter|-q quarter] [--help|-h]
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"

command_script="$0"

function usage() 
{
    print_doc "$1"
    exit 1
}

function parse_args()
{
    while [[ $# -gt 0 ]]
    do
        case $1 in
            -h|--help)
                usage "${command_script}"
            ;;
            -y|--year)
                param_year="$2"
                shift
            ;;
            -q|--quarter)
                param_quarter="$2"
                shift
            ;;
            *)
                printf -- "Unknown parameter: \"%s\"\n" $1
                usage "${command_script}"
            ;;
        esac
        shift
    done
}

param_year=$(date +'%Y')
param_quarter=$((($(date +%-m) - 1) / 3 + 1 ))

parse_args "$@"

curl -s "${base_url}/daily-index/${param_year}/QTR${param_quarter}/" \
    -H "User-Agent: ${user_agent}" | \
    sed -n 's:.*<a href=\"\(.*\)\"><img.*:\1:p' | \
    grep idx
