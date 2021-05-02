#!/bin/bash

#
# Parameters:
# -----------
# $1 - cache base dir
# $2 - cache key
#
function get_cache_file()
{
    cache_dir="${1/#\~/$HOME}"
    mkdir -p ${cache_dir}

    echo "${cache_dir}/$2"
} 