#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} list index [option] ...
Options:
  --date     -d           the index file date in YYYYMMDD format
  --index    -i           the index type: "daily" or "full"
  --sort     -s           the file type: "company", "form", "master", "xbrl"
  --help     -h           help
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"

command_script="$0"

function usage() 
{
    print_doc "$1" "$client_name"
    exit 1
}

function calc_index()
{
    param_year=$(($param_date / 10000))
    param_month=$(($param_date / 100 - $param_year * 100))
    param_quarter=$((($param_month - 1) / 3 + 1 ))
    param_file=$([ "${param_index}" == "daily" ] && echo "${param_sort}.${param_date}" || echo "${param_sort}" )
}

function parse_args()
{
    while [[ $# -gt 0 ]]
    do
        case $1 in
            -h|--help)
                usage "${command_script}"
            ;;
            -d|--date)
                param_date="$2"
                shift
            ;;
            -s|--sort)
                param_sort="$2"
                shift
            ;;
            -i|--index)
                param_index="$2"
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

param_date="20210401"
param_sort="master"
param_index="daily"

parse_args "$@"
calc_index

trap 'rm -f "${tempfile}"' EXIT
tempfile=$(mktemp) || exit 1

index_uri="${edgar_archive_url}/edgar/${param_index}-index/${param_year}/QTR${param_quarter}/${param_file}.idx"

echo "${index_uri}"

curl -s "${index_uri}" \
    -H "User-Agent: ${user_agent}"  \
    -H "Accept-Encoding: deflate, gzip;q=1.0, *;q=0.5" > ${tempfile}

cat ${tempfile} | less
