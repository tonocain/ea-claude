# AI Search Readiness (GEO) — projectkrato.com

Score: 55/100

## What works

- `robots.txt` is fully open (`Allow: /`) — no blocks on GPTBot, ClaudeBot, Google-Extended, PerplexityBot, or CCBot. AI answer engines can crawl the site freely.
- Content is structured in short, scannable, declarative blocks (the KRATO method's 5 phases, the two service lines) — a reasonable shape for an LLM to extract and cite.
- Valid `ProfessionalService` schema gives crawlers/LLMs an unambiguous entity description (services, contact, area served).

## Findings

| Severity | Finding | Recommendation |
|---|---|---|
| Medium | No `llms.txt` file (checked — 404). | Optional but a nice showcase move given Project Krato's own positioning is "we build AI systems." A short `llms.txt` summarizing the business and linking to the two service descriptions is a cheap, on-brand addition. |
| Medium | No explicit Q&A/FAQ structure — everything is marketing prose, nothing framed as a directly citable question-and-answer ("¿Cuánto cuesta un diagnóstico?", "¿Cuánto tarda la implementación?"). | Consider adding a short FAQ block (with `FAQPage` schema) once the most common prospect questions are known from real conversations — highly citable format for AI Overviews / ChatGPT / Perplexity. |
| Medium | Thin overall content (see `content.md`) limits how much an AI engine has to work with when deciding whether to cite Project Krato as an authority on "sistemas de venta con IA para pymes en México." | Same fix as the content-depth recommendation — this category and Content Quality improve together. |
