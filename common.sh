#!/bin/sh
# This script should be run on all kubernetes nodes

echo "Adding the kubernetes rpo to /etc/yum.repos.d"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

echo "Disabling SELinux"
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

echo "Installing Kubernetes"
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

echo "Enabling and starting kubelet"
sudo systemctl enable --now kubelet
