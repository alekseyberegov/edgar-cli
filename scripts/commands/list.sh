#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} list option [option] ...
Options:
  --year     -y           the year
  --quarter  -q           the quarter
  --period   -p           the period: "daily-index" or "full-index"
  --help     -h           help
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"

command_script="$0"

function usage() 
{
    print_doc "$1" "$client_name"
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
            -p|--period)
                param_period="$2"
                shift
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

param_period="daily-index"
param_year=$(date +'%Y')
param_quarter=$((($(date +%-m) - 1) / 3 + 1 ))

parse_args "$@"

curl -s "${base_url}/${param_period}/${param_year}/QTR${param_quarter}/" \
    -H "User-Agent: ${user_agent}" | \
    sed -n 's:.*<a href=\"\(.*\)\"><img.*:\1:p' | \
    grep idx
