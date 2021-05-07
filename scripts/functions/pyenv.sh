#!/bin/bash

function venv_create()
{
    venv_dir=${etipme_pyenv_dir/#\~/$HOME}

    if [[ ! -f "${venv_dir}/bin/activate" ]]
    then
        mkdir -p ${venv_dir} && \
        python3 --version && \
        python3 -m venv ${venv_dir}
    fi
}

function venv_run()
{
    venv_dir=${etipme_pyenv_dir/#\~/$HOME}

    if [[ ! -f "${venv_dir}/bin/activate" ]]
    then
        printf -- "The python venv is not initialized\n"
        exit 1
    fi

    source ${venv_dir}/bin/activate

    command=$1; shift
    echo "$command ${@/#/arg=}"
    $command "$@"
}

function venv_pip()
{
    if [[ -z "$2" ]]
    then
        printf -- "Error: missing the module name\n"
        usage
    fi

    venv_run pip3 "$@"
}

function venv_exec()
{
    spec=$1; shift
    declare -a params=($@)

    IFS=';' read -ra args <<< "$spec"
    for i in "${!args[@]}"
    do
        if [[ "${args[$i]}" != "*" && -z "${params[$i]}" ]]
        then
            printf -- "Error in \"%s\" (%s): missing parameter \"%s\"\n" "${params[*]}" "${args[*]}" "${args[$i]}"
            usage
        fi
    done

    venv_run "$@"
}