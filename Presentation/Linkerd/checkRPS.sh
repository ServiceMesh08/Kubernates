#! /bin/bash
linkerd viz routes deploy/web-frontend --to svc/aura-api -n default -o wide
