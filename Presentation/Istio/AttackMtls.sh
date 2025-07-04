#!/bin/bash

kubectl run no-istio \
  --image=radial/busyboxplus:curl \
  -it --rm --restart=Never \
  --labels='sidecar.istio.io/inject=false' \
  --command -- sh -c "curl exam-scheduler"

echo
