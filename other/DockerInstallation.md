
# Configuring K8's cluster Ubuntu AMI
## You will need to Install Docker CE on each node.

## Set up the repository:

https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker

### Step1 : Install packages to allow apt to use a repository over HTTPS
```
sudo -i

apt-get update && apt-get install -y && apt-transport-https ca-certificates curl software-properties-common gnupg2
```
### Step2 : Add Docker’s official GPG key
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
```
Install Docker on Nodes: This is for Ubuntu AMI
### Step 3 : Add Docker apt repository.
```
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
```
###  Step 3 : Install Docker CE.
```
apt-get update && apt-get install -y \
  containerd.io=1.2.13-1 \
  docker-ce=5:19.03.8~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.8~3-0~ubuntu-$(lsb_release -cs)
```
###  Step 4 : Setup daemon.
```
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
```
```
mkdir -p /etc/systemd/system/docker.service.d
```

###   Step 5 : finaly Restart docker.
```
systemctl daemon-reload
systemctl restart docker
```
###  Step 6 : Finally add user called 'ubuntu' group caled as 'docker' to Sudo 
```
sudo usermod -aG docker ubuntu
```
###  Step 7 : Check version and information
so you don't  have to run command as root user verytime
```
docker version
OR 
docker info
```
