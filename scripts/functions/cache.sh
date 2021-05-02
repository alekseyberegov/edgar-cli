#!/bin/bash

#
# Parameters:
# -----------
# $1 - cache base dir
# $2 - cache record uri
#
function get_cache_file()
{
    cache_dir="${1/#\~/$HOME}"
    mkdir -p ${cache_dir}

    cache_id=$(echo -n "$2" | md5)
    echo "${cache_dir}/${cache_id}"
} 