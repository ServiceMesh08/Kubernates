#!/bin/bash

kubectl exec -it deploy/web-frontend -c curl -- sh -c 'while true; do curl -s http://aura-api/aura; sleep 1; done'
