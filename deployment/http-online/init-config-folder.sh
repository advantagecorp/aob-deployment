#!/bin/bash

cd config && git init && \ 
    git config --global user.name "Advbank Microfocus" && \
    git config --global user.email "email@microfocus.com" && \
    git add --all && \
    git commit -m "initial commit"

docker-compose up