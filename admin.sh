#!/bin/sh
# This script should be run on your controller node after running the scripts in common.sh
echo "Initializing the controller node, and setting the code network CIDR to 10.244.0.0/16"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
