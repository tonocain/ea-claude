# Action Plan — projectkrato.com

Full findings: [`FULL-AUDIT-REPORT.md`](FULL-AUDIT-REPORT.md). Structured data: [`audit-data.json`](audit-data.json).

## Phase 1: Critical Fixes (Week 1)

None. No issue found in this audit blocks indexing or risks a penalty.

## Phase 2: High-Impact Improvements (Weeks 2-3)

- [ ] **Regenerate `og-image.jpg`** with current messaging and the corrected logo (black square, lime "K"). The live file still shows an old tagline that contradicts the site.
- [ ] **Add a Netlify `_headers` file** with `Content-Security-Policy`, `X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Permissions-Policy`.
- [ ] **Write a short founder/about section** (who's behind Project Krato, credentials, a real LinkedIn link) — the single highest-leverage trust fix available right now.

## Phase 3: Content & Authority (Month 2)

- [ ] Expand each service section with more depth (example deliverables, process detail), or split into dedicated pages per service once there's enough content to avoid thinning them out.
- [ ] Add a short FAQ block (with `FAQPage` schema) once real prospect questions are known from actual conversations.
- [ ] Add `llms.txt` summarizing the business — cheap, on-brand given the company sells AI systems.
- [ ] Add the first client case study or testimonial as soon as one exists.
- [ ] Add `sameAs` + a `founder` Person entity to the JSON-LD once a real profile link exists.

## Phase 4: Monitoring & Iteration (Ongoing)

- [ ] Register Google Search Console and GA4 — no credentials were configured at audit time, so this audit used lab data only. Field data will sharpen every future recheck.
- [ ] Re-run this audit after Phase 2/3 ship to confirm the score moved.

## Quick wins (do these regardless of phase — all under 15 minutes each)

- [x] Remove the mismatched `aria-label` on `.nav-logo`, the footer email link, and the footer phone link. — done 2026-07-27
- [x] Fix `<link rel="icon" type="image/png" ... href="/favicon.svg">` — wrong MIME type for the file. — done 2026-07-27
- [x] Trim the title tag to ~58-60 characters and the meta description to under 155 characters. — done 2026-07-27
- [x] Add `aviso-legal.html` to `sitemap.xml`. — done 2026-07-27 (moved up from Phase 2, was trivial to bundle in)
