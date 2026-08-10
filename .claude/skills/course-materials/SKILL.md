---
name: course-materials
description: Generates a navigable branded slide deck (HTML) and a full-explanation student handout (HTML) from an already-written course/workshop session script. Triggers on "crea la presentación de la sesión X", "genera las slides de la sesión X", "haz el documento de repaso", "arma el material para los alumnos", "quiero el deck y el repaso de esta sesión", or any request to turn a session script into presentable/handout material. Built from the exact pattern used for Session 1 of "Master Claude" (course-for-friends) — reuse it, don't redesign from scratch.
---

# ROLE
You turn a written session script (a workshop talk-track that mixes
audience content with speaker-only notes) into two deliverables:
1. A navigable slide deck (HTML) for live presentation.
2. A full-explanation handout (HTML) students keep afterward.

You restructure and re-flow content that's already been written — you do
not write new course content, explanations, or examples.

# LANGUAGE
Skill instructions: English. All slide/document content, file comments,
and conversation with Antonio: Spanish, matching the source script.

# WHEN THIS APPLIES
Requires a finished (or "cerrado") session script to already exist. If the
script itself is incomplete or still being drafted, that's a separate
conversation — tell Antonio to finish it first, don't try to fill gaps
yourself.

---

# PHASE 1 — READ SOURCE + BRANDING

1. Read the full session script end to end (e.g.
   `projects/course-for-friends/sessions/NN-*.md`). Closing tables and
   hands-on steps matter as much as the opening — don't skim.
2. Determine the branding source:
   - For "Master Claude" (course-for-friends): the course is about Claude
     itself, so it uses Claude's own brand identity. Check `.firecrawl/`
     for an existing scrape (e.g. `claude-com-branding.json`). If missing,
     scrape `https://claude.com` via Firecrawl first (`.claude/rules/
     scraping.md`).
   - For any other course/project, ask Antonio which brand to use before
     generating anything. Don't default to Project Krato's own
     `references/examples/brand-guidelines.md` here — that's for
     WORKSPACE client diagnostics, a different context entirely.
3. Pull colors, font stacks, logo, and border-radius from the branding
   JSON — see `reference.md` → "Branding tokens" for the exact field
   mapping and the fallback-font-stack rule (never load an external web
   font; use the documented fallback stack as-is).
4. **Sanity-check scraped colors before using them.** A scraped `link` or
   similar field can be a browser/OS chrome color picked up by mistake
   (e.g. Claude.com's scrape returned `#FF5F57`, the exact macOS
   traffic-light red — not a real brand color). If a value looks like a
   system color and clashes with the rest of the palette, skip it and use
   the primary color instead; mention the substitution to Antonio.

---

# PHASE 2 — CONTENT MAPPING (the part that matters most)

Session scripts mix three kinds of content. Sort every paragraph into one
of these before building anything:

1. **Audience content** — concepts, bullets, tables, steps the group
   actually sees/hears. Goes into BOTH deliverables.
2. **Speaker-only instructions** — "Nota para Antonio", exact demo
   mechanics ("saca el teléfono y pregúntale a ChatGPT con la búsqueda
   desactivada..."), pacing notes, internal sourcing footnotes ("Fuente:
   vault X, Clase Y"). NEVER goes into either deliverable — stays in the
   script only.
3. **Meta-framing** — "Para decir en vivo", "Nota importante para la
   sesión". For the handout, reframe into a direct statement (drop the
   "decir en vivo" framing, keep the substance). On slides, skip the
   framing entirely — just the bare concept.

For live demos specifically: never carry the operational instructions,
but DO acknowledge the demo where it adds continuity, as a single-line
past-tense callout with no mechanics ("Lo vimos en vivo: ..."). See
`reference.md` for the exact pattern used in Session 1 (the ChatGPT
knowledge-cutoff demo).

Present the mapping to Antonio only if something is genuinely ambiguous
(e.g. a note that could be either framing or a real audience point) —
otherwise proceed directly to building.

---

# PHASE 3 — BUILD THE SLIDE DECK

Full CSS/JS: `reference.md` → "Slide deck — full CSS" and "— full JS".
Copy both blocks wholesale into the new file; only swap the brand tokens
in `:root` and the logo/brand text. The mechanics below are already
solved — don't redesign them:

- Self-contained single HTML file. Zero external requests: no CDN, no
  web fonts, no remote images — only inline SVG data URIs.
- 16:9 deck container (`.deck`), one `<section class="slide">` per slide.
- Four slide types: **title** (logo + course + session title), **divider**
  (full-bleed primary-color background, marks a new "Parte"), **content**
  (eyebrow + h2 + bullets/body-text/callout), **table** (eyebrow + h2 +
  table). Markup snippets for each in `reference.md`.
- Map roughly 1 slide per script subsection (`##`/`###`), plus a divider
  before each "Parte" and a title/closing slide. Let the source content
  set the count (Session 1 landed at 23) — don't force a fixed number.
- Table/bullet content gets condensed to fit a slide (short fragments,
  not full sentences) — the handout carries the full version.
- Navigation: keyboard (arrows/space/Home/End) + prev/next buttons + "n /
  total" counter, vanilla JS, no framework.
- **Build-by-press reveal**: bullets and table rows stay hidden until the
  presenter advances (arrow/space) — one item per press, Keynote/
  PowerPoint-style. Only once every item on a slide is revealed does the
  next press move slides; same in reverse going back, and a slide
  entered via "back" arrives fully built. Titles/body-text/callouts fade
  in immediately when a slide becomes active — only repeated list/row
  items are press-gated. Full logic in `reference.md`, already generic
  (reads `ul.bullets li`, `ol.steps li`, `tbody tr` — no per-slide JS
  needed).
- Respect `prefers-reduced-motion` (already handled in the CSS block).
- `@media print` fallback forces every slide + build item visible, one
  slide per printed page — a static PDF backup if the projector fails.

---

# PHASE 4 — BUILD THE REVIEW DOCUMENT

Full CSS: `reference.md` → "Review document — full CSS". Structure
skeleton in the same file.

- Single self-contained HTML page, normal scroll (not slides) — same
  brand tokens as the deck for visual continuity, article layout instead
  of a deck.
- Structure: header (logo + kicker + title + one-line subtitle) → table
  of contents with anchor links (`href="#parte-1"` etc.) → one
  `<section>` per "Parte" (`h2`) with `<h3>` per subsection → closing/
  comparison section → short footer.
- **Full paragraphs, not fragments** — the key difference from the deck.
  Every concept gets real explanatory prose, written so someone who
  missed the session can follow it unaided. Reuse the script's own
  explanations and analogies verbatim where possible; restructure for a
  reader instead of a listener, don't invent new ones.
- Tables and step lists reproduced in full (not condensed the way slide
  tables are).
- Callout boxes for definitions/key rules, same visual language as the
  deck's callouts (`.callout`, left border in primary color).
- `@media print` needs only light tweaks — normal document flow is
  already print-friendly (white background, avoid breaking a table mid-
  page).

---

# PHASE 5 — FILE LOCATIONS + VERIFICATION

- Save both files in `presentations/`, next to the project's `sessions/`
  folder (create `presentations/` if it doesn't exist yet):
  `presentations/sesion-NN-[slug].html` (deck, mirroring the source
  script's own filename slug) and `presentations/sesion-NN-documento-
  repaso.html` (handout).
- If the session lives outside `course-for-friends` and there's no
  established `presentations/` convention for that project, ask Antonio
  where deliverables should go — don't assume.
- Update the project's `README.md` status line for that session, noting
  both new deliverables (one line, matching the existing entry style —
  see how Session 1's line reads today).
- Before calling it done:
  - `grep` both files for `http://`/`https://`/`fonts.googleapis` — must
    return nothing.
  - Slide/section count roughly matches the Phase 2 content mapping —
    nothing from the script silently dropped, nothing invented.
  - No speaker-only content (Phase 2 category 2) leaked into either file.
  - Open both files (`open <path>`) so Antonio can review before you
    consider the task done.

---

# RE-RUNS / EDITS

If the source script changes after the deck/doc already exist (Antonio
edits a session file and asks to update the materials), diff the current
script against what the existing HTML files reflect rather than
rebuilding from scratch. Find what changed, patch just those slides/
sections in both files, and re-verify (Phase 5 checklist). This is the
expected normal case going forward — session scripts get revised before
every actual delivery.

---

# WHAT YOU DO NOT DO
- Don't write new session content — script gaps are a separate
  conversation, not this skill's job.
- Don't invent explanations, analogies, or examples absent from the
  source script — restructure what's there, don't pad it.
- Don't carry speaker-only notes (demo mechanics, "Nota para Antonio",
  internal sourcing footnotes) into either deliverable.
- Don't add a JS framework, CDN dependency, or external font — both
  deliverables must work fully offline.
- Don't reuse Project Krato's own brand guidelines here unless Antonio
  explicitly asks for Krato branding instead of the course's own
  subject-matter branding.
