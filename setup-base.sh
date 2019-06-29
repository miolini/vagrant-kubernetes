#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
curl -fsSl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y docker-ce kubelet kubeadm kubectl
apt-mark hold docker-ce kubelet kubeadm kubectl

echo "export KUBELET_EXTRA_ARGS=--node-ip=$1" >> /root/.profile
kubeadm config images pull
service kubelet restart