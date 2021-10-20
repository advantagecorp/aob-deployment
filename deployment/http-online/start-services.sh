#!/bin/bash
VAR=${1:-"hostname"}
hostname=$(sed 's/[\/\.]/\\&/g' <<< $VAR)

cp -R ../../management-console-app ./
cp -R ../../web-app ./

echo "REACT_APP_API_URL=http://$hostname/api" > ./web-app/.env.production
sed -i "s/https/http/g" ./management-console-app/src/environments/environment.prod.ts 
sed -i "s/ci.*com/$hostname/g" ./management-console-app/src/environments/environment.prod.ts 

docker build -t docker-alpine .
docker run -v /var/run/docker.sock:/var/run/docker.sock -v configvolume:/app/config docker-alpine
