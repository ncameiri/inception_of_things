# #!/bin/bash
# rm /etc/containerd/config.toml
# systemctl restart containerd
# # Join worker nodes to the Kubernetes cluster
# echo "[TASK 1] Join node to Kubernetes Cluster"
# apt-get  install -y sshpass >/dev/null 2>&1
# #sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.example.com:/joincluster.sh /joincluster.sh 2>/dev/null
# sshpass -p "kubeadmin" scp -o StrictHostKeyChecking=no dmarceliS.example.com:/joincluster.sh /joincluster.sh
# bash /joincluster.sh >/dev/null 2>&1

curl -sfL https://get.k3s.io | K3S_URL=https://dmarceliS:6443 K3S_TOKEN=K10c8a1969d4f1337ce9e6c16f9e33e6087e6c0c41ddf9e5b6e53a4dc0c2c6e9222::23s5zd.kpc0ayiwddl2y91o sh -
