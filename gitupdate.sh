#!/bin/bash
git pull
cd src/mangos-classic
git fetch origin
git fetch upstream
git checkout master
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
git merge --no-edit origin/faerie_fix
git merge --no-edit origin/stopresting
git merge --no-edit origin/new_mysql
cd -
cd src/classic-db
git fetch origin
git fetch upstream
git checkout master
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
git merge --no-edit origin/felsteed
cd -
