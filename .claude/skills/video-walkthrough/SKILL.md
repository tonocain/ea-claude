---
name: video-walkthrough
description: Turns an Airbnb listing link — or a folder of property photos — into a professional AI-generated vertical video walkthrough (9:16, ~30-60s) with background music, using the Higgsfield MCP. This is the production pipeline behind the `airbnb-video-leads` offer (see `projects/airbnb-video-leads/README.md`), but works for any property/listing. Triggers on: "hazme un video de recorrido de este depa", "convierte estas fotos en un video walkthrough", "necesito el video para [cliente/prospecto]", "genera el demo con Higgsfield", "quiero el video tipo Airbnb de este link", or whenever Antonio hands over an Airbnb URL or a folder of property photos and asks for a finished video tour.
---

# OBJECTIVE
Turn an Airbnb listing link (or a folder of raw property photos) into
one finished, vertical (9:16) video walkthrough with background music —
ready to send to a client or prospect. Output: a single `.mp4` file.

**Input mode:** if Antonio gives just a link, run the whole pipeline
end to end (steps 1-9) without stopping for intermediate approval —
he asked for this explicitly (2026-08-06) to cut down the back-and-forth
a first run needed. Still stop for the two things that are real
money/quality risk: the budget check (step 4) if the balance is short,
and if a photo/room is genuinely ambiguous (see RULES). Everything else
— destination, photo curation, model choice — uses the defaults below
without asking.

# LANGUAGE
Conversation with Antonio: Spanish. This file is English to keep it
cheap to load, per the repo's language rule.

---

# BEFORE YOU START — check `learnings.md`
Read `learnings.md` in this skill's folder first, if it exists — it
holds whatever was learned from real runs: prompt wording that worked,
model gotchas, client feedback. Each run should make the next one
better, not rediscover the same things. It won't exist until the first
real run creates it (step 10).

---

# PROCESS

## 1. Locate the client/project
Default, don't ask: check `RECORRIDOS - LEADS` in Airtable (CRM BASE)
for a record whose "Link de Airbnb" matches the URL Antonio gave you.
Match found → save to `projects/airbnb-video-leads/demo-video/[lead-name-slug]/`
(slugify the lead's Nombre/Empresa field), no confirmation needed — this
is a personalized pitch for that lead, same as the Joseph run. No match
(a link with no CRM record, or Antonio names a specific client) → ask
once: "¿Para qué cliente o proyecto es este video?" and use
`WORKSPACE/[cliente]/` for a client deliverable, `projects/[name]/`
otherwise. Never ask twice or re-litigate this mid-run.

## 2. Get the photos
**From an Airbnb URL (default path):** Airbnb only renders ~8-9 photos
as real `<img>` tags — the rest of a large gallery lives in a JSON blob
embedded in the page's script tags, not the DOM, and needs a click
through Airbnb's photo modal to reveal in a browser. Skip the modal —
extract everything in one scrape:
```bash
firecrawl scrape "<airbnb-url>" -f rawHtml --wait-for 3000 -o .firecrawl/listing.html
```
Then regex the raw HTML for every photo + its real caption in one pass
(far more reliable than visually reading each photo, and gives you the
room/amenity label for free):
```python
re.findall(r'"accessibilityLabel":(null|"[^"]*"),"baseUrl":"(https://a0\.muscache\.com/im/pictures/hosting/Hosting-\d+/original/[a-f0-9-]+\.(?:jpeg|jpg|png))"', html)
```
Dedupe by URL (dict keyed on url). Download the *base* URL with no
`?im_w=` query param — some width buckets 404 on Akamai's image
resizer even though the un-parameterized original always 200s (learned
2026-08-06, cost an extra round-trip). Pixabay/muscache both need a
real `User-Agent` header on the `curl`, a bare request gets blocked.

**From a folder of photos (fallback, if Antonio hands you files
directly):** convert non-standard formats (`.avif`, `.webp`, `.heic`)
to `.jpg` with macOS `sips`. Dedupe: listing exports often contain
exact duplicates or the same shot at two resolutions — compare file
sizes, confirm same-size collisions with `md5`, keep the higher
resolution of same-name/different-size pairs.

## 3. Curate and order the walkthrough
With captions in hand (from step 2's `accessibilityLabel`s), sort
photos into two buckets by keyword: **unit** (sala, comedor, cocina,
recámara/habitación, baño, área de trabajo) and **amenities** (alberca,
gimnasio, cine, ludoteca, terraza, jardín, estacionamiento, lavandería,
sala de juegos, and similar shared-building extras — common on
condo/residencial listings, not standalone apartments).

Default selection (apply without asking, then show the final numbered
list as an FYI before moving to step 4 — not a multi-round negotiation):
- **Unit:** up to 2 shots per room type, preferring photos with a rich,
  specific caption over generic placeholders like "Sala imagen 6" (those
  exist because Airbnb ran out of unique captions, not because the
  photo is worse — but a specific caption means the alt-text pipeline
  actually described it, which correlates with a stronger shot). Cover
  every room type present: sala, comedor/cocina, each recámara, baño.
- **Amenities:** if any exist, one shot per distinct category, capped
  so the total (unit + amenities) stays around 14-18 clips — long
  enough to show everything once, short enough to stay a ~45-70s video
  and a reasonable credit spend. If Antonio previously said "muestra
  todas las amenidades" for a similar property, keep applying that
  (don't re-ask) unless a run has 10+ amenity categories, in which case
  flag the count before generating.
- **Order:** overview/hero (best light, e.g. "atardecer") → living/common
  → kitchen/dining → bedroom(s), wide then a detail shot → bathroom →
  in-unit extras (laundry, home office) → building amenities, roughly
  gym → social spaces (game room, cinema, playroom) → outdoor (garden,
  terrace) → pool as the closing shot (reads as the "wow" amenity).
- Rename downloaded files with a leading two-digit number in this final
  order (`01-sala-atardecer.jpg`, etc.) — makes upload, generation,
  download and stitching all trivially orderable by filename.

**If a caption is missing or just says "Fotos adicionales imagen N"**
(no real label), read that one photo with the Read tool before deciding
whether to include it — don't guess a room label from a generic caption.

## 4. Check the budget before generating anything
Call Higgsfield's `balance` tool for available credits, then get a real
quote with `generate_video(..., get_cost: true)` for the model/settings
you're about to use. Pricing is not intuitive and varies a lot between
models for a comparable look — see `reference.md` for the last known
cost table, and re-verify with `get_cost` since pricing can change.
Don't re-shop `cinematic_studio_video_v2` against alternatives
(kie.ai's Seedance/Kling included) every run — that comparison was done
2026-08-06 and came out at price parity while needing a from-scratch
integration; only redo it if Antonio explicitly asks or a `get_cost`
quote shows a big jump from `reference.md`'s numbers.

**This is the one real stop-and-check point in an otherwise autonomous
run.** If `photos × cost-per-clip` doesn't comfortably fit the balance:
call `show_plans_and_credits(intent: "topup")`, pick the smallest pack
that covers the shortfall (packs are 500/1,000/2,000/4,000 credits —
don't default to the "recommended" biggest one), and give Antonio the
exact numbers plus that pack's checkout link. Never call
`confirm_billing_purchase` yourself — only Antonio can complete a
purchase. Wait for him to confirm before generating.

## 5. Upload the photos
The upload widget (`media_upload_widget`) needs Apps UI support that
this MCP client may not have — if it doesn't confirm any media, go
straight to the programmatic path: call `media_upload` with all
filenames in final order (batch `files[]`). Its response includes a
presigned `upload_url` **and a ready-to-run curl command** per file in
`instructions`. Run those commands directly via Bash instead of
re-deriving them by hand. Then call `media_confirm` once with all
returned `media_id`s.

## 6. Generate one video clip per photo
Use `generate_video_batch` (not one `generate_video` call per photo —
batch keeps job indices straight and is the documented pattern for
2-12 independent generations). For each photo:
- Model/settings: see `reference.md` for the current recommendation
  (as of this writing: `cinematic_studio_video_v2`,
  `aspect_ratio: "9:16"`, `mode: "std"`, `sound: "off"`,
  `duration: 4`) — cheap, and it reframes a horizontal listing photo
  into a good vertical composition natively. No need for the separate
  `reframe` tool — it's priced per-second and can cost more than the
  entire batch of clips.
- Prompt: tailor it to what you actually saw in that photo (step 3) —
  e.g. "slow cinematic dolly-in toward the bed, cozy atmosphere, soft
  natural light, no people, professional real estate videography" —
  not one generic prompt reused for every photo. Always include
  "no people" and a calm/slow camera descriptor unless Antonio asked
  for a different pace.
- Poll with `jobs_wait` in groups (up to 12 jobs per call).
  **Starter-plan gotcha:** only 2 jobs can be `in_progress`/`queued`
  concurrently — a batch of more than 2 will report some
  `submission_failed`, either a real rate-limit error or a spurious
  "Out of credits" (seen 2026-08-06 with a healthy 517cr balance —
  `generate_video_batch`'s pre-flight credit check races under
  concurrent submission). Either way it's not a real failure: check
  `balance` to confirm only the accepted jobs were charged, then
  resubmit the rest individually with `generate_video`.
- **Efficient resubmission pattern:** don't resubmit a whole new batch.
  Keep exactly 2 jobs in flight — the moment `jobs_wait` reports one
  `completed`, submit the next queued photo with a single
  `generate_video` call to refill the slot. Each clip takes roughly
  1.5-3 minutes, so for N photos expect close to `N/2` of those cycles
  — there's no way to shortcut this on the Starter plan's concurrency
  cap short of Antonio upgrading the plan.
- Once everything is done, call `show_generation_by_ids` once with the
  full set — don't call `job_display`/`show_generations` per clip.

## 7. Download and stitch
Download each clip (`result_url` from `jobs_wait`) in final order, then
stitch with the bundled script:
```
scripts/stitch.sh <crossfade_seconds> <output.mp4> <clip1> <clip2> ... <clipN>
```
It reads each clip's actual duration via `ffprobe` and computes the
crossfade math for you, so clips don't need to be the same length.
0.3-0.5s crossfade reads as "professional edit" rather than a
slideshow; much more starts to look like a dissolve effect. This step
is 100% local `ffmpeg` — no Higgsfield credits spent.

## 8. Background music
Higgsfield has **no general-purpose music model** — its only audio
generation is text-to-speech (the one music model, `sonilo_music`, is
reserved for the game-generation pipeline and refuses standalone use).
Source royalty-free music instead:
- Ask Antonio if he wants to supply a track, or if you should find one.
- If finding one: Firecrawl-search a royalty-free catalog (Pixabay has
  genre/theme-specific categories — e.g. a dedicated "real estate"
  one) for the property type/mood. Check the license line on the
  *specific track's* page — don't assume from the site's general
  reputation.
- The direct download link is usually not in the rendered page markdown
  — scrape with `-f rawHtml` and grep for the CDN download pattern
  (e.g. `cdn.pixabay.com/download/audio/...mp3`) to find it.
- Trim to the stitched video's exact duration with a ~1s fade-in and
  ~2s fade-out, then mux in with `ffmpeg`
  (`-c:v copy -c:a aac -shortest`) — never re-encode the video track,
  only add the audio stream.

## 9. Verify and deliver
- `ffprobe` the final file: confirm duration, that it's actually 9:16
  (or whatever aspect ratio was requested), and that both a video and
  audio stream are present if music was added.
- `open` the file locally so Antonio can review it before calling it
  done.
- Save it to the location decided in step 1. If it's for the
  `airbnb-video-leads` offer specifically, also note the run (cost,
  any prompt/model change) in that project's README pipeline section.

## 10. Log what you learned
Append a short entry to this skill's `learnings.md` (create it on the
first real run): date, what worked, what you'd do differently, any
cost surprise, any feedback from Antonio or the client on the result.
Keep entries terse — this file gets skimmed at the start of the next
run (step 0), not read as a diary.

---

# REFERENCE FILES
- `reference.md` — current model recommendation + cost table, the
  Pixabay sourcing recipe, and the exact `media_upload`/curl pattern.
  Read it before step 4 if pricing/model choice matters for this run.
- `scripts/stitch.sh` — crossfade stitching script (step 7).
- `learnings.md` — accumulated notes from real runs (read at step 0,
  write at step 10). Doesn't exist until the first real run creates it.

---

# RULES (what can go wrong)
- **Don't skip the visual room-ID step.** Filenames from listing
  exports are meaningless; ordering from timestamps alone risks a
  walkthrough that jumps around illogically (bathroom → living room →
  bathroom).
- **Don't generate before checking `balance` + `get_cost`.** Higgsfield
  model pricing is not intuitive — a 5x difference between models was
  observed for comparable quality. A batch submitted blind can burn
  through the whole balance on 2-3 clips.
- **Don't try to get Higgsfield to make background music.** It will
  either fail outright or silently reach for the wrong model. Source
  music externally, always.
- **Don't hand-write your own upload curl commands** when
  `media_upload`'s response already contains a working one per file —
  re-deriving them is slower and error-prone (long presigned URLs are
  easy to truncate or mistype).
- **The Starter-plan concurrency limit (2 jobs) is not a real error** —
  don't report generation as "failed," just resubmit once a slot frees
  up. Same goes for a "submission_failed: Out of credits" that shows up
  alongside real rate-limit failures in the same batch response —
  cross-check `balance` before believing it (see step 6).
- **Never fabricate what's in a photo.** If a room is ambiguous even
  after looking at it, ask Antonio rather than guessing a label that
  could drive an odd or wrong camera-motion prompt.
- **Destination is auto-inferred (step 1), not asked** — only fall back
  to asking when there's no CRM match and no client named. Don't ask
  again mid-run once it's set.
- **Extracting the ready-to-run curl command from `media_upload`'s
  `instructions` field:** the string is one continuous line with no
  real newline before the trailing "After upload, call media_confirm…"
  sentence — a regex like `curl -X PUT.*` (no anchor) will swallow that
  trailing text too and produce a broken command. Anchor the match to
  the closing quote of the URL instead: `curl -X PUT.*'` (there are
  exactly two `'` in the string — greedy `.*` correctly lands on the
  second one). Confirmed cost of getting this wrong: silent per-file
  upload failures that look like DNS errors ("Could not resolve host:
  After") — cheap to avoid, expensive to debug blind.
- **Respect music licensing** — only use tracks explicitly marked
  royalty-free/free-for-commercial-use, verified on the specific
  track's page. Pixabay has been flaky (503/500) mid-session before —
  not a licensing issue, just retry the scrape after a few seconds.

---

# WHAT YOU DO NOT DO
- Don't propose or discuss automation/AI strategy for the client's
  business as part of this skill — that's a separate conversation.
- Don't send or publish the video anywhere (WhatsApp, email, socials)
  — hand it off locally and let Antonio decide distribution.
