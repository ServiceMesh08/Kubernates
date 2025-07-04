#!/bin/bash

kubectl exec -it deploy/professor-tools -c professor-tools -- sh -c 'curl http://exam-scheduler'

echo
