#!/bin/sh

export WORK_DIR=$(pwd)

# Conditional statement for setting workdir variable when the program boots for the first time
if grep -Fxq "WORKDIR=$WORK_DIR" ${WORK_DIR}/.env
then
    echo $WORK_DIR
else
    sed -i "2iWORKDIR=$WORK_DIR" ${WORK_DIR}/.env
    echo $WORK_DIR
fi