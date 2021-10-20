## Deployment Instructions

Current folder deploys the whole Advantage Online Banking Demo setup for HTTP.

## Description

#### Setup

Docker image is created with `/config` folder initialized as git and frontend application code included.

docker-compose.yml is run using the host docker to bring everything to live.

NOTE: If you do not want to pull the whole repository - you need to copy and paste `management-console-app` and `web-app` folders in the current folder - then comment out line 5 and 6 on `start-services.sh`

#### How To Run

- Give executable permissions to ./start-services.sh (`sudo chmod 777 ./start-services.sh`)

- Run: `./start-services.sh <HOSTNAME>` (e.g. `./start-services.sh www.example.com`) You need to provide the hostname that will point to the gateway otherwise the applications won't be able to connect to the API.

#### If you host machine is behind proxy

- Open Dockerfile and uncomment line 13 and set up proper proxy value
