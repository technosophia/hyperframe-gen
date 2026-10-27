#!/usr/bin/env bash
set -euo pipefail
DUR=$(python3 -c "import re;print(re.search(r'data-duration=\"([\d.]+)\"',open('index.html').read()).group(1))")
mkdir -p assets/images assets/bg
# silence for voice
ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t "$DUR" -q:a 9 -acodec libmp3lame assets/voix-posthoc-v1.wav 2>/dev/null || ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t "$DUR" assets/voix-posthoc-v1.wav
# unified video 1920x1080
ffmpeg -y -f lavfi -i color=c=black:s=1920x1080:r=30 -t "$DUR" -pix_fmt yuv420p assets/cam-clean.mkv
# unified JPEGs referenced
grep -rhoE 'assets/(images|bg)/[^" ]+' index.html compositions/*.html | sort -u | while read f; do
  mkdir -p "$(dirname "$f")"
  ffmpeg -y -f lavfi -i color=c=gray:s=1920x1080 -frames:v 1 "$f" 2>/dev/null
done
echo "placeholders generated"
