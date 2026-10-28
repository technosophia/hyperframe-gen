# Démo HyperFrames (Joriel)

Chapitre de démonstration : 15 scènes (`compositions/i00.html` à `i14.html`), `index.html`, et `scenario.md` (le storyboard minuté correspondant, mots-clés lus dans les compositions).

Les médias lourds ne sont pas versionnés. Pour les générer en version factice (voix silencieuse, caméra noire, images grises) :

```bash
bash scripts/make-placeholders.sh   # FFmpeg requis
npm run check                       # Node ≥ 22, accès réseau (hyperframes@0.8.123 via npx)
```
