#!/bin/bash

# Prüfen, ob mindestens ein Argument angegeben wurde
if [ "$#" -lt 1 ]; then
  echo "Verwendung: $0 <Dateien oder Verzeichnisse>"
  exit 1
fi

# Funktion, um Dateien zu prüfen und zu bearbeiten
process_file() {
  local file="$1"
  
  # Prüfen, ob die Datei die Endung .tex hat
  if [[ "$file" != *.tex ]]; then
    echo "Datei $file wird übersprungen, da sie keine .tex-Datei ist."
    return
  fi

  # Backup erstellen und Ersetzungen vornehmen
  cp "$file" "${file}.bak"
  echo "Backup für $file erstellt als ${file}.bak"
  sed -i 's/\<daß\>/dass/g; s/\<muß\>/muss/g' "$file"
  echo "Ersetzungen in $file abgeschlossen."
}

# Schleife über alle übergebenen Argumente (Dateien oder Verzeichnisse)
for item in "$@"; do
  if [ -d "$item" ]; then
    # Falls ein Verzeichnis übergeben wurde, alle Dateien darin prüfen
    echo "Durchsuche Verzeichnis $item..."
    find "$item" -type f -name "*.tex" | while read -r file; do
      process_file "$file"
    done
  elif [ -f "$item" ]; then
    # Falls eine Datei übergeben wurde, direkt verarbeiten
    process_file "$item"
  else
    echo "Warnung: $item ist weder eine Datei noch ein Verzeichnis."
  fi
done

echo "Skript abgeschlossen."
