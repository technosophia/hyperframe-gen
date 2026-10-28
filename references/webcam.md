# Webcam

Une seule webcam, trois modes, `data-cam` sur l'étape. La définition de la prise ne tient pas un vrai plein écran : `full` est un pseudo plein écran.

- `off` — rien à l'écran. Le visuel porte l'argument. Obligatoire sur une punchline (noir, texte or) et sur un gabarit dense (`versus`, `diverge`, `seuil`, `compare3`, barres).
- `pip` — incrustation en bas à droite, 22 % de la largeur. Le schéma reste lisible, le locuteur reste là. Chiffre isolé, preuve, explication.
- `full` — fond et étapes floutés, webcam centrée sur la moitié de l'écran (50 % × 50 %). Entrée de scène, question ouverte, conclusion, moment où le visage porte le propos.

Rythme : un état dure au moins 2,5 s. Le changement de mode est un `tl.set` de `visibility`, immédiat ; seul le flou dure 0,3 s. Jamais de cut sec. Revoir le locuteur (`pip` ou `full`) au moins toutes les ~20 s.

On ne redimensionne pas la balise `<video>`. Le runtime la passe en `opacity: 0` et peint l'image sur un canvas calé sur la vidéo. Le cadre est un `<div class="cam-frame">` qui contient la vidéo ; la vidéo remplit le cadre (`inset: 0`). C'est le div qu'on place.

`.clip { inset: 0 }` laisse `top: 0`. Sur un cadre à hauteur fixe, `top` et `bottom` ensemble font ignorer `bottom` : le cadre colle en haut. `pip` remet `top: auto`. `full` remet `right` et `bottom` à `auto`.

```css
.cam-frame{position:absolute;top:auto;bottom:2vh;right:2vw;left:auto;width:22vw;height:12.4vw;z-index:6;border-radius:1.2vh;overflow:hidden;border:2px solid var(--bleu);background:#000}
.cam-frame video{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
```

`12.4vw` de haut pour `22vw` de large, c'est le 16:9 de la prise. `full` est 50 % × 50 % : sur un cadre 16:9, c'est la moitié de l'écran, centré.

Le seek passe avec `suppressEvents`. GSAP 3 n'applique pas `className`. Le cadre se pose en `tl.set`, pas dans un callback. `off` cache le cadre (`visibility`), sans tween d'`opacity` sur la vidéo. Le flou va sur `#fond` et sur chaque `.step`, jamais sur `#root` ni sur le cadre.

```js
function applyCam(tl, frame, mode, t) {
  var box = mode === "full"
    ? { top: "25%", left: "25%", right: "auto", bottom: "auto", width: "50%", height: "50%", borderColor: "transparent", boxShadow: "0 0 40px rgba(0,0,0,.6)" }
    : { top: "auto", left: "auto", right: "2vw", bottom: "2vh", width: "22vw", height: "12.4vw", borderColor: "#5B9CF6", boxShadow: "none" };
  tl.set(frame, Object.assign({ visibility: mode === "off" ? "hidden" : "visible" }, box), t);
  var blur = mode === "full" ? "blur(8px)" : "blur(0px)";
  tl.to("#fond", { filter: blur, duration: 0.3 }, t);
  document.querySelectorAll(".step,.step-punch").forEach(function (st) {
    tl.to("#" + st.id, { filter: blur, duration: 0.3 }, t);
  });
}
```

Le corps est recopié dans chaque composition : le script doit rester dans le HTML (scope HyperFrames), pas de fichier partagé.

Le cadre a `data-start="0"` et la durée de sa scène, pour disparaître avec elle. Pas de `style` inline. L'id du cadre est unique dans le projet (`cam-frame-i00`…), les ids `cam` dupliqués se marchent dessus.

## Commandes (mode webcam)

Même init que `SKILL.md` § Projet, puis :

```bash
cp $SKILL_DIR/scripts/concat-mkv.sh scripts/
cp $SKILL_DIR/scripts/clean-posthoc.py scripts/
cp $SKILL_DIR/scripts/check-steps.py scripts/
cp $SKILL_DIR/scripts/make-sfx.py scripts/
bash scripts/concat-mkv.sh assets/cam-original.mkv <troncon1.mkv> [<troncon2.mkv> ...]
python3 scripts/clean-posthoc.py assets/cam-original.mkv
# → assets/cam-clean.mkv + assets/voix-posthoc-v1.wav (nouveau nom à chaque passe)
sound transcribe assets/voix-posthoc-v1.wav -F json -l fr -o /tmp/tr.json
```
