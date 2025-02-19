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
    sudo docker buildx build -t confluentinc/cp-pgsql-server-connect:7.3.2 --target kafka_server .
    sudo docker buildx build -t spark-modified:3.5.4 --target spark .
    
    #creating the directories for storage
    sudo mkdir ${WORK_DIR}/pgsql
    sudo mkdir -p ${WORK_DIR}/kafka/storage
    sudo mkdir -p ${WORK_DIR}/kafka/data
    sudo mkdir -p ${WORK_DIR}/spark/data
    sudo mkdir -p ${WORK_DIR}/spark/apps
    sudo mkdir -p ${WORK_DIR}/es_data/data
    sudo mkdir -p ${WORK_DIR}/kibana_data/data

    #granting permission to them
    sudo chmod 777 ${WORK_DIR}/pgsql
    sudo chmod -R 777  ${WORK_DIR}/kafka
    sudo chmod -R 777  ${WORK_DIR}/spark/data
    sudo chmod -R 777 ${WORK_DIR}/es_data
    sudo chmod -R 777 ${WORK_DIR}/kibana_data

    #moving kibana.yml to kibana_data
    sudo mv ${WORK_DIR}/kibana.yml ${WORK_DIR}/kibana_data
fi

#starting the container cluster
sudo docker compose up -d

#A waiting period of 60 secs to ensure that all components are up and running
echo "Waiting for \"1 minute\" so that the cluster could be up and running\n\n"
sleep 60

#submitting the connector
curl -X POST -H "Content-Type: application/json" --data @connectors/debezium-pgsql.json http://localhost:8083/connectors
curl -X POST -H "Content-Type: application/json" --data @connectors/confluent-elasticsearch.json http://localhost:8083/connectors