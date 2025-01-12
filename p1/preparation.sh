#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.56.110 dmarceliS.42.com dmarceliS
192.168.56.111 dmarceliSW.42.com dmarceliSW
EOF

echo "[TASK 2] Install Curl"
apt update && apt-get install curl -y

echo "[TASK 11] Enable ssh password authentication"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Set Root password
echo "[TASK 12] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root
#echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
#echo "export TERM=xterm" >> /etc/bashrc