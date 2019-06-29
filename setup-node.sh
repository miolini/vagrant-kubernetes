#!/bin/bash

sh /vagrant/setup-node-join.sh
mkdir -p /root/.kube
cp /etc/kubernetes/kubelet.conf /root/.kube/config
kubectl get nodes
