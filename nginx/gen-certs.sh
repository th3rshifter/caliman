#!/bin/bash
set -euo pipefail

CERT_DIR="${CERT_DIR:-./nginx/certs}"
DOMAIN="${DOMAIN:-caliman.local}"
DAYS="${DAYS:-365}"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO]  $*"; }
die() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $*" >&2; exit 1; }

command -v openssl &>/dev/null || die "openssl not found"

mkdir -p "$CERT_DIR"

log "Generating self-signed certificate for $DOMAIN (valid $DAYS days)..."

openssl req -x509 -nodes -days "$DAYS" \
  -newkey rsa:2048 \
  -keyout "${CERT_DIR}/${DOMAIN}.key" \
  -out    "${CERT_DIR}/${DOMAIN}.crt" \
  -subj   "/CN=${DOMAIN}/O=caliman/C=RU" \
  -addext "subjectAltName=DNS:${DOMAIN},DNS:localhost,IP:127.0.0.1"

log "Certificate: ${CERT_DIR}/${DOMAIN}.crt"
log "Private key: ${CERT_DIR}/${DOMAIN}.key"
log ""
log "To trust locally (Linux):"
log "  sudo cp ${CERT_DIR}/${DOMAIN}.crt /usr/local/share/ca-certificates/"
log "  sudo update-ca-certificates"
log ""
log "Add to /etc/hosts:"
log "  127.0.0.1  ${DOMAIN}"
