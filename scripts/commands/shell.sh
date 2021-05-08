#!/bin/bash

. "${ETIPME_WORKDIR}/functions/base.sh"
. "${ETIPME_WORKDIR}/functions/pyenv.sh"

venv_run pip install --editable "${ETIPME_WORKDIR}/packages"