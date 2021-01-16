#!/bin/bash
cd src
#git clone git@github.com:cmangos/mangos-wotlk.git
git clone https://github.com/cmangos/mangos-wotlk.git
cd mangos-wotlk
#git remote add canidae git@github.com:canidae/mangos-wotlk.git
git remote add canidae https://github.com/canidae/mangos-wotlk.git
git config pull.rebase true
cd ..
#git clone git@github.com:cmangos/wotlk-db.git
git clone https://github.com/cmangos/wotlk-db.git
cd wotlk-db
#git remote add canidae git@github.com:canidae/wotlk-db.git
git remote add canidae https://github.com/canidae/wotlk-db.git
git config pull.rebase true
cd ..
cd ..
