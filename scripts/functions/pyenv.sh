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
    $command "$@"
}