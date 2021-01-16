#!/bin/bash
cd /root/wowserver
mount /dev/sdb1 /mnt/
docker-compose exec cmangos bash -c "mysqldump --all-databases > wotlk.sql"
tar cpzf "/mnt/$(date +"%y%m%d").tar.gz" src/wotlk.sql
sync
umount /mnt
