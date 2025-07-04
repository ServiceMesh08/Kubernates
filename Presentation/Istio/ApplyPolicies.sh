#!/bin/bash

kubectl apply -f authz-scheduler.yaml
kubectl apply -f authz-professor.yaml
kubectl apply -f authz-student.yaml

echo
