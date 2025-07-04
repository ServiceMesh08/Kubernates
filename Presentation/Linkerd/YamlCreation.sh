#!/bin/bash

# Crea il file aura-api.yaml
cat <<EOF > aura-api.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aura-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: aura-api
  template:
    metadata:
      labels:
        app: aura-api
    spec:
      containers:
      - name: aura-api
        image: servicemeshncs/aura-api:latest
        ports:
        - containerPort: 8080
        env:
        - name: ERROR_RATE
          value: "0.4"
        - name: MIN_DELAY_S
          value: "0.2"
        - name: MAX_DELAY_S
          value: "3.0"
---
apiVersion: v1
kind: Service
metadata:
  name: aura-api
spec:
  selector:
    app: aura-api
  ports:
  - port: 80
    targetPort: 8080
EOF

# Crea il file aura-profile.yaml
cat <<EOF > aura-profile.yaml
apiVersion: linkerd.io/v1alpha2
kind: ServiceProfile
metadata:
  name: aura-api.default.svc.cluster.local
  namespace: default
spec:
  routes:
  - name: GET /aura
    condition:
      method: GET
      pathRegex: "^/aura$"
    isRetryable: true
  - name: GET /slow
    condition:
      method: GET
      pathRegex: "^/slow$"
    isRetryable: true
  - name: GET /chaos
    condition:
      method: GET
      pathRegex: "^/chaos$"
    isRetryable: false
  retryBudget:
    retryRatio: 0.2
    minRetriesPerSecond: 10
    ttl: 10s
EOF

# Crea il file web-frontend.yaml
cat <<EOF > web-frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web-frontend
  template:
    metadata:
      labels:
        app: web-frontend
    spec:
      containers:
      - name: curl
        image: curlimages/curl
        command: [ "sleep", "3600" ]
---
apiVersion: v1
kind: Service
metadata:
  name: web-frontend
spec:
  selector:
    app: web-frontend
  ports:
  - port: 80
    targetPort: 8080
EOF

# Applica le risorse con injection Linkerd
echo "➡️  Applying aura-api.yaml with Linkerd injection..."
linkerd inject aura-api.yaml | kubectl apply -f -

echo "➡️  Applying web-frontend.yaml with Linkerd injection..."
linkerd inject web-frontend.yaml | kubectl apply -f -

echo "➡️  Applying aura-profile.yaml..."
kubectl apply -f aura-profile.yaml

# Verifica lo stato dei pod
echo -e "\n📦  Current Pods:"
kubectl get pods
sleep 30
# Verifica la cifratura mTLS attiva
echo -e "\n🔐  Linkerd mTLS edges:"
linkerd viz edges deploy -n default
