#!/bin/bash

url_encode() {
  local string="${@}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done

  echo "${encoded}"
}

function str_join() {
    local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}";
}

function abs_path() {
    echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

function print_doc() {
    sed -n -e '/DOCUMENTATIONXX$/,/^DOCUMENTATIONXX$/p' "$1" |
    sed -e '/DOCUMENTATIONXX$/d' |
    ( [ -z "$2" ] && cat || sed -e "s/\${1}/$2/" ) | 
    ( [ -z "$3" ] && cat || sed -e "s/\${2}/$3/" ) | 
    ( [ -z "$4" ] && cat || sed -e "s/\${3}/$4/" ) 
}