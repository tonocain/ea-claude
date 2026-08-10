# SEO Audit — projectkrato.com

Date: 2026-07-27
Scope: `https://projectkrato.com/` (3 pages total: homepage, `aviso-legal.html`, `gracias.html`). No 500-page crawl was needed — this is the entire indexable surface of the site today.
Method: live HTTP checks (headers, robots.txt, sitemap.xml, redirects), Lighthouse (mobile, throttled), JSON-LD validation, manual review of the live-rendered source, full-page desktop/mobile screenshots.

## Executive Summary

**SEO Health Score: 70/100**

| Category | Score | Weight |
|---|---|---|
| Technical SEO | 82 | 22% |
| Content Quality | 55 | 23% |
| On-Page SEO | 72 | 20% |
| Schema / Structured Data | 75 | 10% |
| Performance (CWV) | 92 | 10% |
| AI Search Readiness (GEO) | 55 | 10% |
| Images | 60 | 5% |

**Business type detected:** Professional Services / B2B agency (AI sales systems + custom software for Mexican SMBs). Not e-commerce, not classic brick-and-mortar local — so `seo-ecommerce` and full `seo-local`/`seo-maps` treatment weren't applied, though a couple of local-relevance notes are folded into the GEO/content findings below.

The site is technically solid and genuinely fast — the gap is entirely on the **content/authority side**, which is expected and normal for a pre-revenue, single-founder site three commits old. Nothing found here blocks indexing or risks a penalty.

### Top 5 issues

1. **`og-image.jpg` shows stale, contradictory messaging.** Downloaded and viewed the live file — it still carries an old tagline ("Inteligencia digital que convierte datos en decisiones" / "Agencia de Inteligencia Digital · México") that has nothing to do with the current site. Every WhatsApp/LinkedIn share of the homepage shows this outdated card.
2. **No E-E-A-T signals.** No About/founder page, no bio, no link to a real professional profile, no client proof. For a service this expensive and intangible (your own brand guideline's framing), this is the highest-leverage gap.
3. **One page, several keyword clusters.** ~500 words are asked to rank for CRM con IA, agentes de voz, software a medida, and automatización de ventas all at once.
4. **`sitemap.xml` is incomplete.** Only the homepage is listed; `aviso-legal.html` (indexable) is missing.
5. **No security headers beyond HSTS.** No CSP, X-Frame-Options, X-Content-Type-Options, Referrer-Policy, or Permissions-Policy.

### Top 5 quick wins

1. Add `aviso-legal.html` to `sitemap.xml` (one line of XML).
2. Remove the 3 mismatched `aria-label` attributes (nav logo, footer email, footer phone) — surfaced by Lighthouse's accessibility audit.
3. Fix the favicon `<link>` that declares `type="image/png"` for an `.svg` file.
4. Trim the title tag (~71 chars) and meta description (~165 chars) so neither truncates in the SERP.
5. Add a Netlify `_headers` file with standard security headers — config only, no code changes.

## Technical SEO — 82/100

See [`findings/technical.md`](findings/technical.md).

HTTPS, HSTS, clean redirects (both `http→https` and `www→apex`), a real 404 status, a fast 130ms server response, and a permissive `robots.txt` that doesn't block any AI crawler. The only gaps are an incomplete sitemap and missing security headers — both cheap fixes.

## Content Quality — 55/100

See [`findings/content.md`](findings/content.md).

The writing itself is good — clear, on-brand, direct. The problem is scope: one landing page is carrying the full weight of the site's SEO and trust-building job. No About page, no founder bio, no client proof (understandably, pre-revenue) — this is the category most worth investing in next.

## On-Page SEO — 72/100

See [`findings/onpage.md`](findings/onpage.md).

Heading structure and social meta tags are clean. Title and meta description both run a bit long and risk SERP truncation — a 10-minute fix.

## Schema & Structured Data — 75/100

See [`findings/schema.md`](findings/schema.md).

A valid, well-populated `ProfessionalService` schema is already live. Missing pieces (`sameAs`, a `founder` Person entity) are blocked on the same About/bio content gap noted above, not schema work itself.

## Performance — 92/100

See [`findings/performance.md`](findings/performance.md).

Excellent, measured live: LCP 1.1s, CLS 0, FCP 0.9s. This also surfaced a small, real accessibility fix (3 `aria-label` mismatches) worth doing while it's cheap.

## AI Search Readiness (GEO) — 55/100

See [`findings/geo.md`](findings/geo.md).

`robots.txt` already welcomes every major AI crawler — that part's done. What's missing (`llms.txt`, an FAQ block) is content work, same root cause as the Content Quality gap.

## Images — 60/100

See [`findings/images.md`](findings/images.md).

No `<img>` tags means no alt-text problems by construction — but the one image asset that does exist (`og-image.jpg`) is stale enough to actively misrepresent the business on social shares. This is the single fastest win in this whole report relative to its visibility.

## Search Experience (SXO) — qualitative

See [`findings/sxo.md`](findings/sxo.md). No page-type mismatch detected; the real risk is topical thinness, not the wrong kind of page.

## Screenshots

Full-page desktop and mobile captures of the live homepage are in `screenshots/` (`desktop-home.png`, `mobile-home.png`).

## Not evaluated

- **Google Search Console / GA4 data** — no credentials configured at audit time (`seo-google` not spawned). Once set up, a follow-up audit can replace several lab-estimated figures here with real field data.
- **Backlink profile** — brand-new domain, effectively zero backlinks expected; not worth spending a check on yet.
- **DataForSEO / live SERP data** — not configured; recommendations here are based on on-page/technical evidence, not live rank tracking.
