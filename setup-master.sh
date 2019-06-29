#!/bin/bash

kubeadm init \
    --apiserver-advertise-address="192.168.50.10" \
    --apiserver-cert-extra-sans="192.168.50.10"  \
    --node-name master \
    --pod-network-cidr=192.168.51.0/16

mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
kubectl get nodes
#kubectl create -f https://docs.projectcalico.org/v3.4/getting-started/kubernetes/installation/hosted/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubeadm token create --print-join-command > /vagrant/setup-node-join.sh
cp /etc/kubernetes/admin.conf /vagrant/.config