#!/bin/sh

export WORK_DIR=$(pwd)

# Conditional statement for setting workdir variable when the program boots for the first time
if grep -Fxq "WORKDIR=$WORK_DIR" ${WORK_DIR}/.env
then
    echo 
else
    sed -i "2iWORKDIR=$WORK_DIR" ${WORK_DIR}/.env
    sudo docker buildx build -t confluentinc/cp-mysql-server-connect:7.3.2 .
    sudo mkdir ${WORK_DIR}/mysql
fi

sudo docker compose up -d