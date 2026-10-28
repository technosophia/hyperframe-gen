# Changelog

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
