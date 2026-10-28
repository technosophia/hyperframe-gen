# hyperframe-gen

Distribution du skill `hyperframe-joriel` : produire une vidéo HyperFrames au langage visuel Joriel, en trois modes (auto, slides, webcam).

## Installation

```bash
git clone <url-du-dépôt> "$SKILL_DIR"      # défaut : ~/.agents/skills/hyperframe-joriel
```

Prérequis et variables d'environnement : `SKILL.md` § Prérequis.

## Arborescence

| Chemin | Contenu |
|---|---|
| `SKILL.md` | point d'entrée : routeur, vocabulaire, étapes, format du storyboard, règles de rendu |
| `references/` | langage visuel, primitives (balisage exact), conventions studio et webcam, schémas `data/`, glossaire |
| `scripts/` | builders studio, `check-steps.py`, nettoyage webcam, `lint-repo.py` |
| `examples/demo/` | chapitre de démonstration (15 scènes) ; médias factices via `scripts/make-placeholders.sh` |
| `examples/gabarits/` | exemples JSON de `data/design.json` pour `diverge`, `seuil`, `compare3`, `cols2` |

## Vérifier

```bash
python3 scripts/lint-repo.py                                          # chemins cités, termes obsolètes
cd examples/demo && bash scripts/make-placeholders.sh && npm run check  # nécessite Node, FFmpeg, accès réseau
```
