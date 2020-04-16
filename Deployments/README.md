# How to setup K8's Deployments

### Step1 : Create a file and deploy
```
ubuntu@ip-172-31-46-174:~/test$ vi deploy.yml

ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f deploy.yml
deployment.apps/my-deployment created

ubuntu@ip-172-31-46-174:~/test$ kubectl get deploy
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
my-deployment   2/3     3            0           9s
ubuntu@ip-172-31-46-174:~/test$
```

### Step2 Check to see if replicaSet been created:

```
ubuntu@ip-172-31-46-174:~/test$ kubectl get rs
NAME                       DESIRED   CURRENT   READY   AGE
my-deployment-5cd8cb9668   3         3         2       13m

ubuntu@ip-172-31-46-174:~/test$ kubectl describe rs my-deployment-5cd8cb9668
Name:           my-deployment-5cd8cb9668
Namespace:      default
Selector:       app=nginx,pod-template-hash=5cd8cb9668
Labels:         app=nginx
                pod-template-hash=5cd8cb9668
Annotations:    deployment.kubernetes.io/desired-replicas: 3
                deployment.kubernetes.io/max-replicas: 4
                deployment.kubernetes.io/revision: 1
Controlled By:  Deployment/my-deployment
Replicas:       3 current / 3 desired
Pods Status:    2 Running / 1 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=nginx
           pod-template-hash=5cd8cb9668
  Containers:
   my-web:
    Image:        httpd
    Port:         80/TCP
    Host Port:    80/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  14m   replicaset-controller  Created pod: my-deployment-5cd8cb9668-dhh27
  Normal  SuccessfulCreate  14m   replicaset-controller  Created pod: my-deployment-5cd8cb9668-r6lbv
  Normal  SuccessfulCreate  14m   replicaset-controller  Created pod: my-deployment-5cd8cb9668-cwwkl
```
now if you try pinging / copy paste either of the <<node-ip>> into address bar it should work.
# HTTPS service : It Works !

### Step3 so what if you want to update the current version to new Ver. v1 --> v2:
changed image: httpd to nginx

    spec:
      hostNetwork: true
      containers:
      - name: my-web
        image: nginx
        #image: httpd

 *** Amazing thing about this is while deployment is happening you are stil able to access your v1 application. ***

```
ubuntu@ip-172-31-46-174:~/test$ kubectl apply -f deploy.yml --record
deployment.apps/my-deployment configured

ubuntu@ip-172-31-46-174:~/test$ kubectl rollout status deployments my-deployment
Waiting for deployment "my-deployment" rollout to finish: 2 out of 3 new replicas have been updated...
error: deployment "my-deployment" exceeded its progress deadline

ubuntu@ip-172-31-46-174:~/test$ kubectl get deploy my-deployment
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
my-deployment   2/3     2            2           41m
ubuntu@ip-172-31-46-174:~/test$
```

wait for deployment to finish

Or if you are curios enough can run 'kubectl get pods' you will notice there are some pods are 'pending' and 'running'

-- kubectl get deploy my-deployment

### Step4 Check History of Deployment: you will notice REVISION 1 and 2

```
ubuntu@ip-172-31-46-174:~/test$ kubectl rollout history deployments my-deployment
deployment.apps/my-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl apply --filename=deploy.yml --record=true

ubuntu@ip-172-31-46-174:~/test$
```

### Step5 To Undo Deployments:
```
 kubectl rollout undo deployments my-deployment --to-revision=1
```
### Step6 :

# DevOps: Jenkins with Kubeadm (K8's)
Kubectl apply commands calling them from jenkins 
>> jenkins will build the application 
>> build the Docker image 
>> push the build to Docker registry 
>> DownStream job or New job or same job will be doing kubectl apply

my Jenkins may not have kubectl:
can kubernetes master be Jenkins slave?: Yes 
>> and run kubectl command from jenkins 
>> Jenkins job will come here and execute whatever I am building
>> How can i use 'kubectl' command from a different machine 
>> which is not a master : EKS and AKS

