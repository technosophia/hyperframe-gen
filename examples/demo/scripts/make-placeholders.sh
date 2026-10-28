#!/usr/bin/env bash
# Génère des médias factices légers (ignorés par git) pour que `npm run check` passe
# sans les vrais assets : voix, caméra, images (images/, bg/, references/).
set -euo pipefail
cd "$(dirname "$0")/.."
command -v ffmpeg >/dev/null || { echo "ffmpeg requis" >&2; exit 1; }
DUR=$(python3 -c 'import re;print(re.search(r"data-duration=\"([\d.]+)\"", open("index.html", encoding="utf-8").read()).group(1))')
mkdir -p assets
# voix : silence 8 kHz mono 8 bits
ffmpeg -nostdin -y -v error -f lavfi -i anullsrc=r=8000:cl=mono -t "$DUR" -c:a pcm_u8 assets/voix-posthoc-v1.wav
# caméra : 640x360, 2 images/s, noir, sans audio
ffmpeg -nostdin -y -v error -f lavfi -i "color=c=black:s=640x360:r=2" -t "$DUR" -c:v libx264 -preset ultrafast -crf 45 -pix_fmt yuv420p assets/cam-clean.mkv
# images : aplat gris 1920x1080, aux noms exacts référencés
N=0
while read -r f; do
  mkdir -p "$(dirname "$f")"
  ffmpeg -nostdin -y -v error -f lavfi -i color=c=gray:s=1920x1080 -frames:v 1 "$f"
  N=$((N+1))
done < <(grep -rhoE 'assets/(images|bg|references)/[^" )]+' index.html compositions/*.html | sort -u)
echo "médias factices générés : voix, caméra, $N images (durée ${DUR}s)"
