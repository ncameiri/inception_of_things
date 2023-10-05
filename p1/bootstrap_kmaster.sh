
#!/bin/bash

# Install k3s
echo "Installing k3s..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip 192.168.56.110 --tls-san $(hostname)"\
    K3S_KUBECONFIG_MODE="644" sh -

export token=$(cat /var/lib/rancher/k3s/server/agent-token)
export token=$(echo $token | tr ":" "\n" | tail -1)

echo "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=\"agent --node-ip 192.168.56.111\"\
    K3S_URL=\"https://192.168.56.110:6443\"\
    K3S_TOKEN=\"$token\"\
    K3S_KUBECONFIG_MODE=\"644\" sh - " > joincluster.sh 



