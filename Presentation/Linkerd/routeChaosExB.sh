
#! /bin/bash

echo "🗑️  Deleting aura-profile.yaml..."
kubectl delete -f aura-profile.yaml

echo "📝 Annotating 'aura-api' service with failure accrual settings..."
kubectl annotate svc aura-api balancer.linkerd.io/failure-accrual=consecutive balancer.linkerd.io/failure-accrual-consecutive-max-failures=4 balancer.linkerd.io/failure-accrual-consecutive-min-penalty=30s

echo "🔁 Scaling 'aura-api' deployment to 1 replica..."
kubectl scale deploy aura-api --replicas=1

echo "🚀 Restarting 'aura-api' deployment..."
kubectl rollout restart deploy aura-api

echo "⏳ Waiting 60 seconds before executing chaos test..."
sleep 80

echo "🧪 Running curl loop inside 'web-frontend' -> 'curl' container targeting /chaos endpoint..."
kubectl exec -it deploy/web-frontend -c curl -- sh -c 'while true; do curl -s http://aura-api/chaos; sleep 1; done'


