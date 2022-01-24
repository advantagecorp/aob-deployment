<p align="center">
  <a href="https://ci.advantageonlinebanking.com/" target="blank"><img  width=500 src="https://github.com/advantagecorp/aob-deployment/blob/master/advantageBank-logo.svg" alt="Advantage Bank logo"></a>
</p>

## Description
The Advantage Online Banking (AOB) app consists of both the AOB Bank Demo and the AOB Management Console. AOB can be deployed in several ways:
1.	Docker-compose (single-machine deployment). Use this for quick deployment with fast setup. It’s  probably best for a quick demo
2.	Kubernetes cluster. Use this to show the Kubernetes capabilities without using a cloud provider (which incurs more cost). In this situation, you must run commands that install Kubernetes and create nodes from scratch.
3.	Managed Kubernetes cluster. Use this for long-term deployment on a system where you will use it for a lengthy period of time (not for a quick demo). In this situation, the cloud provider installs Kubernetes and creates the nodes; you do NOT have to do that. All you have to do is get the cluster ready for use.

## Prerequisites
-   Centos 7
- [Docker](https://docs.docker.com/engine/install/centos/)
- [Docker-compose](https://docs.docker.com/compose/install/)

## Installation
- Clone this repo.

		git clone https://github.com/advantagecorp/aob-deployment.git

- cd into the deployment folder

		cd aob-deployment
		
- change the access permissions of startup.sh

        chmod +x startup.sh
        
- run the script

        ./stratup.sh
		

		
