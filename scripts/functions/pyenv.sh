#!/bin/bash

function create_venv()
{
    venv_dir=${etipme_pyenv_dir/#\~/$HOME}

    if [[ ! -f "${venv_dir}/bin/activate" ]]
    then
        mkdir -p ${venv_dir} && \
        python3 --version && \
        python3 -m venv ${venv_dir}
    fi
}


