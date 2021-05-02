#!/bin/bash

function get_cache_dir()
{
    echo "${etipme_cache_dir/#\~/$HOME}"
}

function get_cache_file()
{
    cache_dir="$(get_cache_dir)"
    mkdir -p ${cache_dir}

    echo "${cache_dir}/$1"
} 

