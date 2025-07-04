#! bin/bash

linkerd viz tap deploy/web-frontend --to svc/aura-api -n default | grep 'dst='
