#!/bin/bash
git submodule init
git submodule update --no-fetch
cd src/mangos-classic
git remote add upstream git@github.com:cmangos/mangos-classic.git
cd -
cd src/classic-db
git remote add upstream git@github.com:cmangos/classic-db.git
cd -
