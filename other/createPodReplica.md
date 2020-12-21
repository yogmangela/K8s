## Creating PODs using yml

* pod had docker container
* Pod has an IP
* You will at least need one docker image
* Container: Image, ports, Volumes : Ood

### Step1: login to Master Node and Create directory called test
 check nodes are running
 ```
 kubectl get nodes
 
 mkdir test

 cd test
 ```

### Step2:  copy yml file PodReplicas.yml and javaPod.yml
```
vi PodReplicas.yml
```
copy and content from PodReplicas.yml file

### Step3: Creating pod
kubectl apply -f <<path to your yml file>>

```
kubectl apply -f PodReplicas.yml
```
### Step4: to Get Pod 
```
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
pod-demo   1/1     Running   0          2m57s
ubuntu@ip-172-31-46-174:~/test$
```

### Step5: To get more details of Pods
```
kubectl describe pods
```
it shows:
- pod name
- Labels
- Containers

it provide conprehensive details of Pod check 'PodsDetails.md
' for more.

for specifice pod detail do:
```
kubectl describe pod pod-demo
```



### Step6: ReplicationController (copy content from file: myReplica.yml)
 how many replicas you want
create new file on Master node jsut like above. and when you do 
```
 ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f myReplica.yml
replicationcontroller/myreplica created
```
### Step 7:  Checking details of replicas, pods and nodes:

```
ubuntu@ip-172-31-46-174:~/test$ kubectl get rc
NAME        DESIRED   CURRENT   READY   AGE
myreplica   2         2         2       6m20s
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods
NAME              READY   STATUS    RESTARTS   AGE
myreplica-2hr9k   1/1     Running   0          6m27s
myreplica-zb6m2   1/1     Running   0          6m27s
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods -o wide
NAME              READY   STATUS    RESTARTS   AGE     IP          NODE              NOMINATED NODE   READINESS GATES
myreplica-2hr9k   1/1     Running   0          6m32s   10.36.0.1   ip-172-31-40-6    <none>           <none>
myreplica-zb6m2   1/1     Running   0          6m32s   10.44.0.1   ip-172-31-41-56   <none>           <none>
ubuntu@ip-172-31-46-174:~/test$
```

### Step 8: Change replica set from 2 to 5 and re-run 'kubectl apply -f myReplica.yml' see what happens
```
vi  myReplica.yml   : change in this file
 
kubectl apply -f myReplica.yml 
```

you should get below output:

```
ubuntu@ip-172-31-46-174:~/test$ kubectl get rc
NAME        DESIRED   CURRENT   READY   AGE
myreplica   2         2         2       6m20s
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods
NAME              READY   STATUS    RESTARTS   AGE
myreplica-2hr9k   1/1     Running   0          6m27s
myreplica-zb6m2   1/1     Running   0          6m27s
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods -o wide
NAME              READY   STATUS    RESTARTS   AGE     IP          NODE              NOMINATED NODE   READINESS GATES
myreplica-2hr9k   1/1     Running   0          6m32s   10.36.0.1   ip-172-31-40-6    <none>           <none>
myreplica-zb6m2   1/1     Running   0          6m32s   10.44.0.1   ip-172-31-41-56   <none>           <none>
ubuntu@ip-172-31-46-174:~/test$ vi myReplica.yml
ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f myReplica.yml
replicationcontroller/myreplica configured
ubuntu@ip-172-31-46-174:~/test$ kubectl get rc
NAME        DESIRED   CURRENT   READY   AGE
myreplica   5         5         5       24m
ubuntu@ip-172-31-46-174:~/test$ kubectl get pods -o wide
NAME              READY   STATUS    RESTARTS   AGE   IP          NODE              NOMINATED NODE   READINESS GATES
myreplica-2hr9k   1/1     Running   0          25m   10.36.0.1   ip-172-31-40-6    <none>           <none>
myreplica-hf8tn   1/1     Running   0          25s   10.44.0.2   ip-172-31-41-56   <none>           <none>
myreplica-j98mh   1/1     Running   0          25s   10.36.0.2   ip-172-31-40-6    <none>           <none>
myreplica-s5lzf   1/1     Running   0          25s   10.44.0.3   ip-172-31-41-56   <none>           <none>
myreplica-zb6m2   1/1     Running   0          25m   10.44.0.1   ip-172-31-41-56   <none>           <none>
ubuntu@ip-172-31-46-174:~/test$
```
### Step 9: Ok how do i access aal the Pods? (service)

Service is not responsible for creating Pods.

re-run : kubectl apply -f myReplica.yml if needed.
```
ubuntu@ip-172-31-46-174:~/test$ vi myservice.yml
ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f myReplica.yml
replicationcontroller/myreplica created
ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f myservice.yml
service/simple-service created
```
### Step 10: 
```
ubuntu@ip-172-31-46-174:~/test$ kubectl get svc
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes       ClusterIP   10.96.0.1      <none>        443/TCP        4h35m
simple-service   NodePort    10.110.168.6   <none>        80:31699/TCP   13s
ubuntu@ip-172-31-46-174:~/test$
```

### Step 1: To see if it's working or not 

try <<node-ip>>:30001 should see NGINX running

To use loadbalancer this is local / Test env. Cloud provider such as AWS and Azure have their LB service. May use this here.

kubectl excc 
