#!/bin/bash

kubectl apply -f exam-scheduler.yaml
kubectl apply -f professor-tools.yaml
kubectl apply -f student-portal.yaml

echo "✅ All YAML files created successfully."
