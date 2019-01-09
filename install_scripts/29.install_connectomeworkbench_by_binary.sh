#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL

D_DIR=$INSTALL
mkdir -p $D_DIR


#install software
RANDOM_TEMP=${RANDOM}
wget https://ftp.humanconnectome.org/workbench/workbench-linux64-v1.3.2.zip?dl=0 -O ${RANDOM_TEMP}.zip; unzip -o ${RANDOM_TEMP}.zip -d ${D_DIR}; rm ${RANDOM_TEMP}.zip




