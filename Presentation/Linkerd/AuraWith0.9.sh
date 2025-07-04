#!/bin/bash

kubectl set env deploy/aura-api ERROR_RATE=0.9

kubectl exec -it deploy/web-frontend -c curl -- sh -c 'while true; do curl -s http://aura-api/aura; sleep 1; done'
