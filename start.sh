#!/bin/sh

export WORK_DIR=$(pwd)

if grep -fxq "WORKDIR=$WORK_DIR" ${WORK_DIR}/.env
  then 
    echo
else
  sed -i "2iWORKDIR=$WORK_DIR" ${WORK_DIR}/.env
fi