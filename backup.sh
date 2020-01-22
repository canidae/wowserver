#!/bin/bash
cd /root/wowserver
docker-compose down
mount /dev/sdb1 /mnt/
# TODO: backup using sql dump
tar cpzf "/mnt/$(date +"%y%m%d").tar.gz" /var/lib/docker/volumes/wowserver_database
sync
umount /mnt
docker-compose up -d
