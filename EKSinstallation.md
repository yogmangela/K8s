# Elastic Kubernetes Service (Amazon EKS) K8's
## You can instsall K8's locally using 'minikube'
## Pre-Requisites :
This is easiest way to create an EKS cluster is via open source eksctl commantline tool.

Download latest release and run: 
follow(https://eksctl.io)
- Step a: Downlaod eksctl
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
```

```
sudo mv /tmp/eksctl /usr/local/bin
```

Step: add user credential:
```
aws configure
```
- you will need IAM-role with 
- - Access key ID:
- - Secret access key:


Step 3: Install kubectl
```
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl

chmod +x ./kubectl

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export 
PATH=$PATH:$HOME/bin

echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

```

Step:4 Check cluster created, check cluster created
```
eksctl create cluster --name kuar-cluster
```
```
kubectl version --short --client
kubectl version
```
Step5: check nodes
```
[ec2-user@ip-172-31-33-140 ~]$ kubectl get nodes
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-61-171.eu-west-1.compute.internal   Ready    <none>   36m   v1.14.9-eks-1f0ca9
ip-192-168-67-218.eu-west-1.compute.internal   Ready    <none>   36m   v1.14.9-eks-1f0ca9
[ec2-user@ip-172-31-33-140 ~]$
```


```
[ec2-user@ip-172-31-33-140 ~]$ kubectl get componentstatuses
NAME                 STATUS    MESSAGE             ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health":"true"}
[ec2-user@ip-172-31-33-140 ~]$

```
to check nodes

```
[ec2-user@ip-172-31-33-140 ~]$ kubectl get nodes
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-61-171.eu-west-1.compute.internal   Ready    <none>   36m   v1.14.9-eks-1f0ca9
ip-192-168-67-218.eu-west-1.compute.internal   Ready    <none>   36m   v1.14.9-eks-1f0ca9
[ec2-user@ip-172-31-33-140 ~]$
```
you  can use below command to describe node:

```
[ec2-user@ip-172-31-33-140 ~]$ kubectl describe nodes ip-192-168-61-171.eu-west-1.compute.internal
```

you will notice :
- OS
- Memory
- pods
- cpu
- boot ID
- Kernel Version

step6:setupkube proxy, which controls routing network traffic. 
