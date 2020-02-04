#!/bin/bash
git submodule init
git submodule update --no-fetch
cd build/mangos-classic
git remote add upstream https://github.com/cmangos/mangos-classic.git
cd -
cd files/cmangos/classic-db
git remote add upstream https://github.com/cmangos/classic-db.git
cd -
