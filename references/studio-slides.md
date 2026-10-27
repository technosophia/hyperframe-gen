# Studio slides

### Servir et enregistrer

Caméra, capture et POST `/prise` exigent Chrome ou Edge en `http://localhost`. Pas de `file://`.

```bash
python3 scripts/studio_server.py 8321
```

Fenêtre capturée : `http://localhost:8321/<preview>?view=present`. Fenêtre du locuteur : `?view=prompteur`. Le bouton **Ouvrir présentation** ouvre la première. `<preview>` est `studio-slides.html`, `studio-anim.html` ou `studio.html`.

Essai : Avance/Recule sur un fragment, caméra en coin, un overlay, 5 s d'enregistrement → `$HF_VIDEOS_DIR/prise-studio-*.webm`.

Prise : improviser depuis les notes, dans l'ordre du scénario. Raté : Pause, Recule, Reprendre. Une seule prise continue. Stop envoie le fichier dans `$HF_VIDEOS_DIR`.

Overlays lus depuis `$HF_OVERLAYS_DIR` vers `assets/overlays/`. Caméra : Off, coin, mi-écran, miroir.

### Après la prise

1. Transcrire, retirer les silences, re-transcrire l'audio final.
2. Caler les clips sur la voix (ancres = débits du transcript, cues = fragments). `index.html` porte les timings. `npm run check`, preview, mp4 sur feu vert uniquement.
3. Échec inexpliqué : skill `report`.
