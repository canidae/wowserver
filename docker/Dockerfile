FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y build-essential cmake libboost-all-dev libmysql++-dev libssl-dev expect gdb mariadb-server libssl1.1 libmysqlclient20 less vim
WORKDIR /cmangos
CMD ./start-server.sh unbuffer
