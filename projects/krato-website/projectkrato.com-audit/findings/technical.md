# Technical SEO — projectkrato.com

Score: 82/100

## What works

- HTTPS enforced; HSTS header present (`max-age=31536000`).
- `http://` → `https://` and `www.` → apex both 301-redirect cleanly to `https://projectkrato.com/`.
- `robots.txt` present, permissive (`Allow: /`), references the sitemap. No AI-crawler blocks (GPTBot, ClaudeBot, Google-Extended, PerplexityBot, CCBot all implicitly allowed) — good for GEO.
- Valid `<link rel="canonical">` on the homepage.
- 404s return a real `404` status (checked `/this-page-does-not-exist`).
- Fast server response: root document in 130ms (Netlify Edge).
- Mobile viewport meta present; responsive layout confirmed via Lighthouse mobile run.

## Findings

| Severity | Finding | Recommendation |
|---|---|---|
| High | `sitemap.xml` lists only the homepage — `aviso-legal.html` (indexable, has its own canonical) is missing. | Add a `<url>` entry for `https://projectkrato.com/aviso-legal.html`. |
| High | No security headers beyond HSTS: missing `Content-Security-Policy`, `X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Permissions-Policy`. | Add a Netlify `_headers` file (or `netlify.toml` `[[headers]]`) with the standard set. Netlify serves this without any app code changes. |
| Low | `<link rel="icon" type="image/png" sizes="32x32" href="/favicon.svg">` declares `type="image/png"` but points at an `.svg` file. | Fix the `type` attribute to `image/svg+xml`, or drop this redundant line (the first `<link rel="icon">` already covers SVG). |

## Not applicable / correctly scoped

- `gracias.html` correctly carries `<meta name="robots" content="noindex">` — right call for a post-form thank-you page with no unique content.
