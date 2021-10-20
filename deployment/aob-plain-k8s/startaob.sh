#!/bin/bash
. .env
cd ../../
echo "replacing machine ip"
sed -i "s/master_node_ip/${MACHINE_IP}/g" k8s/configmap.yml
kubectl apply -f k8s/