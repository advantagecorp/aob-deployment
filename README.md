<p align="center">
  <a href="https://ci.advantageonlinebanking.com/" target="blank"><img  width=500 src="https://github.com/advantagecorp/aob-deployment/blob/master/advantageBank-logo.svg" alt="Advantage Bank logo"></a>
</p>

## Description
The Advantage Online Banking (AOB) app consists of both the AOB Bank Demo and the AOB Management Console. AOB can be deployed in several ways:
1.	[Docker-compose](#deploy-aob-using-docker-compose) (single-machine deployment). Use this for quick deployment with fast setup. It’s  probably best for a quick demo
2.	[Kubernetes cluster](#deploy-aob-to-a-kubernetes-cluster). Use this to show the Kubernetes capabilities without using a cloud provider (which incurs more cost). In this situation, you must run commands that install Kubernetes and create nodes from scratch.
3.	[Managed Kubernetes cluster](#deploy-aob-on-a-managed-kubernetes-cluster-awsazuregcp). Use this for long-term deployment on a system where you will use it for a lengthy period of time (not for a quick demo). In this situation, the cloud provider installs Kubernetes and creates the nodes; you do NOT have to do that. All you have to do is get the cluster ready for use.

## Prerequisites
-   Centos 7
- [Docker](https://docs.docker.com/engine/install/centos/)
- [Docker-compose](https://docs.docker.com/compose/install/)

## Installation
### Deploy AOB using docker-compose
- Clone this repo.

      git clone https://github.com/advantagecorp/aob-deployment.git

- cd into the deployment folder

      cd aob-deployment

- change the access permissions of startup.sh

        chmod +x startup.sh

- run the script

        ./stratup.sh

### Deploy AOB to a kubernetes cluster
- cd into the deployment folder

      cd aob-deployment/aob-plain-k8s

- change the access permissions of startup.sh

        chmod +x startup.sh

- run the script

        ./stratup.sh

### Deploy AOB on a managed kubernetes cluster (AWS/Azure/Gcp)
## Prerequisites
- [Helm](https://helm.sh/docs/intro/install/)
- cd into the deployment folder

      cd aob-deployment/helm-releases
- Run helm command (replace with the desired AOB version)

    ` 
    helm install <deployment-name>
    --set config.managedK8s=true
    --set webapp.host.ip=<machine-ip/domain-name>
    --set config.secureGateway=false aob-1.1.0.tgz
      `


  - managedK8s = on a managed cluster set this value to true
  - webapp.host.ip = use the cloud provider endpoint ip/domain name
