#!/bin/bash

curl -f http://localhost:8080/health
kubectl get pods -n caliman
docker compose ps