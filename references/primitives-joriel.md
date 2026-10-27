# Primitives HTML — catalogue Joriel

Source de vérité pour la traduction scénario → HTML.
Extrait de `examples/demo/`.
Chaque primitive ci-dessous est un bloc HTML réutilisable tel quel.

## Structure d'une étape (step)

```html
<section class="clip step" id="step-S05-1-0" data-step="S05.1#0" data-start="0" data-duration="10.68" data-track-index="1">
  <div class="kicker">S05 · L'analyse</div>
  <div class="stitle">Oppression ou autorité ?</div>
  <div class="zone"><div class="in" id="in-S05-1-0">
    <!-- contenu ici -->
  </div></div>
</section>
```

## Mot-clé visuel (kw)

```html
<div class="dline"><span class="dkw plain">L'oppression ?</span></div>
```
Classes : `plain` (blanc), `bleu`, `vert`, `or`, `rouge`, `dim` (grisé, opacity .6, taille réduite).

## Sous-ligne (sub)

```html
<div class="dsub">au détriment des élèves</div>
```

## Icône trait inline (icon)

```html
<span class="dico"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">...</svg></span>
<span class="dico bad">   <!-- rouge -->
<span class="dico good">  <!-- vert -->
```

## Barré (strike)

```html
<span class="dstrike"><span>préparation à l'oppression</span><span class="sline"></span></span>
```

CSS (style-joriel.css) :
```css
.dstrike { font-size: 7.2vh; font-weight: 800; color: var(--blanc); position: relative; display: inline-block; }
.dstrike .sline { position: absolute; left: 0; top: 50%; width: 100%; height: 1.8vh; background: var(--rouge); transform: translateY(-50%) rotate(-3deg); transform-origin: center center; }
```

Animation GSAP (dessin progressif) :
```js
if (step.querySelector(".sline")) {
  tl.fromTo("#" + step.id + " .sline", { scaleX: 0 }, { scaleX: 1, duration: 0.45, ease: "power2.inOut", transformOrigin: "center center" }, t + 0.25);
}
```

## Diverge (trunk + branches)

```html
<div class="diverge">
  <div class="trunk">PRODUCTION MACHINE</div>
  <div class="branches">
    <div class="branch up"><div class="darr-big">↗</div><div class="dsub">production qui accélère</div></div>
    <div class="branch down"><div class="darr-big">↘</div><div class="dsub">compréhension humaine en retard</div></div>
  </div>
</div>
```

CSS :
```css
.trunk { font-size: 6vh; font-weight: 800; color: var(--blanc); text-align: center; margin-bottom: 2vh; }
.branches { display: flex; gap: 4vw; justify-content: center; align-items: center; margin-top: 2vh; }
.branch { display: flex; flex-direction: column; align-items: center; gap: .6vh; }
.darr-big { font-size: 6vh; font-weight: 900; }
.branch .dsub { font-size: 3.4vh; color: var(--blanc); }
```

Animation GSAP (pulse des flèches, gauche puis droite) :
```js
tl.fromTo("#" + step.id + " .branch.up .darr-big", { scale: 1 }, { scale: 1.5, duration: 0.3, yoyo: true, repeat: 1, ease: "power2.inOut" }, t + 0.4);
tl.fromTo("#" + step.id + " .branch.down .darr-big", { scale: 1 }, { scale: 1.5, duration: 0.3, yoyo: true, repeat: 1, ease: "power2.inOut" }, t + 0.9);
```

## Flèche (arrow / darr / darr-big)

```html
<span class="darr">→</span>
<div class="darr-big">↗</div>   <!-- branche diverge, couleur de la branche -->
```

## Chip (référence figures)

```html
<span class="chip">1975</span>
```

## Image plein écran (illustration / photo)

Pour afficher une image en plein écran (illustration, photo, capture d'écran) :

```html
<img class="fond" id="img-xxx" src="assets/images/<nom>.jpg" alt="description" style="z-index:2;">
```

CSS : `.fond` (position absolute, inset 0, object-fit cover). z-index 2 pour être au-dessus du fond BG (z-index 1) mais sous les steps (z-index 4).

Animation GSAP (zoom lent) :
```js
tl.fromTo("#img-xxx", { scale: 1 }, { scale: 1.06, duration: <dur>, ease: "none" }, <start>);
```

Règles :
- L'image doit être en 1920×1080 (ou redimensionnée avec ffmpeg pad).
- Pas de webcam incrustée sur ces steps (`data-cam="off"`, pas de `cam-frame`).
- L'image est un `<img class="fond">`, pas un `<div class="zone">` avec du texte.
- Le `.in` n'est pas nécessaire pour ces steps (pas d'animation opacity sur le .in).

## Chiffre-clé (bignum / count)

```html
<span class="dbig"><span class="ctr" id="ctr-xxx" data-target="24">0</span></span>
```

CSS :
```css
.dbig { font-size: 16vh; line-height: 1.1; font-weight: 800; }
```

Animation GSAP (counter : défilement rapide jusqu'à la valeur cible) :
```js
function _fmt(n){ return Math.round(n).toString().replace(/\B(?=(\d{3})+(?!\d))/g, " "); }
[
  { id: "ctr-xxx", target: 24, start: 0.0 },
].forEach(function (c) {
  var obj = { val: 0 };
  tl.to(obj, { val: c.target, duration: 0.9, ease: "power2.out",
    onUpdate: function () { var el = document.getElementById(c.id); if (el) el.textContent = _fmt(obj.val); }
  }, c.start + 0.15);
});
```

CSS pour les classes de texte (style-joriel.css) :
```css
.kicker { font-size: 3.8vh; letter-spacing: .22em; text-transform: uppercase; color: var(--bleu-clair); }
.stitle { font-size: 7.2vh; line-height: 1.08; font-weight: 800; }
.slideno { font-size: 2.2vh; color: var(--gris-rappel); opacity: .7; letter-spacing: .1em; }
.dkw { font-size: 7.2vh; line-height: 1.2; font-weight: 800; }
.dsub { font-size: 4.4vh; color: var(--bleu-clair); margin-top: .8vh; }
.punch-text { font-size: 11vh; line-height: 1.18; font-weight: 900; color: var(--or); max-width: 86vw; }
.trunk { font-size: 6vh; font-weight: 800; color: var(--blanc); text-align: center; margin-bottom: 2vh; }
.dstrike { font-size: 7.2vh; font-weight: 800; color: var(--blanc); position: relative; display: inline-block; }
.dstrike .sline { position: absolute; left: 0; top: 50%; width: 100%; height: 1.8vh; background: var(--rouge); transform: translateY(-50%) rotate(-3deg); transform-origin: center center; }
.branches { display: flex; gap: 4vw; justify-content: center; align-items: center; margin-top: 2vh; }
.branch { display: flex; flex-direction: column; align-items: center; gap: .6vh; }
.darr-big { font-size: 6vh; font-weight: 900; }
.branch .dsub { font-size: 3.4vh; color: var(--bleu-clair); }
```

## Tampon verdict (stamp)

```html
<span class="stamp">PIRES SCORES</span>
```

## Coche / croix (check / cross)

```html
<span class="dico good"><svg>...</svg></span>   <!-- check -->
<span class="dico bad"><svg>...</svg></span>    <!-- cross -->
```

## Versus (deux colonnes)

```html
<div class="versus">
  <div class="vcol left"><div class="dline"><span class="dkw dim">professeur autorité</span></div></div>
  <div class="vsep"></div>
  <div class="vcol right"><div class="dline"><span class="dkw rouge">guichet des savoirs</span></div><div class="dsub">l'élève égal du prof</div></div>
</div>
```

Animation GSAP (gauche diminue, droite s'agrandit) :
```js
var _vs = step.querySelector(".versus");
if (_vs) {
  var _l = _vs.querySelector(".vcol.left");
  var _r = _vs.querySelector(".vcol.right");
  if (_l) tl.fromTo(_l, { scale: 1 }, { scale: 0.82, duration: 0.7, ease: "power2.out" }, t + 0.25);
  if (_r) tl.fromTo(_r, { scale: 1 }, { scale: 1.18, duration: 0.7, ease: "power2.out" }, t + 0.25);
}
```

## Diverge (branches)

```html
<div class="diverge">
  <div class="trunk">Face à l'IA</div>
  <div class="branches">
    <div class="branch up"><div class="darr-big">↗</div><div class="dsub">...</div></div>
    <div class="branch down"><div class="darr-big">↘</div><div class="dsub">...</div></div>
  </div>
</div>
```

## Compare3 (3 lignes)

```html
<div class="compare3">
  <div class="c3row">...</div>
  <div class="c3row">...</div>
  <div class="c3row">...</div>
</div>
```

## Punchline (punch)

```html
<div class="clip step-punch" data-step="S09.1#3" data-i="79">
  <div class="punch-text"><span class="w">Tu</span> <span class="w">ne</span> <span class="w">peux</span> <span class="w">pas</span></div>
</div>
```

## Pièce documentaire (crop d'article / source prioritaire)

```html
<img class="doc-crop" src="assets/references/R02-lemonde-duminil-copin.png" alt="">
<div class="dsub">Le Monde, ...</div>
```

## Mapping scénario → primitive

| Directive scénario | Primitive HTML |
|---|---|
| `figures: Fxx` | `chip` ou `dbig` selon contexte |
| `source prioritaire Rxx; crop de l'article` | `doc-crop` (img) + `sub` source |
| `type: cards` | `.clip.step` + `.zone` centré, `.dkw` + `.dsub` |
| `type: versus` | `.versus` + `.vcol` + `.vsep` |
| `type: punch` | `.step-punch` + `.punch-text` en `--or` sur noir |
| `type: numbers` | `.dbig` compteur en `--or` + label |
| `type: bars` | `.bar` / `.bars` comparatifs |
| `type: enumerate` | `.dline` + `.dkw` + `.dsub`, 1 item/étape |
| `type: diverge` | `.diverge` + `.trunk` + `.branches` |
| `type: define` | `.dkw` puis morph vers `.versus` |
| `type: cols2` | `.zone.cols2` |
| `negate` | `.dstrike` + `.sline` |
| `count` | `.dbig` avec `data-to` |
| `causal-chain` | `.darr` entre `.dkw` |
| tampon verdict | `.stamp` |

## Webcam

Les trois modes, le CSS et le `tl.set` du cadre sont dans `SKILL.md`, section Webcam. Ne pas recopier un bloc plus ancien (coin haut, `className`, `left` inline).

## Règle d'or

Chaque étape du scénario doit produire **au moins un élément HTML non-textuel** (image, SVG, primitive visuelle) qui illustre le concept. Jamais de sous-titre seul.

---

## Catalogue complet des opérations → primitives HTML

### A. Relations logiques et argumentatives

- `compare` → 2 `kw` face à face + `bar` sur échelle commune
- `contrast` → 2 colonnes bleu vs vert + `arrow` central
- `negate` → `strike` rouge sur la proposition
- `refute` → étape 1 : `kw` blanc ; étape 2 : `strike` + `check` vert
- `connect` → `kw` + `kw` reliés par ligne fine bleue, sans `arrow`
- `causal-chain` → `kw` + `arrow` + `kw` + `arrow` + `kw`
- `decompose` → `kw` titre puis `enumerate` des parties
- `compose` → parties puis `stamp` vert du tout
- `transform` → `kw` + `arrow` + `kw`, fond qui change
- `feedback-loop` → 3–4 `kw` en cercle + `arrow` en boucle
- `branch` → `kw` question puis 2 `kw` bleu/vert côte à côte
- `hierarchy` → `kw` empilés + indentations
- `zoom` → `kw` large puis `bignum`/`kw` détail plein écran
- `accumulate` → `enumerate` pas à pas, 1 item/étape
- `evidence` → `check` × N puis `stamp` vert conclusion
- `synthesize` → `stamp` or + `kw` modèle commun

### B. Quantité et mesure

- `enumerate` → lignes `kw` + `sub`, 1/étape
- `count` → `bignum` compteur or + label
- `proportion` → `bar` + dénominateur explicite (`sub`)
- `scale` → `bars` échelle commune, base 100
- `rank` → `bars` triées + numéros 1..N
- `threshold` → ligne seuil or + `stamp` rouge si dépassement
- `distribution` → `bars` histogramme
- `growth` / `change-over-time` → `bars` ou courbe + variation annotée
- `uncertainty` → fourchette `chip` min–max + `sub` « estimation »
- `accumulation-to-threshold` → barres qui montent puis `stamp` seuil

### C. Attention et révélation

- `highlight` → mot-clé passe en `or` + pulse 1×
- `reveal` → fragment caché puis révélé
- `conceal` → zone masquée (voile) puis dévoilée
- `focus-shift` → ancien `kw` en gris, nouveau en blanc/bleu
- `reframe` → même `kw`, nouveau `sub`
- `zoom-context` → détail puis plan large

### Gabarits à signature

- `versus` → `.versus` + `.vcol` + `.vsep` (voir balisage §versus)
- `versus` morph → `.define` puis morph vers `.versus`
- `diverge` → `.diverge` + `.trunk` + `.branches` (voir balisage §diverge)
- `seuil` → barres qui montent + `.stamp` seuil or/rouge
- `compare3` → `.compare3` + `.c3row` (voir balisage §compare3)

### Familles

- **Stats** : valeur absolue (`count`), % (`proportion`), ratio (`bars`), écart (`bars` 2 valeurs), moyenne/min/max (`sub` annoté), séries multiples (`bars` groupées), tableau (`enumerate` tabulaire), matrice (`cols2`).
- **Listes** : simple/numérotée/à puces/progressive (`enumerate`), catégorisée (`cols2` + kicker), pour/contre (bleu vs rouge), inventaire (`chip` × N).
- **Temporalité** : chronologie (`causal-chain` datée), avant/après (`transform`), fréquence (`count` + `sub` /an), simultané (2 `kw` même étape, sans flèche).
- **Systèmes** : réseau (`connect` N+N), flux (`arrow` épais), goulot (`bars` + `stamp` rouge), équilibre (2 `bars` égales).
- **Argumentation** : question (`kw` + « ? »), hypothèse (`sub` « hypothèse »), objection (`strike` + `kw` adverse), concession (`check` vert + point accordé en `kw`), définition/équation (`define`), dilemme (`branch`), paradoxe (`contrast` + `stamp` or), analogie (2 `compare` parallèles).
- **Incertitude** : fait (`check` vert) / hypothèse (`sub`) / spéculation (`sub` gris + « ? »), risque (`threshold` rouge), zone inconnue (voile).
- **Rhétorique** : accroche (`punch` or), surprise (`contrast` brusque), question ouverte (`kw` + « ? » sans réponse), récap (`synthesize`).

### Règles stats

- Échelle commune pour comparer
- Zéro explicite si tronqué
- Corrélation ≠ causalité (sinon `connect`, pas `causal-chain`)
- Jamais de chiffre inventé — données manquantes = demander la source
- 1 seule figure par étape (un `count`, ou un `seuil`, ou un `compare3`, jamais deux)
