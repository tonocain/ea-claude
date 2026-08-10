# Airbnb Video Tour Leads

**Status:** Lead sourcing complete (yield far below the 700 target — see Results); demo video pipeline validated; landing page + dedicated CRM table + automated webhook capture live 2026-08-05
**Started:** 2026-08-04

## Brand
**Krato Recorridos** — sub-brand of Project Krato (not a separate legal entity), reusing the projectkrato.com domain. Live at `projectkrato.com/recorridos`, source in the `codigo-krato` repo (`recorridos.html`, `gracias-recorridos.html`). Own visual identity (Airbnb-inspired: white canvas, Rausch red accent, Inter type) — deliberately distinct from Project Krato's black/lime look, since the page's job is to feel native to Airbnb hosts, not to look like a tech/SaaS product.

## CRM: dedicated table (2026-08-05)
Started out reusing the shared LEADS table (a `Servicio de interes` tag), but moved to a **dedicated `RECORRIDOS - LEADS` table** in the same CRM BASE Airtable once real submissions showed the gap: LEADS has no field for a listing link or property count, so that data was getting buried in a generic Notas blob instead of being visible/filterable. `RECORRIDOS - LEADS` has purpose-built fields: Nombre, Empresa, Email, Telefono, Cuantas propiedades (select), **Link de Airbnb (url)**, Estado (own pipeline: Lead nuevo → Contactado → Video en producción → Video entregado → Cliente / No responde / No interesado), Fuente de adquisicion (linked to the shared FUENTES table, so conversion-rate rollups still work), Responsable, Fecha de seguimiento, Notas.
- All 53 rows from `leads.csv` migrated in (Airbnb link recovered from the original CSV), plus real leads from the live form.
- The 61 rows in `leads-no-email.csv` are still **not** in the CRM — no email/phone to act on yet (Airbnb-messaging-only contacts aren't a workable channel today). Re-visit if that changes.

## Lead capture: form → n8n → Airtable (2026-08-05)
The page's form posts directly to an n8n webhook (workflow `Krato Recorridos → Airtable CRM`, id `xFRLOJF4A3QK57nm`) — no Netlify Forms in the middle. n8n checks a honeypot field, creates the record in `RECORRIDOS - LEADS`, then responds with an **HTTP 303** redirect back to `gracias-recorridos.html` (303, not 307/302 — 303 is required so the browser's follow-up request downgrades from POST to GET; 307 broke this in production and had to be fixed). The hero's "pega tu link" input is UI sugar only — it prefills the real form's `airbnb_link` field and scrolls down, it does not submit anything itself.

## Description
Prospect list for a professional video-walkthrough offer targeted at Airbnb apartment owners in CDMX (Mexico City). Two lead channels:

1. **Property management companies** ("administradoras") that run multiple CDMX Airbnb listings — usually have a business website with a public contact email.
2. **Individual hosts** with active CDMX apartment listings — email discovery relies on whatever the host has publicly linked (personal site, Instagram, etc.), since Airbnb never exposes host emails directly on listing pages.

## Known constraints
- Airbnb does not publish host emails anywhere in listing pages — this is by platform design, not a scraping gap.
- Scraping Airbnb for outbound-solicitation contact data is against Airbnb's Terms of Service. Antonio has acknowledged this risk and asked to proceed.
- Airbnb has no "no video" search filter; video on listings is still uncommon, so it isn't being used as a hard filter — only excluded if a video is incidentally found during inspection.
- Expect the individual-host channel to have a much lower email-fill rate than the management-company channel.

## Results (2026-08-04)
- `leads.csv` — **53 rows**, all with a verified public email. All `source_type=admin` (property management companies) — the individual-host channel yielded 0 emails (see below). Columns: `owner_name, email, airbnb_link, source_type, notes`.
- `leads-no-email.csv` — **61 rows** with name + Airbnb link but no discoverable email (27 admin companies with only an Instagram/Facebook presence Firecrawl can't read, plus all 34 individual hosts). Usable via Airbnb's internal messaging instead of email.
- Individual hosts, confirmed empirically: 0 of 62 unique host profiles sampled had any public email, website, or linked social — Airbnb strips contact info from host bios entirely. This channel cannot supply emails; don't re-run it expecting a different result.
- **Total addressable by email: 53, not 700.** Ceiling appears to be roughly "however many CDMX Airbnb management companies exist with a real marketing site" — closer to ~80 candidates found total (53 with email + 27 without). Getting past 53 means either accepting the no-email list (contact via Airbnb messaging) or a different lead source entirely (e.g. other cities, other rental platforms, or manual enrichment of the no-email list).

## Demo video pipeline — validated 2026-08-04
Built a working pipeline to produce the video-walkthrough deliverable itself, from listing photos, using the Higgsfield MCP. Sample output: `demo-video/recorrido-demo-cdmx.mp4` (9:16, ~33s, built from 9 photos of a CDMX studio listing).

**Pipeline:**
1. Dedupe/convert source photos to `.jpg` (some listings export `.avif`; convert with macOS `sips`).
2. Inspect photos to identify each room and order them into a walkthrough narrative (overview → living → kitchen → bedroom → bathroom → closing detail shot).
3. Upload via Higgsfield `media_upload` (presigned URL + `curl PUT` + `media_confirm`) — the Apps UI upload widget doesn't render in this client.
4. Generate one image-to-video clip per photo with model **`cinematic_studio_video_v2`** ("Cinema Studio Video"), `aspect_ratio: 9:16`, `duration: 4s`, `sound: off`, tailored per-room camera prompt. This model handles the horizontal→vertical reframe well directly (no need for the separate `reframe` tool) and is ~5x cheaper than `seedance_2_0`/`kling3_0` for equivalent quality — **~4 credits per 4s clip**.
5. Stitch clips with `ffmpeg` (xfade crossfade, ~0.4s) — free, local, no extra credits.
6. Background music: no Higgsfield model does generic music (only text-to-speech) — sourced a royalty-free instrumental track from Pixabay's dedicated "Real Estate" music category (no attribution required), trimmed and mixed in with `ffmpeg`.

**Cost per property (9 photos, Starter plan):** ~36 Higgsfield credits + free local processing. Starter plan caps at 2 concurrent generation jobs — batches above that queue automatically, just poll and retry.

**Reuse:** this is the same pipeline to run for any prospect from `leads.csv` once a listing's photos are available, to produce their walkthrough video.

## Personalized lead demo — Joseph (2026-08-06)
First run of the pipeline against an actual inbound lead (landing-page submission, `RECORRIDOS - LEADS`, 10+ properties) instead of a generic sample listing. Output: `demo-video/joseph/joseph-walkthrough-FINAL.mp4` (9:16, 58.7s, 16 clips — unit interior + a shot of every building amenity, per Antonio's request to showcase the whole residential, not just the unit).

- **Cost:** 64 credits (16 photos × 4cr) against a top-up'd balance (had run out mid-session at 17.1cr; topped up 500 credits / $26 USD).
- **Compared kie.ai direct API as an alternative** (Seedance 2.0 Mini, Kling 3.0 Turbo) — came out at price parity with Higgsfield's `cinematic_studio_video_v2` and would've meant rebuilding the upload/poll/download integration from scratch. Not worth it; stuck with Higgsfield.
- **Photo curation from a large gallery:** this listing had 85 photos total (only ~9 render in the initial page HTML — the rest are in the page's embedded JSON, not the DOM). Extracted all 85 with `accessibilityLabel` captions via regex on the raw HTML script blob, then curated down to 16 with Antonio (dropped estacionamiento after an initial pass).
- **Music:** same Pixabay "real estate" category approach; picked "Real Estate Hotel Resort" by mirostar (Meditation/Spiritual, calm) since this property's amenities lean hotel-like (pool, gym, cinema room).
