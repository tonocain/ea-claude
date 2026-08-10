# Reference: slide deck + review document templates

Working boilerplate extracted from Session 1 of "Master Claude"
(`projects/course-for-friends/presentations/sesion-01-mentalidad-fundamentos.html`
and `sesion-01-documento-repaso.html`). Both files are self-contained,
zero external requests, and already solved the hard parts (build-by-press
navigation, brand tokens, print fallback). Copy the CSS/JS blocks below
wholesale into a new file, swap only the brand tokens and content — don't
re-derive the mechanics from scratch.

---

## Branding tokens

Pull these from the relevant `.firecrawl/*-branding.json` scrape:

| Token | JSON path | Notes |
|---|---|---|
| Background | `branding.colors.background` | |
| Text | `branding.colors.textPrimary` (or `accent`, check which is the near-black) | |
| Primary accent | `branding.colors.primary` | Used for headings accents, table headers, callout borders |
| Secondary accent | `branding.colors.secondary` | Used sparingly — divider eyebrow text, demo-style callouts |
| Heading font stack | `branding.typography.fontStacks.heading` | Use the stack AS SCRAPED (includes real fallbacks like Georgia/serif) — never add a `@font-face`/Google Fonts import for the branded font itself, it's proprietary |
| Body font stack | `branding.typography.fontStacks.body` | Same rule |
| Logo | `branding.images.logo` | Usually an inline SVG data URI — paste directly into `<img src="...">`, don't re-host it |
| Border radius | `branding.spacing.borderRadius` | |

**Sanity-check the `link` color before using it.** In the Claude.com scrape
it came back `#FF5F57` — the exact macOS traffic-light red, clearly a
scraping artifact (probably picked up browser chrome, not brand CSS). If a
color value matches a known OS/browser system color and looks out of place
next to the rest of the palette, skip it and use the primary color instead.

---

## Slide deck — full CSS

```css
:root{
  --bg:#FAF9F5;              /* swap: branding.colors.background */
  --text:#141413;            /* swap: branding.colors.textPrimary */
  --primary:#C6613F;         /* swap: branding.colors.primary */
  --secondary:#FEBC2E;       /* swap: branding.colors.secondary */
  --radius:8px;
  --font-heading:anthropicSerif, Georgia, serif;   /* swap: fontStacks.heading */
  --font-body:anthropicSans, system-ui, -apple-system, "Segoe UI", sans-serif; /* swap: fontStacks.body */
}
*{box-sizing:border-box;}
html,body{height:100%;margin:0;}
body{
  background:#0d0d0c;
  display:flex;
  align-items:center;
  justify-content:center;
  font-family:var(--font-body);
  -webkit-font-smoothing:antialiased;
}
.deck{
  position:relative;
  width:min(96vw, 170.6667vh);
  aspect-ratio:16/9;
  background:var(--bg);
  color:var(--text);
  border-radius:12px;
  overflow:hidden;
  box-shadow:0 30px 80px rgba(0,0,0,.5);
}
.slide{
  position:absolute;
  inset:0;
  display:none;
  flex-direction:column;
  justify-content:center;
  padding:clamp(28px,5vw,72px) clamp(36px,7vw,104px);
  padding-bottom:clamp(56px,8vw,88px);
}
.slide.active{display:flex;}
.eyebrow{
  font-family:var(--font-body);
  text-transform:uppercase;
  letter-spacing:.12em;
  font-weight:700;
  font-size:clamp(11px,1.3vw,15px);
  color:var(--primary);
  margin:0 0 clamp(8px,1.4vw,14px);
}
h1{
  font-family:var(--font-heading);
  font-weight:400;
  font-size:clamp(34px,6.2vw,72px);
  line-height:1.05;
  margin:0 0 clamp(10px,1.6vw,18px);
}
h2{
  font-family:var(--font-heading);
  font-weight:400;
  font-size:clamp(26px,4.2vw,48px);
  line-height:1.1;
  margin:0 0 clamp(16px,2.6vw,28px);
}
.subtitle{font-size:clamp(15px,2vw,23px);color:#5E5D59;margin:0;}
.body-text{font-size:clamp(14px,1.9vw,21px);line-height:1.5;max-width:52em;}
ul.bullets, ol.steps{
  margin:0;padding:0;list-style:none;
  display:flex;flex-direction:column;gap:clamp(8px,1.4vw,14px);
}
ul.bullets li, ol.steps li{
  font-size:clamp(14px,1.9vw,21px);line-height:1.4;
  padding-left:clamp(20px,2.4vw,28px);position:relative;
}
ul.bullets li::before{
  content:"";position:absolute;left:0;top:.55em;
  width:8px;height:8px;border-radius:50%;background:var(--primary);
}
ol.steps{counter-reset:step;}
ol.steps li::before{
  counter-increment:step;content:counter(step);
  position:absolute;left:0;top:0;
  width:clamp(20px,2.2vw,26px);height:clamp(20px,2.2vw,26px);
  border-radius:50%;background:var(--primary);color:var(--bg);
  font-size:clamp(11px,1.3vw,14px);font-weight:700;
  display:flex;align-items:center;justify-content:center;
}
.callout{
  margin-top:clamp(14px,2.2vw,22px);
  border-left:4px solid var(--primary);
  background:rgba(198,97,63,.08);   /* swap: rgba() of primary, ~8% */
  border-radius:0 var(--radius) var(--radius) 0;
  padding:clamp(10px,1.6vw,18px) clamp(14px,2vw,22px);
  font-size:clamp(14px,1.8vw,20px);
  max-width:50em;
}
.callout strong{color:var(--primary);}
table{border-collapse:collapse;width:100%;font-size:clamp(11px,1.5vw,16px);}
th,td{text-align:left;vertical-align:top;padding:clamp(6px,1vw,12px) clamp(8px,1.2vw,16px);line-height:1.35;}
th{background:var(--primary);color:var(--bg);font-family:var(--font-body);font-weight:700;font-size:clamp(11px,1.4vw,15px);}
th:first-child,td:first-child{font-weight:700;}
tbody tr:nth-child(odd){background:rgba(20,20,19,.03);}
td{border-bottom:1px solid rgba(20,20,19,.08);}

/* Title slide */
.slide.title{align-items:flex-start;}
.slide.title .logo{height:clamp(20px,3vw,34px);width:auto;margin-bottom:clamp(24px,4vw,48px);}
.slide.title h1{font-size:clamp(30px,4.6vw,54px);}
.slide.title .kicker{font-family:var(--font-heading);font-size:clamp(15px,2.2vw,24px);color:var(--primary);margin:0 0 6px;}
.slide.title .meta{margin-top:clamp(20px,3vw,36px);font-size:clamp(13px,1.6vw,18px);color:#5E5D59;}

/* Divider slide */
.slide.divider{background:var(--primary);color:var(--bg);align-items:center;text-align:center;}
.slide.divider .eyebrow{color:var(--secondary);}
.slide.divider h1{font-size:clamp(32px,5.4vw,64px);}
.slide.divider .subtitle{color:rgba(250,249,245,.75);}  /* swap: rgba() of bg */

/* Chrome / nav */
.chrome{
  position:absolute;left:0;right:0;bottom:16px;
  padding:0 clamp(24px,4vw,64px);
  display:flex;align-items:center;justify-content:space-between;
  font-size:clamp(11px,1.2vw,14px);color:#8a8983;pointer-events:none;
}
.chrome .brand{display:flex;align-items:center;gap:8px;}
.chrome .nav-controls{display:flex;align-items:center;gap:10px;pointer-events:auto;}
.chrome button{
  font-family:var(--font-body);font-size:clamp(11px,1.2vw,14px);
  border:1px solid rgba(20,20,19,.15);background:var(--bg);color:var(--text);
  border-radius:var(--radius);padding:5px 12px;cursor:pointer;
}
.chrome button:hover{background:#EFEDE4;}
.chrome button:disabled{opacity:.35;cursor:default;}
.chrome .counter{min-width:3.5em;text-align:center;}

/* Entrance animation for titles/body/callouts (not list items — those are build-by-press, see JS) */
@media (prefers-reduced-motion: no-preference){
  @keyframes rise{from{opacity:0;transform:translateY(14px);}to{opacity:1;transform:translateY(0);}}
  .slide.active .logo, .slide.active .eyebrow, .slide.active h1,
  .slide.active h2, .slide.active .subtitle{animation:rise .5s ease both;}
  .slide.active .body-text, .slide.active .callout{animation:rise .5s ease .1s both;}
  ul.bullets li, ol.steps li, tbody tr{transition:opacity .3s ease, transform .3s ease;}
}

/* Build-by-press reveal: hidden until the presenter advances */
ul.bullets li, ol.steps li, tbody tr{opacity:0;transform:translateY(10px);}
ul.bullets li.shown, ol.steps li.shown, tbody tr.shown{opacity:1;transform:translateY(0);}

@media print{
  body{background:#fff;height:auto;}
  .deck{width:100%;aspect-ratio:auto;box-shadow:none;border-radius:0;}
  .slide{position:relative;display:flex !important;height:100vh;page-break-after:always;}
  .chrome{display:none;}
  ul.bullets li, ol.steps li, tbody tr{opacity:1 !important;transform:none !important;}
}
```

## Slide deck — full JS (generic, no content-specific logic)

```html
<script>
  var slides = Array.prototype.slice.call(document.querySelectorAll('.slide'));
  var total = slides.length;
  var idx = 0;
  var buildCount = 0;
  var counter = document.getElementById('counter');
  var prevBtn = document.getElementById('prev');
  var nextBtn = document.getElementById('next');

  function buildItems(n){
    return slides[n].querySelectorAll('ul.bullets li, ol.steps li, tbody tr');
  }
  function renderBuild(){
    var items = buildItems(idx);
    for (var i = 0; i < items.length; i++){ items[i].classList.toggle('shown', i < buildCount); }
  }
  function updateChrome(){
    counter.textContent = (idx + 1) + ' / ' + total;
    prevBtn.disabled = idx === 0 && buildCount === 0;
    nextBtn.disabled = idx === total - 1 && buildCount >= buildItems(idx).length;
  }
  function show(i, fullyBuilt){
    idx = Math.max(0, Math.min(total - 1, i));
    slides.forEach(function(s, n){ s.classList.toggle('active', n === idx); });
    buildCount = fullyBuilt ? buildItems(idx).length : 0;
    renderBuild();
    updateChrome();
  }
  function next(){
    var items = buildItems(idx);
    if (buildCount < items.length){ buildCount++; renderBuild(); updateChrome(); }
    else if (idx < total - 1){ show(idx + 1, false); }
  }
  function prev(){
    if (buildCount > 0){ buildCount--; renderBuild(); updateChrome(); }
    else if (idx > 0){ show(idx - 1, true); }
  }

  prevBtn.addEventListener('click', prev);
  nextBtn.addEventListener('click', next);
  document.addEventListener('keydown', function(e){
    if (['ArrowRight', 'ArrowDown', 'PageDown', ' '].indexOf(e.key) !== -1){ next(); e.preventDefault(); }
    else if (['ArrowLeft', 'ArrowUp', 'PageUp'].indexOf(e.key) !== -1){ prev(); e.preventDefault(); }
    else if (e.key === 'Home'){ show(0, false); }
    else if (e.key === 'End'){ show(total - 1, true); }
  });
  show(0, false);
</script>
```

Chrome markup this JS expects (place once, after the last `.slide`, inside `.deck`):

```html
<div class="chrome">
  <span class="brand">{{COURSE_NAME}} · {{SESSION_LABEL}}</span>
  <span class="nav-controls">
    <button id="prev" type="button">← Anterior</button>
    <span class="counter" id="counter"></span>
    <button id="next" type="button">Siguiente →</button>
  </span>
</div>
```

## Slide-type markup snippets

```html
<!-- Title slide (first slide, gets class "active" directly in markup) -->
<section class="slide title active">
  <img class="logo" alt="{{BRAND}}" src="{{LOGO_DATA_URI}}">
  <p class="kicker">{{COURSE_NAME}}</p>
  <h1>{{SESSION_TITLE}}</h1>
  <p class="meta">{{DURATION}} · {{FORMAT}}</p>
</section>

<!-- Divider slide (marks a new "Parte") -->
<section class="slide divider">
  <p class="eyebrow">{{PARTE_LABEL}}</p>
  <h1>{{PARTE_TITLE}}</h1>
</section>

<!-- Content slide: bullets -->
<section class="slide">
  <p class="eyebrow">{{PARTE_LABEL}} · {{SUBSECTION}}</p>
  <h2>{{SLIDE_TITLE}}</h2>
  <ul class="bullets">
    <li><strong>{{LEAD_IN}} —</strong> {{REST}}</li>
    <!-- one <li> per bullet from the script, condensed to fit -->
  </ul>
</section>

<!-- Content slide: table -->
<section class="slide">
  <p class="eyebrow">{{PARTE_LABEL}}</p>
  <h2>{{SLIDE_TITLE}}</h2>
  <table>
    <thead><tr><th>{{COL_1}}</th><th>{{COL_2}}</th></tr></thead>
    <tbody>
      <tr><td>{{ROW_LABEL}}</td><td>{{CELL}}</td></tr>
      <!-- one <tr> per source table row, cell text condensed to fit a 16:9 slide -->
    </tbody>
  </table>
</section>

<!-- Content slide: body text + callout (no build-by-press items) -->
<section class="slide">
  <p class="eyebrow">{{PARTE_LABEL}}</p>
  <h2>{{SLIDE_TITLE}}</h2>
  <p class="body-text">{{EXPLANATION_PARAGRAPH}}</p>
  <div class="callout"><strong>{{KEY_TERM}}:</strong> {{DEFINITION_OR_RULE}}</div>
</section>
```

---

## Review document — full CSS

```css
:root{
  --bg:#FAF9F5; --text:#141413; --muted:#5E5D59;
  --primary:#C6613F; --secondary:#FEBC2E; --radius:8px;
  --font-heading:anthropicSerif, Georgia, serif;
  --font-body:anthropicSans, system-ui, -apple-system, "Segoe UI", sans-serif;
}
*{box-sizing:border-box;}
html{scroll-behavior:smooth;}
body{margin:0;background:var(--bg);color:var(--text);font-family:var(--font-body);-webkit-font-smoothing:antialiased;line-height:1.6;}
.page{max-width:760px;margin:0 auto;padding:56px 24px 96px;}
header.doc-header{margin-bottom:40px;}
.logo{height:26px;width:auto;margin-bottom:32px;}
.kicker{font-family:var(--font-body);text-transform:uppercase;letter-spacing:.12em;font-weight:700;font-size:13px;color:var(--primary);margin:0 0 10px;}
h1{font-family:var(--font-heading);font-weight:400;font-size:clamp(30px,5vw,44px);line-height:1.12;margin:0 0 14px;}
.doc-subtitle{font-size:18px;color:var(--muted);margin:0;max-width:44em;}
nav.toc{margin:32px 0 48px;padding:18px 22px;background:rgba(198,97,63,.06);border:1px solid rgba(198,97,63,.18);border-radius:var(--radius);}
nav.toc p{margin:0 0 10px;font-weight:700;font-size:13px;text-transform:uppercase;letter-spacing:.08em;color:var(--primary);}
nav.toc ol{margin:0;padding-left:20px;}
nav.toc li{margin-bottom:4px;}
nav.toc a{color:var(--text);text-decoration:none;border-bottom:1px solid rgba(20,20,19,.25);}
nav.toc a:hover{border-bottom-color:var(--primary);color:var(--primary);}
section{margin-bottom:52px;scroll-margin-top:24px;}
section.part-divider{margin:64px 0 40px;padding-top:28px;border-top:3px solid var(--primary);}
.part-eyebrow{font-weight:700;text-transform:uppercase;letter-spacing:.1em;font-size:13px;color:var(--primary);margin:0 0 6px;}
h2{font-family:var(--font-heading);font-weight:400;font-size:clamp(24px,3.4vw,32px);margin:0 0 8px;}
h3{font-family:var(--font-body);font-weight:700;font-size:19px;margin:28px 0 10px;}
p{margin:0 0 14px;font-size:16px;}
ul,ol{margin:0 0 14px;padding-left:22px;}
li{margin-bottom:8px;font-size:16px;}
.callout{margin:16px 0;border-left:4px solid var(--primary);background:rgba(198,97,63,.07);border-radius:0 var(--radius) var(--radius) 0;padding:14px 18px;font-size:15px;}
.callout strong{color:var(--primary);}
.callout.demo{border-left-color:var(--secondary);background:rgba(254,188,46,.12);}
table{border-collapse:collapse;width:100%;margin:16px 0 20px;font-size:14.5px;}
th,td{text-align:left;vertical-align:top;padding:10px 14px;line-height:1.45;}
th{background:var(--primary);color:var(--bg);font-weight:700;font-size:13.5px;}
th:first-child,td:first-child{font-weight:700;}
tbody tr:nth-child(odd){background:rgba(20,20,19,.03);}
td{border-bottom:1px solid rgba(20,20,19,.08);}
.table-wrap{overflow-x:auto;}
footer.doc-footer{margin-top:64px;padding-top:24px;border-top:1px solid rgba(20,20,19,.12);color:var(--muted);font-size:14px;}
@media print{body{background:#fff;}nav.toc{break-inside:avoid;}section{break-inside:avoid-page;}}
```

## Review document — structure skeleton

```html
<div class="page">
  <header class="doc-header">
    <img class="logo" alt="{{BRAND}}" src="{{LOGO_DATA_URI}}">
    <p class="kicker">{{COURSE_NAME}} · Documento de repaso</p>
    <h1>{{SESSION_TITLE}}</h1>
    <p class="doc-subtitle">{{ONE_LINE_FRAMING}}</p>
  </header>

  <nav class="toc" aria-label="Contenido">
    <p>Contenido</p>
    <ol><li><a href="#parte-1">...</a></li><!-- one per top-level section --></ol>
  </nav>

  <section class="part-divider" id="parte-1">
    <p class="part-eyebrow">Parte 1</p>
    <h2>{{PARTE_TITLE}}</h2>
    <h3>{{SUBSECTION}}</h3>
    <p>{{FULL_EXPLANATION_PARAGRAPH}}</p>
    <div class="callout"><strong>{{TERM}}:</strong> {{DEFINITION}}</div>
    <!-- repeat h3/p/table/ul per subsection -->
  </section>
  <!-- repeat <section class="part-divider"> per Parte -->

  <footer class="doc-footer"><p>{{CLOSING_LINE}}</p></footer>
</div>
```
