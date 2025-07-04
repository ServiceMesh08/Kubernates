#!/bin/bash

kubectl exec -it deploy/student-portal -c student-portal -- sh -c 'curl http://exam-scheduler'

echo
