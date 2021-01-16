#!/bin/bash
cd /root/wowserver
rm src/wotlk.sql
docker-compose exec cmangos bash -c "mysqldump --all-databases > wotlk.sql"
mount /dev/sdb1 /mnt/
tar cpzf "/mnt/$(date +"%y%m%d").tar.gz" src/wotlk.sql
sync
umount /mnt
