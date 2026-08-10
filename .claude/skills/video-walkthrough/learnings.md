# Learnings — video-walkthrough

Append one entry per real run. Terse — this gets skimmed before the
next run starts, not read as a diary.

---

## 2026-08-04 — first real run (CDMX studio listing, 9 photos)

- **What worked:** `cinematic_studio_video_v2` at 4s/std/9:16/sound-off
  reframed every horizontal listing photo into vertical cleanly — no
  visible cropping or distortion in any of the 9 clips. No need to
  reach for `reframe`.
- **Cost:** 36 credits for 9 photos (4 cr/clip), against a 53.1 balance.
  Matched the `get_cost` quote exactly.
- **Gotcha confirmed:** Starter plan's 2-concurrent-job limit triggered
  on a 9-item `generate_video_batch` — 8 submitted fine, 1 came back
  `submission_failed`. Resubmitted individually with `generate_video`
  once active jobs dropped below 2 — worked immediately, no other
  side effects.
- **Room ID:** source filenames were opaque UUIDs from a scraped/saved
  listing. Converting to `.jpg` and reading each with the Read tool
  (not `.avif` directly — doesn't render) was the only reliable way to
  identify rooms. Download timestamps (`stat`, second-level precision)
  turned out to closely match the likely original gallery order, but
  the visual pass still found a better narrative order than raw
  timestamp order (grouping each room's wide shot before its detail
  shot reads better than the literal upload sequence).
- **Music:** Pixabay's dedicated "real estate" music category had a
  good calm/instrumental match on the first search. Direct download
  URL only shows up in raw HTML (`-f rawHtml`), not the markdown
  scrape.
- **Feedback:** pending — Antonio hadn't reviewed the finished video
  yet when this skill was written.
- **Didn't try:** a longer duration per clip (5s+), `kling3_0`, or a
  music track from a source other than Pixabay. Worth comparing if a
  future run has more budget headroom or the "classic" pace feels too
  quick at 4s/room.

## 2026-08-06 — first real lead (Joseph, 16 photos incl. amenities)

- **Hidden gallery photos:** Airbnb listing pages only render ~9 photos
  as actual `<img>` tags — the rest of a large gallery (this listing
  had 85 total) sit in a JSON blob embedded in the page's script tags,
  not the DOM. `firecrawl scrape -f rawHtml` + regex on
  `"accessibilityLabel":...,"baseUrl":"...muscache.com..."` pulled all
  85 with real captions in one pass — much better than trying to
  interact-click through Airbnb's photo modal.
- **Building-amenity listings:** condo/residencial listings (vs. a
  single apartment) mix unit photos with dozens of shared-amenity
  photos (gym, pool, cinema room, playroom, parking). When Antonio
  wants amenities represented, pick one strong photo per category
  rather than proportionally sampling — kept it to 16 total (8 unit +
  8 amenities) instead of ballooning further.
- **kie.ai direct API comparison:** checked as a cheaper alternative
  before topping up Higgsfield credits. Cheapest kie.ai option
  (Seedance 2.0 Mini, 480p) landed at the same ~$0.19/4s-clip as
  Higgsfield's `cinematic_studio_video_v2` — no savings, and would
  require building the upload/poll/download flow from scratch instead
  of reusing Higgsfield's working MCP pipeline. Not worth switching
  unless a future check finds a real price gap.
- **`generate_video_batch` credit-check race:** submitting 12 requests
  at once produced a mix of real rate-limit failures AND spurious
  "Out of credits" errors even though the balance was healthy (517cr) —
  looks like a race in the batch endpoint's pre-flight credit check
  under concurrent submission. Balance after the batch confirmed only
  the genuinely-accepted jobs were charged. Fix was the same as the
  documented rate-limit gotcha: ignore the error text, resubmit
  individually via `generate_video` once active jobs drop below 2.
  Keeping exactly 2 jobs in flight at all times (resubmit the moment
  one completes) is the efficient pattern instead of resubmitting a
  big batch again.
- **Generation time:** each clip took roughly 1.5–3 minutes; with the
  2-concurrent cap, 16 clips took a while in serial pairs. No way
  around this on Starter plan short of upgrading.
- **Music:** Pixabay was flaky mid-session (503/500 on the track page
  a couple of times) — not a blocker, just retried the scrape after a
  short wait and it came through. "Real Estate Hotel Resort" (mirostar,
  Meditation/Spiritual) was a good pick for a property with hotel-like
  amenities.
- **Feedback:** pending — video just generated, Antonio hasn't reviewed
  yet.

## 2026-08-06 — Inmuebles24 office listing (Polanco, 4 photos)

- **New source: Inmuebles24, not Airbnb.** Photos live on
  `img*.naventcdn.com/avisos/<path>/<size>/<id>.jpg` in five size
  buckets (100x75, 215x159, 360x266, 720x532, 1200x1200). Regex the
  rawHtml for the URL pattern, dedupe by the numeric id, and download
  the `1200x1200` bucket. No captions available — unlike Airbnb's
  `accessibilityLabel`, there is nothing to sort rooms by, so the
  visual Read pass on every photo is mandatory, not optional.
- **Listings are photo-poor.** This one had 5 photos total (Airbnb runs
  9-85). One was a Google Street View screenshot of the building
  facade — visually bad (power lines, poles) and Google's image
  besides. Discarded it. Rule of thumb: expect 4-8 usable photos from
  a portal listing, and bump `duration` to 5s to keep the video from
  landing under ~15s. 4 clips × 5s + 0.4s crossfades = 19s final.
- **Cost at 5s:** `get_cost` returned 5 cr/clip (vs 4 cr at 4s) — the
  ~1 cr/sec rule in `reference.md` held. 20 cr total, balance
  453.1 → 433.1, exact match.
- **Preset-recommendation interception:** a prompt containing "dark
  conference table ... soft daylight" triggered a
  `preset_recommendation` notice for the "IN THE DARK" preset and
  submitted *no job*. Resubmit the identical params plus
  `declined_preset_id: "<id from the notice>"` to force the literal
  generation. Watch for this on any prompt with moody/dark wording.
- **Pixabay track links:** the `/music/search/...` page's rawHtml no
  longer contains any `.mp3` URL at all (0 hits) — only cover-art
  `cdn.pixabay.com/audio/.../*_200x200.png`. Track *page* paths are
  there though, as bare `/music/<slug>-<id>` strings (not quoted hrefs,
  so a `"(/music/...)"` regex finds nothing — match
  `/music/[a-zA-Z0-9-]+` unquoted). Scrape one track page and the
  `cdn.pixabay.com/download/audio/...mp3?filename=` URL is present as
  before.
- **Copyright, asked directly by Antonio:** portal listing photos are
  the agency's/photographer's, no fair use in Mexico. Treat
  portal-sourced demos as internal/1:1-to-that-listing's-owner only —
  never a public reel. Preferred path going forward is asking the
  prospect for their own photos, which doubles as the sales opener.
