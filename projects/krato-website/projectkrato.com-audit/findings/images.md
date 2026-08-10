# Images — projectkrato.com

Score: 90/100

## What works

- No `<img>` tags on the page at all — all visual elements are inline SVG (correctly `aria-hidden` where decorative) or CSS. This means there are zero missing-alt-text issues, because there's nothing that needs one.
- `og-image.jpg` exists and is correctly referenced at the right dimensions (1200×630) for social sharing.

## Findings

| Severity | Finding | Recommendation |
|---|---|---|
| High | `og-image.jpg` (verified by downloading and viewing it) shows **stale messaging**: "Inteligencia digital que convierte datos en decisiones" / "Agencia de Inteligencia Digital · México" — this doesn't match the current site at all (current positioning: "Tu negocio no tiene un problema de leads, tiene un problema de sistema" / "Sistemas de Venta con IA + Software a Medida"). Anyone sharing the homepage link on WhatsApp, LinkedIn, etc. sees this outdated preview card. | Regenerate `og-image.jpg` (1200×630) with the current messaging and the corrected logo (black square, lime "K") — same leftover-copy problem already flagged for the old brand PDF in `brand-guidelines.md`. |
| Info | The site currently has no photographic/illustrative imagery at all (portfolio shots, team photo, etc.) — this is a content-strategy gap more than an image-SEO one. | Tracked under `content.md`, not scored here. |
