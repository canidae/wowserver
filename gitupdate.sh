#!/bin/bash
git pull
cd build/mangos-classic
git fetch origin
git fetch upstream
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
git merge --no-edit origin/ahbot
git merge --no-edit origin/create_db_if_not_exists
cd -
cd files/cmangos/classic-db
git fetch origin
git fetch upstream
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
cd -
