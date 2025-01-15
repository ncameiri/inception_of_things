#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
rm /etc/containerd/config.toml
systemctl restart containerd
kubeadm init --apiserver-advertise-address=172.42.42.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /root/.kube
cp /etc/kubernetes/admin.conf /root/.kube/config
chown -R vagrant:vagrant /root/.kube


# Deploy calico network
sudo -iu vagrant
echo "[TASK 3] Deploy Calico network"
#su - vagrant -c "kubectl create -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml"
#kubectl apply -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O
kubectl create -f custom-resources.yaml

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh
