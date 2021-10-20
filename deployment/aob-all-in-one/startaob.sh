#!/bin/bash
. .env
if [ -z ${MACHINE_IP} ]
then
    echo "no external ip\name provided, trying to get it from ipinfo.io"
    MACHINE_IP=`curl https://ipinfo.io/ip`
fi
if [ ${SECURE_GATEWAY} == "true" ]
then
    echo "using https"
    sed -i "s/MACHINE_IP/${MACHINE_IP}/g" .env
    sed -i "s/GW_PORT/443/g" .env
    sed -i "s/GW_PROTOCOL/https/g" .env
else
    echo "using http"
    sed -i "s/MACHINE_IP/${MACHINE_IP}/g" .env
    sed -i "s/GW_PORT/${GATEWAY_PORT}/g" .env
    sed -i "s/GW_PROTOCOL/http/g" .env
fi
docker login -u=advantageonlineshoppingapp -p=W3lcome1
docker-compose pull
docker network create advbank
docker-compose up -d





