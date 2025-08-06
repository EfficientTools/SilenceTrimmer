#!/bin/bash

VIDEO_PATH="$1"
BASENAME=$(basename "$VIDEO_PATH" | cut -d. -f1)
TMP_DIR="/tmp"
AUDIO_PATH="$TMP_DIR/$BASENAME.wav"
TRANSCRIPT_PATH="$TMP_DIR/$BASENAME.txt"

# Convertir la vidéo en audio wav mono 16 kHz
ffmpeg -y -i "$VIDEO_PATH" -ar 16000 -ac 1 -vn "$AUDIO_PATH"

# Transcrire avec Whisper (modèle small en français)
whisper "$AUDIO_PATH" --language French --model small --output_format txt --output_dir "$TMP_DIR"

# Filtrer et afficher les lignes contenant "euh" ou "heu"
echo "Lignes avec 'euh' ou 'heu' détectées dans la transcription :"
grep -i -E "\\beuh\\b|\\bheu\\b" "$TRANSCRIPT_PATH" || echo "Aucun mot détecté."

# (Optionnel) ici tu peux appeler un script ffmpeg pour couper la vidéo sur ces intervalles
# ou afficher un message d'avertissement pour l'utilisateur
