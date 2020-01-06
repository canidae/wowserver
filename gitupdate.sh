#!/bin/bash
git pull
cd build/mangos-classic
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
git merge --no-edit origin/new_ahbot
cd -
cd files/cmangos/classic-db
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
cd -
