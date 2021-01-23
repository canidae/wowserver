#!/bin/bash
git pull
cd src/mangos-wotlk
git fetch canidae
git fetch origin
git checkout master
git checkout --detach
git pull --no-edit origin master
git merge --no-edit canidae/new_mysql
git merge --no-edit canidae/ahbot_balancing
#git merge --no-edit canidae/pinchcliffe
#git merge --no-edit canidae/faerie_fix
#git merge --no-edit canidae/stopresting
cd -
cd src/wotlk-db
git fetch canidae
git fetch origin
git checkout master
git checkout --detach
git pull --no-edit origin master
git merge --no-edit canidae/disrupt_their_reinforcements
#git merge --no-edit canidae/pinchcliffe
#git merge --no-edit canidae/felsteed
cd -
