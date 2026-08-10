# Performance (Core Web Vitals) — projectkrato.com

Score: 92/100

Measured live via Lighthouse (mobile emulation, throttled) against `https://projectkrato.com/`.

| Metric | Value | Status |
|---|---|---|
| Performance score | 95/100 | Good |
| LCP (Largest Contentful Paint) | 1.1s | Good (< 2.5s) |
| CLS (Cumulative Layout Shift) | 0 | Perfect |
| TBT (Total Blocking Time) | 260ms | Borderline (good < 200ms) |
| FCP (First Contentful Paint) | 0.9s | Good |
| Speed Index | 2.6s | Good |
| Server response time | 130ms | Good |
| Accessibility | 100/100 | — |
| Best Practices | 100/100 | — |
| Lighthouse SEO | 100/100 | — |

## Findings

| Severity | Finding | Recommendation |
|---|---|---|
| Low | TBT sits just above the "good" threshold (260ms vs. <200ms). Almost certainly the Spline 3D viewer script, which the site already smartly defers to desktop-only (`min-width: 961px`) via the existing `ponytail:` comment in the code. | Not urgent given it's already gated to desktop and CLS is 0. If you want to push further, defer the Spline script load with `requestIdleCallback` instead of firing immediately on desktop. |
| Info | Minification/unused-CSS/unused-JS audits all came back clean (0ms savings) — the hand-written inline `<style>` is already lean. | No action needed. |

## Accessibility (bonus finding, surfaced by the same Lighthouse run)

| Severity | Finding | Recommendation |
|---|---|---|
| Low | 3 links have an `aria-label` that doesn't contain their visible text (WCAG 2.5.3 Label in Name) — `nav-logo` ("K PROJECT KRATO" vs. label "Project Krato — Inicio"), footer email link, footer phone link. | Remove the redundant `aria-label` on these three — the visible text already serves as a perfectly good accessible name. |
