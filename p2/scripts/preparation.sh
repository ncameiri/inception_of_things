#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.56.110 dmarceliS.42.com dmarceliS
EOF

echo "[TASK 2] Install Curl"
apt update && apt-get install curl -y

echo "[TASK 3] Enable ssh password authentication"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Set Root password
echo "[TASK 4] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root
#echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

echo "[TASK 5] Installing k3s..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip 192.168.56.110 --tls-san $(hostname) --advertise-address=192.168.56.110  --disable-network-policy --bind-address=192.168.56.110 "\
    K3S_KUBECONFIG_MODE="644" sh -

echo "[TASK 6] Applying apps..."
kubectl apply -f /vagrant/confs/apps/app1.yaml
kubectl apply -f /vagrant/confs/apps/app2.yaml
kubectl apply -f /vagrant/confs/apps/app3.yaml