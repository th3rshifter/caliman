#!/bin/bash
set -e

BACKUP_DIR=./backups
mkdir -p $BACKUP_DIR

docker run --rm \
  -v prometheus-data:/data \
  -v $(pwd)/backups:/backup \
  alpine tar czf /backup/prometheus-backup.tar.gz /data