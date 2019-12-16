#!/bin/bash
cd /root/wowserver
docker-compose down
mount /dev/sdb1 /mnt/
# TODO: backup using sql dump
tar cpzf "/mnt/$(date +"%y%m%d").tar.gz" /var/lib/docker/volumes/wowserver_database
sync
umount /mnt
git pull
git submodule update --remote --recursive
cd build/mangos-classic
git pull origin pinchcliffe
cd -
docker-compose up -d --build
