```
ubuntu@ip-172-31-46-174:~/test$ kubectl describe pods
Name:         pod-demo
Namespace:    default
Priority:     0
Node:         ip-172-31-41-56/172.31.41.56
Start Time:   Thu, 16 Apr 2020 10:28:17 +0000
Labels:       env=test
              server=web
Annotations:  Status:  Running
IP:           10.44.0.1
IPs:
  IP:  10.44.0.1
Containers:
  nginx:
    Container ID:   docker://bec3b9bf985cd5f7179da4b7792c52f17998a095ca5905240859bb8dddc2bc4e
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:e538de36780000ab3502edcdadd1e6990b981abc3f61f13584224b9e1674922c
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 16 Apr 2020 10:28:23 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lj5fz (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-lj5fz:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-lj5fz
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                      Message
  ----    ------     ----   ----                      -------
  Normal  Scheduled  5m30s  default-scheduler         Successfully assigned default/pod-demo to ip-172-31-41-56
  Normal  Pulling    5m29s  kubelet, ip-172-31-41-56  Pulling image "nginx"
  Normal  Pulled     5m25s  kubelet, ip-172-31-41-56  Successfully pulled image "nginx"
  Normal  Created    5m25s  kubelet, ip-172-31-41-56  Created container nginx

```