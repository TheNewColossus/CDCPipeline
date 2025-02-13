#!/bin/sh

export WORK_DIR=$(pwd)

# Conditional statement for setting workdir variable when the program boots for the first time
if grep -Fxq "WORKDIR=$WORK_DIR" ${WORK_DIR}/.env
then
    echo 
else
    #setting up the work_dir variable
    sed -i "2iWORKDIR=$WORK_DIR" ${WORK_DIR}/.env
    
    #building the docker image to install the connector-plugin
    sudo docker buildx build -t confluentinc/cp-pgsql-server-connect:7.3.2 .
    
    #creating the directories for storage
    sudo mkdir ${WORK_DIR}/pgsql
    sudo mkdir -p ${WORK_DIR}/kafka/storage
    sudo mkdir -p ${WORK_DIR}/kafka/data
    sudo mkdir -p ${WORK_DIR}/spark/data
    sudo mkdir -p ${WORK_DIR}/spark/apps

    #granting permission to them
    sudo chmod 755 ${WORK_DIR}/pgsql
    sudo chmod 755 ${WORK_DIR}/kafka
    sudo chmod 755 ${WORK_DIR}/kafka/storage
    sudo chmod 755 ${WORK_DIR}/kafka/data
    sudo chmod 755 ${WORK_DIR}/spark/data
    sudo chmod 755 ${WORK_DIR}/spark/apps
fi

#starting the container cluster
sudo docker compose up -d

#A waiting period of 60 secs to ensure that all components are up and running
echo "Waiting for \"1 minute\" so that the cluster could be up and running\n\n"
sleep 60

#submitting the connector
curl -X POST -H "Content-Type: application/json" --data @debezium-pgsql.json http://localhost:8083/connectors
