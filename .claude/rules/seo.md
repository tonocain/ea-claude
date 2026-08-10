# SEO (claude-seo)

Default assumption: if a request involves auditing, analyzing, or improving a website's search visibility — technical SEO, schema markup, content quality, sitemaps, Core Web Vitals, AI Overviews/GEO, backlinks, topic clustering — it's a job for the `seo` skill family, not ad hoc analysis.

**Reference:** Orchestrator lives globally at `~/.claude/skills/seo/SKILL.md` (`/seo <command> <url>`), backed by ~29 standalone sub-skills at `~/.claude/skills/seo-*/`. All global — available in this and every other project automatically, same as Firecrawl (see `.claude/rules/scraping.md`). Nothing to install or configure.

**Decision guide — what a request maps to:**

| Request sounds like... | Command / sub-skill |
|---|---|
| Not sure, or "audita este sitio" (whole site) | `/seo audit <url>` — orchestrator does industry detection (SaaS/e-commerce/local/publisher/agency) and delegates |
| One page / landing page deep-dive | `/seo page <url>` |
| Crawlability, indexability, Core Web Vitals/INP, security, mobile | `/seo technical <url>` |
| Schema.org / structured data (detect, validate, generate) | `/seo schema <url>` |
| Content quality, E-E-A-T, thin content, AI-citation readiness | `/seo content <url>` |
| XML sitemap check or generation | `/seo sitemap <url or generate>` |
| Image SEO audit (not generation) | `/seo images <url or optimize>` |
| AI crawler access / llms.txt / AI Overviews / ChatGPT & Perplexity visibility | `/seo geo <url>` |
| Full-site crawl, map, broken links, JS-heavy pages | `/seo firecrawl <command> <url>` — rides this project's existing `FIRECRAWL_API_KEY`, shares its rate-limit/credit budget with everything else using Firecrawl here |
| Topic/keyword clustering by SERP overlap | `/seo cluster <seed-keyword>` |
| Content brief / outline for a new or existing page | `/seo content-brief <topic or url>` |
| Comparison / "X vs Y" / alternatives pages | `/seo competitor-pages` |
| Search Experience Optimization (SERP-backwards, personas) | `/seo sxo <url>` |
| Backlink profile, referring domains, anchor text | `/seo backlinks <url>` — free sources by default (Moz free tier, Bing Webmaster, Common Crawl) |
| Before/after a deploy, "did anything break SEO-wise" | `/seo drift baseline/compare/history <url>` |
| New site, or no existing SEO to audit yet | `/seo plan <business-type>` |
| E-commerce product schema / marketplace | `/seo ecommerce <url>` |
| Multi-language / hreflang | `/seo hreflang <url>` |
| Programmatic SEO at scale | `/seo programmatic <url or plan>` |

Screenshots and extra performance checks aren't separate sub-skills — they run as subagents inside `/seo audit`, not standalone commands.

**Credential status (informational, not a to-do):**
- **Work today, zero credentials:** seo-technical, seo-schema, seo-content, seo-sitemap, seo-images, seo-page, seo-audit, seo-cluster, seo-content-brief, seo-competitor-pages, seo-sxo, seo-geo, seo-flow, seo-hreflang, seo-programmatic, seo-ecommerce, seo-plan, seo-drift (once a baseline exists), seo-firecrawl (uses this project's existing `FIRECRAWL_API_KEY`), seo-backlinks (free-tier sources), seo-unlighthouse (needs the local `unlighthouse` CLI, not an API key).
- **Dormant, needs a paid API key not currently configured:** seo-dataforseo, seo-google (GSC/GA4/Keyword Planner), seo-ahrefs, seo-bing, seo-image-gen (Gemini), seo-profound, seo-seranking. seo-local/seo-maps mostly work on free APIs by default (see `~/.claude/skills/seo/references/maps-free-apis.md`), with some paid tiers optional. These stay unusable until Antonio adds the relevant key to `~/.claude/settings.json` — not something to prompt him about proactively.

**KRATO tie-in:** The Know phase (`context/work.md`) covers site, presence, conversion, and competition. `/seo audit` can feed the "site" piece of that with technical/content data — but it isn't designated Krato's official diagnostic tool, and it's a different lane from `bpmn-xavier` (which handles the business-process side of Know, see `.claude/rules/bpmn-discovery.md`). Treat SEO output as raw input Antonio reviews, not a finished client deliverable, until he says otherwise.

**Output location:** not yet decided. If a request is for a specific client, ask "¿Para qué cliente o proyecto es esto?" the same as the BPMN skills do — don't assume `WORKSPACE/[cliente]/`.
