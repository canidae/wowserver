#!/bin/bash
# parameter to this script can be "valgrind" or "gdb" (for debugging) for debugging
mkdir -p /cmangos/build
cd /cmangos/build
cmake -DDEBUG=1 -DBUILD_EXTRACTORS=ON -DBUILD_AHBOT=YES -DCMAKE_INSTALL_PREFIX=../ ../mangos-classic
make -j`nproc`
make install
cd -
service mysql start
cd /cmangos/mangos-classic/sql
mysql -e "DROP DATABASE IF EXISTS classicmangos;"
sed 's/CREATE DATABASE `/CREATE DATABASE IF NOT EXISTS `/' create/db_create_mysql.sql > /tmp/db_create_mysql.sql
mysql < /tmp/db_create_mysql.sql
mysql classicmangos < base/mangos.sql
if [ $(ls -1 /var/lib/mysql/classiccharacters | wc -l) -lt 2 ]; then
    mysql classiccharacters < base/characters.sql
fi
if [ $(ls -1 /var/lib/mysql/classicrealmd | wc -l) -lt 2 ]; then
    mysql classicrealmd < base/realmd.sql
    mysql classicrealmd -e "DELETE FROM account WHERE username!='ADMINISTRATOR'; UPDATE realmlist SET name='Pinchcliffe';"
fi
cd /cmangos/classic-db
printf "FORCE_WAIT=NO\nCORE_PATH=../mangos-classic" > InstallFullDB.config
sed 's/MYSQL_COMMAND=.*/MYSQL_COMMAND="mysql classicmangos"/;s/DEV_UPDATES="NO"/DEV_UPDATES="YES"/' InstallFullDB.sh > /tmp/InstallFullDB.sh
bash /tmp/InstallFullDB.sh
mysql classicmangos -e "UPDATE command SET security=3 WHERE name LIKE 'account %' AND security=4;"
cd /cmangos/bin
ln -sf /cmangos/wow-client/maps
ln -sf /cmangos/wow-client/dbc
ln -sf /cmangos/wow-client/Cameras
ln -sf /cmangos/wow-client/vmaps
ln -sf /cmangos/wow-client/mmaps
if [ ! -e maps ]; then
    cd /cmangos/wow-client
    cp /cmangos/bin/tools/* .
    printf "8\ny\ny" | bash ExtractResources.sh a
    cd /cmangos/bin
fi
./realmd --s run
$1 ./mangosd
killall -SIGINT realmd
service mysql stop
