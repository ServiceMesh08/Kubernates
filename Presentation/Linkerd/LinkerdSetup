#!/usr/bin/env bash
set -euo pipefail

CLI_VERSION="stable-2.13.7"
BIN_URL="https://github.com/linkerd/linkerd2/releases/download/${CLI_VERSION}/linkerd2-cli-${CLI_VERSION}-linux-amd64"

echo "⬇️ 1) Downloading Linkerd CLI ${CLI_VERSION}..."
curl -sL "$BIN_URL" -o linkerd && chmod +x linkerd
sudo mv linkerd /usr/local/bin/

echo "🔎 2) Pre-installation check..."
linkerd check --pre

echo "📦 3) Installing CRDs..."
linkerd install --crds | kubectl apply -f -

echo "🚀 4) Installing control plane with proxyInit as root..."
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -

echo "⏳ 5) Waiting for control plane to become Ready..."
linkerd check --wait=5m


echo "🌐 6) Installing Viz extension..."
linkerd viz install | kubectl apply -f -

echo "⏳ 7) Waiting for Viz components to become Ready..."
linkerd viz check --wait=5m


NS="default"
echo "🏷️  8) Enabling proxy auto-injection on namespace '${NS}'..."
kubectl label ns "${NS}" linkerd.io/inject=enabled --overwrite

echo "🔍  Label check:"
kubectl get ns "${NS}" --show-labels | grep linkerd.io/inject

echo "✅  Linkerd is fully installed and ready in namespace '${NS}'."
echo "🆗  Any future Deployments in this namespace will automatically include the Linkerd sidecar proxy."
