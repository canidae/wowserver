FROM ubuntu:latest AS builder
WORKDIR cmangos
RUN mkdir build run
RUN apt-get update && apt-get install -y build-essential cmake libboost-all-dev libmysql++-dev libssl-dev
COPY mangos-classic mangos-classic
WORKDIR build
RUN cmake -DDEBUG=0 -DBUILD_EXTRACTORS=ON -DCMAKE_INSTALL_PREFIX=../run ../mangos-classic
RUN make -j`nproc`
RUN make install

FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y expect mariadb-server libssl1.1 libmysqlclient20
COPY --from=builder /cmangos/run /cmangos
COPY --from=builder /cmangos/mangos-classic/sql /cmangos/sql
WORKDIR /cmangos/bin
CMD service mysql start && \
    if [ ! -d /var/lib/mysql/classicmangos ]; then \
        cd ../sql && \
        mysql < create/db_create_mysql.sql && \
        mysql classicmangos < base/mangos.sql && \
        mysql classiccharacters < base/characters.sql && \
        mysql classicrealmd < base/realmd.sql && \
        mysql classicrealmd -e "DELETE FROM account WHERE username!='ADMINISTRATOR'; UPDATE realmlist SET name='Pinchcliffe';" && \
        cd ../bin; \
    fi; \
    cd ../classic-db && \
    printf "FORCE_WAIT=NO\nCORE_PATH=../" > InstallFullDB.config && \
    sed -i 's/MYSQL_COMMAND=.*/MYSQL_COMMAND="mysql classicmangos"/g' InstallFullDB.sh && \
    bash InstallFullDB.sh && \
    mysql classicmangos -e "UPDATE command SET security=3 WHERE name='account create';" && \
    cd ../bin; \
    ln -s ../wow-client/maps; \
    ln -s ../wow-client/dbc; \
    ln -s ../wow-client/Cameras; \
    ln -s ../wow-client/vmaps; \
    ln -s ../wow-client/mmaps; \
    if [ ! -e maps ]; then \
        cd ../wow-client && \
        cp ../bin/tools/* . && \
        printf "8\ny\ny" | bash ExtractResources.sh a && \
        cd ../bin; \
    fi; \
    ./realmd --s run && \
    unbuffer ./mangosd
