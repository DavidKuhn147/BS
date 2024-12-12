#!/bin/bash

# Backup-Verzeichnis
BACKUP_DIR="/backup"

# Zielpfad
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_PATH="$BACKUP_DIR/home_backup_$TIMESTAMP.tar.gz"

# Sicherstellen, dass das Backup-Verzeichnis existiert
mkdir -p $BACKUP_DIR

# Home-Verzeichnis sichern
tar -czf $BACKUP_PATH /home/david

echo "Backup erstellt: $BACKUP_PATH"


