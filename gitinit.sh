#!/bin/bash
cd build/mangos-classic
git submodule init
git submodule update
git remote add upstream https://github.com/cmangos/mangos-classic.git
cd -
cd files/cmangos/classic-db
git submodule init
git submodule update
git remote add upstream https://github.com/cmangos/classic-db.git
cd -
