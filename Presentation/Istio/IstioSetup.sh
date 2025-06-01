#!/bin/bash

echo "🛠️  The editor will now open to modify the Cilium ConfigMap."
echo "➡️  Set to "true" the line:        cni-exclusive: \"false\""
echo "➡️  Add (if not present):  bpf-lb-sock-hostns-only: \"true\""
echo "📌 Press Enter to continue..."
read

kubectl -n kube-system edit configmap cilium-config

echo "⬇️  Downloading Istio version 1.16.7..."
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.16.7 sh -

echo "📁 Changing into Istio directory..."
cd istio-1.16.7/

echo "🔧 Adding Istio CLI to PATH..."
export PATH=$PWD/bin:$PATH

echo "🚀 Installing Istio with the demo profile..."
istioctl install --set profile=demo -y

echo "🔍 Verifying Istio installation..."
istioctl version

echo "📦 Listing Istio system pods..."
kubectl get pods -n istio-system

echo "🏷️  Enabling automatic sidecar injection in the 'default' namespace..."
kubectl label namespace default istio-injection=enabled

echo "✅ Istio setup complete."
