#!/usr/bin/env bash
set -euo pipefail

echo "🚀 1) kubeadm init..."
sudo kubeadm init --pod-network-cidr=10.245.0.0/16 \
                  --service-cidr=10.255.0.0/16

echo "📁 2) kubeconfig for current user..."
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "⬇️ 3) download Cilium CLI v0.16.24..."
curl -L -o cilium.tar.gz \
  https://github.com/cilium/cilium-cli/releases/download/v0.16.24/cilium-linux-amd64.tar.gz
sudo tar xzvfC cilium.tar.gz /usr/local/bin

echo "🧠 4) install Cilium CNI..."
cilium install

echo "⏳ 5) wait Cilium..."
cilium status --wait
