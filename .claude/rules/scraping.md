<!-- Language rule: all file content in English. User communicates in Spanish; reply in Spanish, write files in English. -->
# Web Scraping (Firecrawl)

Default assumption: if a request involves pulling data off the web — scraping a page, extracting structured fields, screenshots, crawling a site, mapping structure, or monitoring for changes — it's a Firecrawl job. Prefer Firecrawl over `WebFetch`/`WebSearch` or hand-rolled `curl`/scraping scripts.

**Reference:** `references/sops/firecrawl-cheatsheet.md` maps every tool to when to use it, key args, and gotchas (JSON vs markdown format, crawl token limits, `agent` being slow/last-resort). Check it before guessing which tool fits.

**Working style:**
- Default to the cheapest tool: `scrape` a known URL > `map`+`scrape` an unknown page > `crawl` a whole section > `agent` as a last resort for messy JS-heavy targets.
- Want specific fields (price, spec, list items)? Use `formats: ["json"]` with a schema — don't scrape markdown and parse it by hand.
- Recurring "let me know when X changes" requests → set up a monitor instead of re-scraping manually.

**Auth:** `FIRECRAWL_API_KEY` is a global environment variable — works from any project, no per-project `.env` needed.

**Used for:** prospect research, step 1 of the client-capture process (see `WORKSPACE/project-krato/discovery-output.md`).
