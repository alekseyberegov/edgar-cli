#!/bin/bash

: <<DOCUMENTATIONXX
Usage:
  ${1} index [options] ...
Options:
  --date     -d           the index file date in YYYYMMDD format
  --index    -i           the index type: "daily" or "full"
  --sort     -s           the file type: "company", "form", "master", "xbrl"
  --help     -h           help
DOCUMENTATIONXX

. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/cache.sh"

command_script="$0"

function usage() 
{
    print_doc "$1" "$client_name"
    exit 1
}

function set_params()
{
    param_date=${param_date:-$default_workday}
    param_sort=${param_sort:-$default_sort}
    param_index=${param_index:-$default_index}
    param_year=$(($param_date / 10000))
    param_month=$(($param_date / 100 - $param_year * 100))
    param_quarter=$((($param_month - 1) / 3 + 1 ))
    param_file=$([ "${param_index}" == "daily" ] && echo "${param_sort}.${param_date}" || echo "${param_sort}" )
}

function create_cache_key()
{
    echo "${param_year}-Q${param_quarter}-${param_file}-${param_index}"
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

parse_args "$@"
set_params

index_uri="${edgar_archive_url}/edgar/${param_index}-index/${param_year}/QTR${param_quarter}/${param_file}.idx"
cache_file=$(get_cache_file "$(create_cache_key)")

if [[ ! -f ${cache_file} ]]
then
    echo "Downloading ${index_uri} ..."
    curl -s "${index_uri}" \
        -H "User-Agent: ${user_agent}"  \
        -H "Accept-Encoding: deflate, gzip;q=1.0, *;q=0.5" > ${cache_file}
fi

cat ${cache_file} | less
echo "${index_uri} -> ${cache_file}"
