#! bin/bash

git clone https://github.com/yogmangela/K8s.git

cd monitoring

kubectl create namespace monitoring

kubectl create -f clusterRole.yaml

kubectl create -f config-map.yaml

kubectl create  -f prometheus-deployment.yaml 
