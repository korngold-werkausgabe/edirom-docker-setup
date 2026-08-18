#!/bin/bash

set -e

# Absoluten Pfad zum aktuellen Verzeichnis ermitteln
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp $DOCKER_DIR/dev.docker-compose.yaml $ROOT_DIR

docker compose --env-file "$ROOT_DIR/.env" up -d

# Nach dem Build den kopierten Content-Ordner wieder entfernen
rm "$ROOT_DIR/dev.docker-compose.yaml"
