#!/bin/bash

kubectl exec -it deploy/student-portal -c student-portal -- sh -c 'curl -X POST exam-scheduler -H "Content-Type:application/json" -d "{\"matricola\":\"s123456\",\"exam\":\"NCS\"}"'

echo
