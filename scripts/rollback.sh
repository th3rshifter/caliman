#!/bin/bash
set -e

helm rollback caliman
kubectl get pods -n caliman