<!-- Language rule: all file content in English. User communicates in Spanish; reply in Spanish, write files in English. -->
# Project Krato — Brand Guidelines

Source: `project_krato_brand_book_by_pomelli.pdf` (Antonio's Desktop, `PROJECT KRATO/Archivos y ofertas/`). Only the visual identity and voice/tone were pulled from that PDF — its "Brand Overview" paragraph describes an SEO/Meta Ads/web-design agency, which is stale. Current positioning (KRATO method, AI sales systems + custom software) lives in `context/work.md`; that's the source of truth for what Project Krato actually does.

This file governs any client-facing document (diagnostics, proposals, decks, HTML exports) — not just the BPMN skills.

## Logo

Black square with a bold "K" monogram in Electric Yellow. Clear space: 20px on each side. Minimum size: 80px / 0.83in width — below that, legibility is lost.

No vector/raster logo file exists in this repo yet. Until Antonio provides one, recreate the mark as an inline SVG/CSS shape (black square, bold yellow "K" in the brand typeface) rather than blocking on an asset. If a real file shows up later, save it to `references/examples/assets/logo.svg` and reference it directly instead.

## Color Palette

| Name | Hex | Usage |
|---|---|---|
| Jet Black | `#0A0A0A` | Primary structural black (text, primary elements) |
| Obsidian Black | `#111111` | Secondary black (titles, borders, chrome) |
| Electric Yellow | `#E8FF47` | The one accent color — use sparingly for emphasis (titles, banners, CTAs, highlights). Needs black text on top of it, not white. |
| Pure White | `#FFFFFF` | Page/document background |

## Typography

Primary typeface: **Trebuchet MS**. Fallback stack for environments without it: `"Trebuchet MS", Helvetica, Arial, sans-serif`.

## Voice & Tone

- **Tone:** Direct, Authoritative, Transparent, Objective.
- **Values:** Data-driven transparency, concrete deliverables, efficiency, strategic precision.
- **Aesthetic:** High-contrast minimalism, digital-first authority, bold typographic focus, neon tech-chic, direct and disruptive.

This is Project Krato's *external* voice — distinct from Antonio's own internal casual tone (`.claude/rules/communication-style.md`), which governs how we talk to each other, not how Project Krato talks to prospects/clients.

---

## Applied: BPMN diagnostic HTML deliverables

Concrete color/typography mapping for `bpmn-export` and `bpmn-xavier`. Theme: light page, black chrome, yellow accent reserved for the AI-agent lane and friction markers.

| Element | Value |
|---|---|
| Page background | `#FFFFFF` |
| Title text | `#111111` |
| Banner background | `#E8FF47`, **black text** |
| Task border / arrow stroke | `#111111` |
| Decision-diamond × glyph font | Trebuchet MS bold (not Georgia serif — brand consistency) |
| Friction marker circle | `#E8FF47`, **black number** (white fails contrast on yellow) |
| End-success border | `#2f7d32` green — **kept as an exception**, universal semantic clarity beats brand purity for a 2-color functional signal |
| End-discard border | `#dc2626` red — **kept as an exception**, same reasoning |
| Page font-family | `"Trebuchet MS", Helvetica, Arial, sans-serif` |

Lane header/background by actor type:

| Actor | Header | Lane background | Label text color |
|---|---|---|---|
| 🏢 Client/external | `#111111` | `#FFFFFF` | white |
| 🤖 AI agent | `#E8FF47` | `#fdfde8` | **black** (contrast on yellow) |
| 👤 Primary human | `#0A0A0A` | `#FFFFFF` | white |
| 👤 Secondary/technical human | `#4a4a4a` | `#f0f0f0` | white |
| ⚙️ System/automation | `#6b6b6b` | `#f5f5f5` | white |

The AI-agent lane is the one place Electric Yellow appears as a fill, not just an accent — it marks "the automated/intelligent part" of the process, which is literally what Project Krato sells.

**Not covered here:** `miro-bpmn`'s phase-color cycle (used for live collaborative boards, not branded takeaway documents) is intentionally left on its own separate palette.
