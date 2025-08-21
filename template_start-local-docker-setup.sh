#!/bin/bash

set -e

# Absoluten Pfad zum aktuellen Verzeichnis ermitteln
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Zielordner für den Build-Kontext
DOCKER_DIR="$ROOT_DIR/editions-docker-setup"
SOURCE_DIR="$ROOT_DIR/Edirom/content"

cp $DOCKER_DIR/docker-compose.yaml $ROOT_DIR

docker compose --env-file "$ROOT_DIR/.env" up -d

# Nach dem Build den kopierten Content-Ordner wieder entfernen
rm "$ROOT_DIR/docker-compose.yaml"
