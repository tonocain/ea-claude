# Schema & Structured Data — projectkrato.com

Score: 75/100

## What works

- Valid `ProfessionalService` JSON-LD on the homepage (confirmed via JSON parse — no syntax errors).
- Good field coverage: `name`, `description`, `slogan`, `url`, `logo`, `image`, `priceRange`, `email`, `telephone`, `areaServed`, `address`, `contactPoint` (two, correctly typed for customer service vs. sales/WhatsApp), `serviceType`, `makesOffer` (both service lines individually described).

## Findings

| Severity | Finding | Recommendation |
|---|---|---|
| Medium | No `sameAs` array linking to real social/professional profiles (e.g., LinkedIn). | Add once a real profile exists — ties directly to the E-E-A-T gap in `content.md`. |
| Low | No `founder` / `Person` entity for Antonio Cain within the `ProfessionalService` schema. | Add a minimal `Person` object as `founder` once the About/bio content exists. |
| Low | `aviso-legal.html` has no structured data at all (not even a basic `WebPage` type). | Low priority — a legal page doesn't need rich schema, but a minimal `WebPage`/`Organization` reference is a one-line addition if you want full coverage. |
| Info | No `aggregateRating`/`review` — correctly absent given no clients yet. Do not add placeholder reviews; that would violate Google's structured data guidelines. | No action until real reviews exist. |
