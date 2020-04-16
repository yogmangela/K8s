# [Installing kubeadm, kubelet and kubectl on all machines:] (https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)

### Run below command:

## What is what ? :
   - kubeadm: the command to bootstrap the cluster.
   - kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
   - kubectl: the command line util to talk to your cluster.

## Step1: Installing kubeadm, kubelet and kubectl
# Make sure to repeate step1 on all the machies (Master and Nodes).
```
sudo -i 
```
```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
```
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```
```
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```
```
sudo apt-get update
```
```
sudo apt-get install -y kubelet kubeadm kubectl
```
```
sudo apt-mark hold kubelet kubeadm kubectl
```

## Step 2 : once above steps complete go back to master node:

## Brief notes:

- kubeadm initialise: node as master : Get secrete token
- kubeadmin to join: using token
- choose a network driver for POD network
- -  

We will have three steps:
- Initialise kubeadm;
- Join the nodes to kubeadm:
- Create a network driver for POD Network

##  Step 3: Kubeadm has to be done as root user so on  master :

do 
```
sudo -i
```

##  Step 4:  [when you run 'kubadm init': on master](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) 

###  you get below out puts with seceret
```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.36.188:6443 --token sd2hhs.ziy2uc6h9f88rpcz \
--discovery-token-ca-cert-hash sha256:2b83848eff19b113aeb7d28de3aca0cd1d9a4f6fe4fa4b073f9c98cc08dd68f5
root@ip-172-31-36-188:~#
```

##  Step 5: run below command on NODE as regualt user not Root user. so user like Ubuntu / ec2-user etc. 

Joining the master on K8's has to be done usong root user. 

so do switch user
'su ubuntu' or do exit to exit root user mode.

```
mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
## step 5.1: make sure to add PORT in your INBOUND Security Groups : 6443

## step 6: join Master
```
kubeadm join 172.31.36.188:6443 --token sd2hhs.Z.... --discovery-token-ca-cert-hash sha256:2b8......
```

## step 7: Go back to Master and check nodes joined:
## [Choose POD network implementation:](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

 - There are many POD networks: 
    - Calico
    - Canal
    - Cillium
    - Flannel ✔️
    - Kube-router
    - Romana
    - Weave Net ✔️
    - JuniperContrail

```
kubectl get nodes

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

```

Until POD network is not ready STATUS will not be ready.

## step8 : kubectl get nodes:

do "kubectl get nodes"
```
ubuntu@ip-172-31-46-174:~$ kubectl get nodes
NAME               STATUS   ROLES    AGE    VERSION
ip-172-31-40-6     Ready    <none>   100s   v1.18.1
ip-172-31-41-56    Ready    <none>   106s   v1.18.1
ip-172-31-46-174   Ready    master   11m    v1.18.1
ubuntu@ip-172-31-46-174:~$
```
## step8 : kubectl get nodes -o wide:
kubectl get nodes -o wide
```
ubuntu@ip-172-31-46-174:~$ kubectl get nodes -o wide
NAME               STATUS   ROLES    AGE     VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
ip-172-31-40-6     Ready    <none>   2m49s   v1.18.1   172.31.40.6     <none>        Ubuntu 18.04.3 LTS   4.15.0-1057-aws   docker://19.3.8
ip-172-31-41-56    Ready    <none>   2m55s   v1.18.1   172.31.41.56    <none>        Ubuntu 18.04.3 LTS   4.15.0-1057-aws   docker://19.3.8
ip-172-31-46-174   Ready    master   12m     v1.18.1   172.31.46.174   <none>        Ubuntu 18.04.3 LTS   4.15.0-1057-aws   docker://19.3.8
ubuntu@ip-172-31-46-174:~$
```

## Check pods 'kuectl get pods --all-namespaces' : This are managed by Kubernetes. 
## As you mak see this seven core component makes up K8's. This is crux of K8's
 they are system PODS

```
ubuntu@ip-172-31-46-174:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   coredns-66bff467f8-bnpst                   1/1     Running   0          21m
kube-system   coredns-66bff467f8-xxfq2                   1/1     Running   0          21m
kube-system   etcd-ip-172-31-46-174                      1/1     Running   0          21m
kube-system   kube-apiserver-ip-172-31-46-174            1/1     Running   0          21m
kube-system   kube-controller-manager-ip-172-31-46-174   1/1     Running   0          21m
kube-system   kube-proxy-7cnbs                           1/1     Running   0          12m
kube-system   kube-proxy-m8zf4                           1/1     Running   0          21m
kube-system   kube-proxy-n7hvf                           1/1     Running   0          12m
kube-system   kube-scheduler-ip-172-31-46-174            1/1     Running   0          21m
kube-system   weave-net-2v7nz                            2/2     Running   1          12m
kube-system   weave-net-56k5v                            2/2     Running   0          17m
kube-system   weave-net-t5q5l                            2/2     Running   1          12m
ubuntu@ip-172-31-46-174:~$
```

## Core components of K8's / to run K8's successfuly you need these components up & running

- Coredns
- etcd : k8's database
- kube-apiserver
- kube-controller-manager
- kube-proxy
- kube-scheduler
- Network

## Do 'docker ps' these are the containers running in order to run K8's

```
ubuntu@ip-172-31-46-174:~$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
07ce18e3a538        67da37a9a360            "/coredns -conf /etc…"   30 minutes ago      Up 30 minutes                           k8s_coredns_coredns-66bff467f8-bnpst_kube-system_2508b325-f5ef-4446-a4aa-a1608e2f5fc1_0
3c480deb39f6        67da37a9a360            "/coredns -conf /etc…"   30 minutes ago      Up 30 minutes                           k8s_coredns_coredns-66bff467f8-xxfq2_kube-system_6242783f-51e5-4ad2-9606-a58550bc0399_0
94e78be99a3d        k8s.gcr.io/pause:3.2    "/pause"                 30 minutes ago      Up 30 minutes                           k8s_POD_coredns-66bff467f8-bnpst_kube-system_2508b325-f5ef-4446-a4aa-a1608e2f5fc1_0
03efa0dbc8ba        k8s.gcr.io/pause:3.2    "/pause"                 30 minutes ago      Up 30 minutes                           k8s_POD_coredns-66bff467f8-xxfq2_kube-system_6242783f-51e5-4ad2-9606-a58550bc0399_0
802bfa3491cc        weaveworks/weave-npc    "/usr/bin/launch.sh"     30 minutes ago      Up 30 minutes                           k8s_weave-npc_weave-net-56k5v_kube-system_2e6cd577-881d-4222-b881-702c4d8f0c48_0
1f2f8938963a        weaveworks/weave-kube   "/home/weave/launch.…"   30 minutes ago      Up 30 minutes                           k8s_weave_weave-net-56k5v_kube-system_2e6cd577-881d-4222-b881-702c4d8f0c48_0
9e3d1a9f19cc        k8s.gcr.io/pause:3.2    "/pause"                 30 minutes ago      Up 30 minutes                           k8s_POD_weave-net-56k5v_kube-system_2e6cd577-881d-4222-b881-702c4d8f0c48_0
8635d6fdc342        4e68534e24f6            "/usr/local/bin/kube…"   35 minutes ago      Up 35 minutes                           k8s_kube-proxy_kube-proxy-m8zf4_kube-system_a0f1b50a-d802-4d47-aee1-916788bfca1c_0
0f6ecb2e7e06        k8s.gcr.io/pause:3.2    "/pause"                 35 minutes ago      Up 35 minutes                           k8s_POD_kube-proxy-m8zf4_kube-system_a0f1b50a-d802-4d47-aee1-916788bfca1c_0
e4e507c728e1        d1ccdd18e6ed            "kube-controller-man…"   35 minutes ago      Up 35 minutes                           k8s_kube-controller-manager_kube-controller-manager-ip-172-31-46-174_kube-system_2279fa91e37f38928bd8ccbd57ba27dc_0
aaf915a809d0        303ce5db0e90            "etcd --advertise-cl…"   35 minutes ago      Up 35 minutes                           k8s_etcd_etcd-ip-172-31-46-174_kube-system_c06eacf676a0e8c0e0778eac78aeb159_0
2799771a1c9b        6c9320041a7b            "kube-scheduler --au…"   35 minutes ago      Up 35 minutes                           k8s_kube-scheduler_kube-scheduler-ip-172-31-46-174_kube-system_363a5bee1d59c51a98e345162db75755_0
df9c05a341b7        a595af0107f9            "kube-apiserver --ad…"   35 minutes ago      Up 35 minutes                           k8s_kube-apiserver_kube-apiserver-ip-172-31-46-174_kube-system_d653e1f0c2a78b18fc7102aa604411bf_0
ef2a27e38627        k8s.gcr.io/pause:3.2    "/pause"                 35 minutes ago      Up 35 minutes                           k8s_POD_kube-scheduler-ip-172-31-46-174_kube-system_363a5bee1d59c51a98e345162db75755_0
26eba283770e        k8s.gcr.io/pause:3.2    "/pause"                 35 minutes ago      Up 35 minutes                           k8s_POD_kube-controller-manager-ip-172-31-46-174_kube-system_2279fa91e37f38928bd8ccbd57ba27dc_0
558ab662ed58        k8s.gcr.io/pause:3.2    "/pause"                 35 minutes ago      Up 35 minutes                           k8s_POD_kube-apiserver-ip-172-31-46-174_kube-system_d653e1f0c2a78b18fc7102aa604411bf_0
6ffa022c4145        k8s.gcr.io/pause:3.2    "/pause"                 35 minutes ago      Up 35 minutes                           k8s_POD_etcd-ip-172-31-46-174_kube-system_c06eacf676a0e8c0e0778eac78aeb159_0
ubuntu@ip-172-31-46-174:~$
```


## Let's check Nodes: 'docker ps' 
## you see similar containers are running on Nodes too.

```
root@ip-172-31-41-56:~# docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
8431d5b70292        573ccb81f66c            "/home/weave/launch.…"   29 minutes ago      Up 29 minutes                           k8s_weave_weave-net-2v7nz_kube-system_f6dac40c-0486-44dd-b2ae-da36029ac4ee_1
d8abb4471883        weaveworks/weave-npc    "/usr/bin/launch.sh"     29 minutes ago      Up 29 minutes                           k8s_weave-npc_weave-net-2v7nz_kube-system_f6dac40c-0486-44dd-b2ae-da36029ac4ee_0
c0ca4b69c075        k8s.gcr.io/kube-proxy   "/usr/local/bin/kube…"   29 minutes ago      Up 29 minutes                           k8s_kube-proxy_kube-proxy-n7hvf_kube-system_033f4b96-1dd8-4941-a998-250c78f8620b_0
40ace91d5bba        k8s.gcr.io/pause:3.2    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_kube-proxy-n7hvf_kube-system_033f4b96-1dd8-4941-a998-250c78f8620b_0
69d89fe1b709        k8s.gcr.io/pause:3.2    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_weave-net-2v7nz_kube-system_f6dac40c-0486-44dd-b2ae-da36029ac4ee_0
root@ip-172-31-41-56:~#
```
## yml:

- kubectl apply -f sample.yml
- kubectl delete -f sample.yml

