#!/bin/bash
set -e

docker compose down -v
docker system prune -f