#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} list option [option] ...
Options:
  --year     -y           the year in YYYY format
  --quarter  -q           the quarter number: 1..4
  --index    -i           the index type: "daily" or "full"
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
            -i|--index)
                param_index="$2"
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

param_index="daily"
param_year=$(date +'%Y')
param_quarter=$((($(date +%-m) - 1) / 3 + 1 ))

parse_args "$@"

curl -s "${edgar_archive_url}/edgar/${param_index}-index/${param_year}/QTR${param_quarter}/" \
    -H "User-Agent: ${user_agent}" | \
    sed -n 's:.*<a href=\"\(.*\)\"><img.*:\1:p' | \
    grep idx
