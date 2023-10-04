#!/bin/bash
echo "[TASK 1] Join node to Kubernetes Cluster"
apt-get  install -y sshpass 

# Label the node as a worker
sudo kubectl label node "$(hostname)" node-role.kubernetes.io/worker=true

#get join script from master 
sshpass -p "kubeadmin" scp -o StrictHostKeyChecking=no dmarcelis.42.com:*. /joincluster.sh
bash /joincluster.sh 

echo "Cluster Joined!"