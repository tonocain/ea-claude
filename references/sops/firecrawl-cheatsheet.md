<!-- Language rule: all file content in English. User communicates in Spanish; reply in Spanish, write files in English. -->
# Firecrawl MCP Cheat Sheet

Reference for the `firecrawl` MCP server (package `firecrawl-mcp`, connected via stdio; `FIRECRAWL_API_KEY` is a global environment variable, works from any project including this one). Generated from the actual tool definitions in the installed package (v3.22.3), not docs — so it matches what's really callable.

Used in the client capture process (step 1: scrape a prospect's site before checking it against the avatar — see `references/sops/avatar-and-offer.md` and `WORKSPACE/project-krato/discovery-output.md`).

Local stdio mode = full feature set: browser `actions`, webhooks, and interact are all enabled (they're only stripped in Firecrawl's hosted "safe mode").

## Which tool do I want?

| I have... | Use |
|---|---|
| A specific URL, want its content | `firecrawl_scrape` |
| A specific URL, want specific fields (price, spec, etc.) | `firecrawl_scrape` with `formats: ["json"]` |
| A topic/question, no URL | `firecrawl_search` |
| A site, want to find the page that has X | `firecrawl_map` (with `search`) |
| A site section, want every page's content | `firecrawl_crawl` |
| Several known URLs, want the same structured fields from each | `firecrawl_extract` |
| A messy/JS-heavy target, want autonomous exploration | `firecrawl_agent` (async, poll for it) |
| A page that needs clicking/scrolling/form-filling first | `firecrawl_interact` |
| To get pinged when a page changes | `firecrawl_monitor_create` |
| A local PDF/DOCX/XLSX/etc. | `firecrawl_parse` — **needs `FIRECRAWL_API_URL` (self-hosted), won't work against plain cloud key** |
| Academic papers | `firecrawl_research_search_papers` + friends |

Golden rule from the tool's own docs: **scrape → search → map → crawl → agent**, in order of cheapest/fastest to most expensive/slowest. Don't reach for `agent` or `crawl` if `scrape` or `map` would answer it.

---

## firecrawl_scrape — single page, most-used tool

Fastest, most reliable. Default to this whenever you have a URL.

Key args:
- `url` (required)
- `formats`: array, pick from `markdown | html | rawHtml | screenshot | links | summary | changeTracking | branding | json | query | audio`. Default to `["markdown"]` for "read the page"; use `["json"]` with `jsonOptions` whenever the user wants *specific fields* (prices, specs, lists) — markdown forces you to re-parse, JSON doesn't.
- `jsonOptions: { prompt, schema }` — JSON Schema for the fields you want.
- `queryOptions: { prompt, mode: "directQuote" | "freeform" }` — for one targeted answer out of a huge page without pulling the whole thing.
- `onlyMainContent: true` — strips nav/footer chrome, usually want this on.
- `waitFor: 5000` (ms) — bump this first if a JS-rendered/SPA page comes back empty.
- `actions: [...]` — click, write, scroll, wait, press key, screenshot, executeJavascript, before returning content. Only in local (non-safe) mode, which is us.
- `formats: ["branding"]` — pulls colors/fonts/logo/UI components for design/style analysis.
- `maxAge` — serve cached data, up to 5x faster.
- `lockdown: true` — cache-only, no live fetch (air-gapped/compliance use).
- `location: { country, languages }`, `mobile`, `proxy: "basic"|"stealth"|"enhanced"|"auto"` — geo/device targeting and anti-bot tiers.

If JSON extraction comes back empty: raise `waitFor` → try the base URL without a `#fragment` → `firecrawl_map` with `search` to find the real page → `firecrawl_agent` only as a last resort.

```json
{"name": "firecrawl_scrape", "arguments": {
  "url": "https://example.com/pricing",
  "formats": ["json"],
  "jsonOptions": {
    "prompt": "Extract each pricing tier's name, price, and features",
    "schema": {"type":"object","properties":{"tiers":{"type":"array","items":{"type":"object","properties":{
      "name":{"type":"string"},"price":{"type":"string"},"features":{"type":"array","items":{"type":"string"}}
    }}}}}
  }
}}
```

---

## firecrawl_map — discover URLs on a site

Read-only, no page content — just a list of URLs. Use before scraping when you don't know the exact page, especially before reaching for `agent`.

Args: `url`, `search` (filter to matching pages — **this is the trick for "find the page about X"**), `sitemap: "include"|"skip"|"only"`, `includeSubdomains`, `limit`, `ignoreQueryParameters`.

```json
{"name": "firecrawl_map", "arguments": {"url": "https://docs.example.com/api", "search": "webhook events"}}
```

---

## firecrawl_search — web search + optional content

Full web search, not just Claude's built-in search — supports operators (`"exact"`, `-exclude`, `site:`, `inurl:`, `intitle:`, `related:`, `imagesize:`, `larger:`).

Args: `query`, `limit`, `sources: [{type: "web"|"images"|"news"}]`, `categories: ["github"|"research"|"pdf"]`, `includeDomains` / `excludeDomains` (not both), `tbs` (time filter), `location`, `scrapeOptions` (only add this if you actually need page content inline — costs more, keep `limit` ≤5 when you do).

Preferred pattern: search *without* `scrapeOptions` first, look at results, then `firecrawl_scrape` just the URLs you actually need.

```json
{"name": "firecrawl_search", "arguments": {"query": "site:github.com firecrawl mcp server", "limit": 5}}
```

Search costs 2 credits; call `firecrawl_search_feedback` with the returned `id` after using results to refund 1.

---

## firecrawl_crawl — whole site/section

Starts a crawl job, polls internally, returns everything when done (or times out). Can produce huge output — cap `limit`/`maxDiscoveryDepth` or you'll blow token limits. If you just need a handful of specific pages, do `map` + several `scrape` calls instead — cheaper and controllable.

Args: `url` (supports `*` wildcard for prefix), `prompt` (natural-language scope guidance), `excludePaths`/`includePaths`, `maxDiscoveryDepth`, `limit`, `allowExternalLinks`, `allowSubdomains`, `crawlEntireDomain`, `delay`, `maxConcurrency`, `webhook`/`webhookHeaders`, `deduplicateSimilarURLs`, `scrapeOptions` (same shape as scrape, minus `url`).

```json
{"name": "firecrawl_crawl", "arguments": {
  "url": "https://example.com/blog/*", "maxDiscoveryDepth": 3, "limit": 20
}}
```

Check on a long-running job separately with `firecrawl_check_crawl_status` (`{"id": "<crawl-id>"}`).

---

## firecrawl_extract — structured data across multiple known URLs

Like `scrape`'s JSON mode but batched over a list of URLs with one schema.

Args: `urls` (array), `prompt`, `schema`, `allowExternalLinks`, `enableWebSearch`, `includeSubdomains`.

```json
{"name": "firecrawl_extract", "arguments": {
  "urls": ["https://example.com/p1", "https://example.com/p2"],
  "prompt": "Extract product name, price, and description",
  "schema": {"type":"object","properties":{"name":{"type":"string"},"price":{"type":"number"},"description":{"type":"string"}},"required":["name","price"]}
}}
```

---

## firecrawl_agent + firecrawl_agent_status — autonomous research

Separate AI layer that browses/searches/navigates on its own. **Async** — returns a job id, you must poll. Only use when you don't know the URL(s) and `search`/`map` haven't found it, or the target is too JS-heavy for scrape/interact.

`firecrawl_agent` args: `prompt` (required, ≤10k chars), `urls` (optional, focuses the agent), `schema` (optional).

Then poll `firecrawl_agent_status` with `{"id": "..."}` every 15-30s. Give it 2-5 minutes for real research — don't bail after one check. Statuses: `processing`, `completed`, `failed`.

---

## firecrawl_interact + firecrawl_interact_stop — live browser session

For multi-step work on one page: click through results, fill a form, paginate, log in.

Target the page with **either** `url` (opens a fresh session) **or** `scrapeId` (reuse a session from a prior `firecrawl_scrape`) — not both. Describe the action with **either** `prompt` (natural language) **or** `code` (with `language: bash|python|node`, default node). `timeout` 1-300s (default 30).

```json
{"name": "firecrawl_interact", "arguments": {
  "url": "https://example.com/products", "prompt": "Click the first product and tell me its price"
}}
```

Call `firecrawl_interact_stop` with the `scrapeId` when done to free the session.

---

## firecrawl_monitor_* — recurring watch + diff

Creates a scheduled scrape/crawl/search that diffs against the last snapshot and can email/webhook you on meaningful change. Tools: `firecrawl_monitor_create`, `_list`, `_get`, `_update`, `_delete`, `_run` (trigger now), `_checks` (history), `_check` (one check's page-level diffs).

Simple create path: `page` or `pages` (or `queries` for search-mode monitoring) + `goal` (plain English — what counts as a meaningful change). Optional: `scheduleText` (default "every 30 minutes"), `email`, `webhookUrl`, `searchWindow`/`maxResults`/`includeDomains`/`excludeDomains` for query mode.

```json
{"name": "firecrawl_monitor_create", "arguments": {
  "page": "https://example.com/pricing",
  "goal": "Alert when a pricing tier, price, or billing period changes.",
  "email": "you@example.com"
}}
```

For structured field-level diffs (not just markdown diff text), pass `body` directly with a `changeTracking` format + JSON schema — see the tool's own description for the full shape if needed.

---

## firecrawl_parse — local files

Reads a local PDF/DOCX/DOC/ODT/RTF/XLSX/XLS/HTML file. **Requires `FIRECRAWL_API_URL` pointing at a self-hosted Firecrawl instance** — with just the cloud API key (our current setup) this tool will error. Skip it unless a self-hosted URL gets added to `.env`.

---

## firecrawl_research_* — academic papers

`firecrawl_research_search_papers` (topic → ranked papers, run several query framings), `firecrawl_research_inspect_paper` (metadata by id, e.g. `arxiv:1706.03762`), `firecrawl_research_related_papers` (citation-graph expansion from seed ids), `firecrawl_research_read_paper` (targeted full-text passages to verify a claim), `firecrawl_research_search_github` (code/repos related to a paper).

---

## Gotchas worth remembering

- **Format choice on `scrape`/`extract`**: specific fields → `json` + schema. Whole-page read → `markdown`. Don't default to markdown then parse it yourself for structured data.
- **Crawl token blowout**: always set `limit`/`maxDiscoveryDepth` on `firecrawl_crawl`. If output is too big, switch to `map` + targeted `scrape`.
- **Agent is slow and last-resort**: try `scrape` → `map`+`scrape` before `agent`. It's async and can take 5+ minutes.
- **`firecrawl_parse` needs self-hosting** — not usable with just `FIRECRAWL_API_KEY`.
- **Search costs 2 credits**, refund 1 by sending `firecrawl_search_feedback` after using the results.
