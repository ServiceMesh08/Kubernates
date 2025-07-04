#!/bin/bash

echo "📄 Creating authz-scheduler.yaml..."
cat <<EOF > authz-scheduler.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: allow-scheduler-access
  namespace: default
spec:
  selector:
    matchLabels:
      app: exam-scheduler
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/student-portal-sa"]
    to:
    - operation:
        methods: ["POST"]
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/professor-tools-sa"]
    to:
    - operation:
        methods: ["GET"]
EOF

echo "📄 Creating exam-scheduler.yaml..."
cat <<EOF > exam-scheduler.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: exam-scheduler-sa
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: exam-scheduler
spec:
  replicas: 1
  selector:
    matchLabels:
      app: exam-scheduler
  template:
    metadata:
      labels:
        app: exam-scheduler
    spec:
      serviceAccountName: exam-scheduler-sa
      containers:
        - name: exam-scheduler
          image: servicemeshncs/exam-scheduler:latest
          ports:
            - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: exam-scheduler
spec:
  selector:
    app: exam-scheduler
  ports:
    - port: 80
      targetPort: 8080
EOF

echo "📄 Creating peer-auth.yaml..."
cat <<EOF > peer-auth.yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: default
spec:
  mtls:
    mode: STRICT
EOF

echo "📄 Creating authz-professor.yaml..."
cat <<EOF > authz-professor.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: deny-professor-inbound
  namespace: default
spec:
  selector:
    matchLabels:
      app: professor-tools
  rules: []
EOF

echo "📄 Creating professor-tools.yaml..."
cat <<EOF > professor-tools.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: professor-tools-sa
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: professor-tools
spec:
  replicas: 1
  selector:
    matchLabels:
      app: professor-tools
  template:
    metadata:
      labels:
        app: professor-tools
    spec:
      serviceAccountName: professor-tools-sa
      containers:
      - name: professor-tools
        image: curlimages/curl
        command: [ "sleep", "3600" ]
---
apiVersion: v1
kind: Service
metadata:
  name: professor-tools
spec:
  selector:
    app: professor-tools
  ports:
  - port: 80
    targetPort: 8080
EOF

echo "📄 Creating authz-student.yaml..."
cat <<EOF > authz-student.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: deny-student-inbound
  namespace: default
spec:
  selector:
    matchLabels:
      app: student-portal
  rules: []
EOF

echo "📄 Creating student-portal.yaml..."
cat <<EOF > student-portal.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: student-portal-sa
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: student-portal
spec:
  replicas: 1
  selector:
    matchLabels:
      app: student-portal
  template:
    metadata:
      labels:
        app: student-portal
    spec:
      serviceAccountName: student-portal-sa
      containers:
      - name: student-portal
        image: curlimages/curl
        command: [ "sleep", "3600" ]
---
apiVersion: v1
kind: Service
metadata:
  name: student-portal
spec:
  selector:
    app: student-portal
  ports:
  - port: 80
    targetPort: 8080
EOF

echo "✅ All YAML files created successfully."

kubectl apply -f exam-scheduler.yaml
kubectl apply -f professor-tools.yaml
kubectl apply -f student-portal.yaml

echo "✅ All YAML files applied successfully."
