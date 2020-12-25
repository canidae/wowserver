#!/bin/bash
# parameter to this script can be "valgrind" or "gdb" for debugging
mkdir -p /cmangos/build
cd /cmangos/build
cmake -DDEBUG=0 -DBUILD_EXTRACTORS=ON -DBUILD_AHBOT=YES -DCMAKE_INSTALL_PREFIX=../ ../mangos-wotlk
make -j`nproc`
make install
cd -
service mysql start
cd /cmangos/mangos-wotlk/sql
mysql -e "DROP DATABASE IF EXISTS wotlkmangos;"
sed 's/CREATE DATABASE `/CREATE DATABASE IF NOT EXISTS `/' create/db_create_mysql.sql > /tmp/db_create_mysql.sql
mysql < /tmp/db_create_mysql.sql
mysql wotlkmangos < base/mangos.sql
if [ $(ls -1 /var/lib/mysql/wotlkcharacters | wc -l) -lt 2 ]; then
    mysql wotlkcharacters < base/characters.sql
fi
if [ $(ls -1 /var/lib/mysql/wotlkrealmd | wc -l) -lt 2 ]; then
    mysql wotlkrealmd < base/realmd.sql
    mysql wotlkrealmd -e "DELETE FROM account WHERE username!='ADMINISTRATOR'; UPDATE realmlist SET name='Pinchcliffe';"
fi
cd /cmangos/wotlk-db
printf "FORCE_WAIT=NO\nCORE_PATH=../mangos-wotlk" > InstallFullDB.config
sed 's/MYSQL_COMMAND=.*/MYSQL_COMMAND="mysql wotlkmangos"/;s/DEV_UPDATES="NO"/DEV_UPDATES="YES"/' InstallFullDB.sh > /tmp/InstallFullDB.sh
bash /tmp/InstallFullDB.sh
mysql wotlkmangos -e "UPDATE command SET security=3 WHERE name LIKE 'account %' AND security=4;"
cd /cmangos/bin
ln -sf ../wow-client/maps
ln -sf ../wow-client/dbc
ln -sf ../wow-client/Cameras
ln -sf ../wow-client/vmaps
ln -sf ../wow-client/mmaps
if [ ! -e maps ]; then
    cd /cmangos/wow-client
    cp /cmangos/bin/tools/* .
    printf "8\ny\ny" | bash ExtractResources.sh a
    cd /cmangos/bin
fi
./realmd --s run
$1 ./mangosd 2>>stderr.log
killall -SIGINT realmd
service mysql stop
