#!/bin/bash
set -e

helm upgrade --install caliman ./helm/caliman \
  --namespace caliman \
  --create-namespace

kubectl rollout status deployment/caliman -n caliman