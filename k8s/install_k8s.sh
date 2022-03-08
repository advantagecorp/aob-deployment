#!/bin/bash
# apply to both master and workers node

# add proxy to yum "vi /etc/yum.conf and add proxy=http://YOUR_PROXY"
# install Docker
#if no yum-config-manger .... yum install yum-utils
yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io


#Configure the Docker daemon, in particular to use systemd for the management of the container’s cgroups.

sudo mkdir /etc/docker
# Setup daemon.
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
#Restart Docker and enable on boot:

systemctl enable docker
systemctl daemon-reload

systemctl enable docker.service
systemctl start docker

#add proxy to docker https://stackoverflow.com/questions/23111631/cannot-download-docker-images-behind-a-proxy?rq=1

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

#Letting iptables see bridged traffic
sudo modprobe br_netfilter
lsmod | grep br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


# disable swap
sudo swapoff -a
# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

#Configure containerd:

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
#To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set

#[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  #...
  #[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
   # SystemdCgroup = true

#Restart containerd:

sudo systemctl restart containerd
sudo systemctl enable --now kubelet

# master node only!!! ---------
kubeadm init --pod-network-cidr=10.244.0.0/16
# save the join command
install flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# workers node
# use the join token command received from kubeadm init
