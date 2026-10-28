# Changelog

## 1.9.2

- `examples/demo` refait en catalogue : 24 étapes, une primitive ou situation par étape, lorem ipsum, nom affiché à l'écran (`assets/demo-label.css`), 3 étapes au plus par fichier ; plus de voix ni de contenu du projet de maths.
- Corrections issues de `npm run check` : contraste de `.slideno` et `.dkw.dim`, animation de la `ref-card` (`overlapping_gsap_tweens`, `gsap_repeated_fromto_without_baseline`), occlusion voulue de la webcam `full`.
- `references/hyperframes-check.md` (avertissements connus) ; `.step-punch` sur noir pur ; `strike` documenté avec `sline1` / `sline2` comme le CSS ; sections `ref-card` et `ref-shot` ; CSS de `chip`, `stamp`, `dico`, `cols2` déduit de la spec (à valider).

## 1.9.1

Correctifs du refactoring 1.9.0 :
- restauration du contenu du mode slides perdu au déplacement (commandes, previews du deck et de la composition) dans `references/studio-slides.md`, qui reçoit aussi le format des slides ;
- les commandes du mode webcam vont dans `references/webcam.md` ; `SKILL.md` repasse à 257 lignes ;
- les « Règles absolues » retrouvent leur en-tête (elles se retrouvaient sous « Webcam ») ;
- registre des références `Rxx` dans le format du storyboard ; `references/data-schemas.md` complété (champs vérifiés dans le code) ;
- `examples/gabarits/` : exemples JSON de `design.json` à la place d'une page HTML sans objet ;
- `make-placeholders.sh` couvre `assets/references/`, tient en 2 secondes ; `scenario.md` n'a plus de mot-clé `?` ;
- `lint-repo.py` détecte aussi les termes obsolètes (`lyceen`, `Mode A/B`, chemins `~/Code`).

## 1.9.0

Étapes 0 à 5 du refactoring : ordre canonique, chemins paramétrés, autonomie de la démo, allègement de SKILL.md, vocabulaire unique, trous du format, fichiers de dépôt.
