#!/bin/bash
git pull
git submodule update --remote --recursive
cd build/mangos-classic
git pull origin pinchcliffe
cd -
cd files/cmangos/classic-db
git pull origin pinchcliffe
cd -
