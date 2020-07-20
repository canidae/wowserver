#!/bin/bash
git pull
cd src/mangos-classic
git fetch origin
git fetch upstream
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
cd -
cd src/classic-db
git fetch origin
git fetch upstream
git checkout --detach
git pull --no-edit upstream master
git merge --no-edit origin/pinchcliffe
cd -
