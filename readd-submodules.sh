#!/bin/bash
###
# File: readd-submodules.sh
# Author: Leopold Meinel (leo@meinel.dev)
# -----
# Copyright (c) 2022 Leopold Meinel & contributors
# SPDX ID: GPL-3.0-or-later
# URL: https://www.gnu.org/licenses/gpl-3.0-standalone.html
# -----
###

set -eu

DIR=$(dirname "$0")
cd "${DIR:?}"
readarray -t SUBMODULES < <(git submodule status | cut -d' ' -f2 | tr -d "[:blank:]")
SUBMODULES_LENGTH="${#SUBMODULES[@]}"
git submodule init
git submodule update
git submodule deinit -f --all
for ((i = 0; i < SUBMODULES_LENGTH; i++)); do
    rm -rf "${DIR:?}/${SUBMODULES[$i]}"
    rm -rf "${DIR:?}/.git/modules/${SUBMODULES[$i]}"
    {
        unset 'SUBMODULES[$i]'
        continue
    }
    SUBMODULES=("${SUBMODULES[@]}")
done
rm -rf "${DIR:?}/.gitmodules"
git add .
git commit -m "Remove submodules" || true
git submodule add git@github.com:LeoMeinel/vitalback.git
git submodule add git@github.com:LeoMeinel/vitalbroadcast.git
git submodule add git@github.com:LeoMeinel/vitalcondense.git
git submodule add git@github.com:LeoMeinel/vitalcraft.git
git submodule add git@github.com:LeoMeinel/vitalenchant.git
git submodule add git@github.com:LeoMeinel/vitalfeed.git
git submodule add git@github.com:LeoMeinel/vitalfix.git
git submodule add git@github.com:LeoMeinel/vitalfly.git
git submodule add git@github.com:LeoMeinel/vitalheal.git
git submodule add git@github.com:LeoMeinel/vitalhome.git
git submodule add git@github.com:LeoMeinel/vitalkeepexp.git
git submodule add git@github.com:LeoMeinel/vitalkeepinv.git
git submodule add git@github.com:LeoMeinel/vitalmail.git
git submodule add git@github.com:LeoMeinel/vitalmotd.git
git submodule add git@github.com:LeoMeinel/vitalplayertime.git
git submodule add git@github.com:LeoMeinel/vitalplayerweather.git
git submodule add git@github.com:LeoMeinel/vitalrules.git
git submodule add git@github.com:LeoMeinel/vitalseen.git
git submodule add git@github.com:LeoMeinel/vitalskull.git
git submodule add git@github.com:LeoMeinel/vitalspawn.git
git submodule add git@github.com:LeoMeinel/vitalsuicide.git
git submodule add git@github.com:LeoMeinel/vitaltp.git
git submodule add git@github.com:LeoMeinel/vitaltpa.git
git submodule add git@github.com:LeoMeinel/vitaltrash.git
git submodule add git@github.com:LeoMeinel/vitalwarp.git
git submodule add git@github.com:LeoMeinel/vitalwelcome.git
git submodule init
git submodule sync
git submodule update --remote --merge
git add .
git commit -m "Add submodules" || true
