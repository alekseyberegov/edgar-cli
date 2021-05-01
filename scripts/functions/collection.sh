#!/bin/bash

function foreach () {
    arr="$(declare -p $1)" ; eval "declare -a f="${arr#*=};
    for i in ${!f[@]}; do $2 "$i" "${f[$i]}"; done
}

#
# Join array elements using the given delimiter
#
# Parameters
# ----------
# $1 - the delimiter
# $2 - the array
#
# Returns
# -------
# a string
#
# Example
# -------
# echo $(array_join "&" param_array)
#
function array_join() {
    local d=$1;
    arr="$(declare -p $2)" ; eval "declare -a f="${arr#*=};
    printf "%s" "${f[@]/#/$d}"
}