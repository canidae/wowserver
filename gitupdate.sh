#!/bin/bash
cd src/mangos-wotlk
git fetch canidae
git fetch origin
git checkout master
git checkout --detach
git pull --no-edit origin master
cd -
cd src/wotlk-db
git fetch canidae
git fetch origin
git checkout master
git checkout --detach
git pull --no-edit origin master
cd -
