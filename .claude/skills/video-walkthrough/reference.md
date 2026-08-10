# Reference — video-walkthrough

Detail that doesn't need to be in SKILL.md every time it loads. Prices
and model behavior can drift — treat the numbers below as "last known,"
not gospel, and re-check with `get_cost` before trusting them.

## Model recommendation (last verified: 2026-08-04, Starter plan)

Real `get_cost` quotes for a 9:16, no-audio, image-to-video clip:

| Model | Settings | Cost/clip | Notes |
|---|---|---|---|
| `seedance_2_0` | std, 720p, 5s | 22.5 cr | Top of the default recommendation list, but expensive |
| `kling3_0` | std, 5s | 7.5 cr | Cheaper, still pricey at scale |
| `seedance_2_0` | fast, 480p, 4s | 6 cr | Cheap but low resolution |
| **`cinematic_studio_video_v2`** | std, 4s | **4 cr** | Best cost/quality tradeoff found so far |
| `reframe` (video→video, 9:16) | 5s, 720p | ~28.5 cr | Per-clip cost alone exceeds the whole batch above — avoid unless budget is not a concern |

Default params used successfully:
```json
{
  "model": "cinematic_studio_video_v2",
  "aspect_ratio": "9:16",
  "mode": "std",
  "sound": "off",
  "duration": 4,
  "prompt": "<tailored per-room prompt>",
  "medias": [{"role": "image", "value": "<media_id>"}]
}
```
`cinematic_studio_video_v2` handled the horizontal-photo → vertical-video
reframe well on its own in every test case — it extended plausible room
geometry at the edges rather than just cropping. If a future run shows
bad cropping/distortion, that's the moment to reconsider `reframe`
despite the cost, not before.

Cost scales roughly linearly with duration at ~1 credit/second in this
configuration — e.g. 9 photos × 4s ≈ 36 credits total.

## media_upload → curl → media_confirm pattern

```
media_upload({ files: [{filename, content_type: "image/jpeg"}, ...] })
```
Returns, per file: `media_id`, `upload_url` (presigned S3 PUT, expires
in ~15 min), and an `instructions` string containing a complete,
ready-to-run curl command. Run each one directly, e.g.:
```bash
curl -X PUT -H "Content-Type: image/jpeg" --data-binary @01_sala.jpg '<upload_url>'
```
Check for `200` responses, then:
```
media_confirm({ type: "image", media_ids: [...] })
```
Batch both calls (all files in one `media_upload` call, all ids in one
`media_confirm` call) rather than looping one file at a time.

If the presigned URLs are very long (they usually are — AWS SigV4
query strings), write them to a throwaway shell script file first
(scratchpad) rather than inlining giant curl commands directly in a
Bash tool call — easier to review and re-run if one upload fails.

## Sourcing royalty-free music (Pixabay)

1. Firecrawl-search e.g. `"royalty-free calm corporate real estate background music mp3 no attribution"` — Pixabay's dedicated genre/theme categories (found via search, e.g. `pixabay.com/music/search/real%20estate/`) are a good match for property videos.
2. Pick a track whose genre/mood fits the pacing (Instrumental + a calm mood tag for a "classic real estate" edit; avoid Upbeat/Beats-tagged tracks for a slow walkthrough).
3. The rendered markdown scrape of a track page does **not** contain the direct audio URL (it's loaded client-side). Re-scrape with raw HTML:
   ```bash
   firecrawl scrape "<track-page-url>" -f rawHtml -o track.html
   grep -o 'https://cdn\.pixabay\.com/download/audio/[^"'"'"']*\.mp3' track.html
   ```
4. Confirm the license line on that specific track's page (Pixabay's Content License generally doesn't require attribution, but check the page — licensing terms can change, and this is being reused for client-facing/commercial work).
5. Download with `curl -L -o music-raw.mp3 "<direct-url>"`, verify with `ffprobe`.

## Muxing music onto the stitched video

```bash
ffmpeg -y -i walkthrough_silent.mp4 -i music-raw.mp3 \
  -filter_complex "[1:a]atrim=0:<total_duration>,afade=t=in:st=0:d=1,afade=t=out:st=<total_duration-2>:d=2,volume=0.9[aout]" \
  -map 0:v -map "[aout]" -c:v copy -c:a aac -b:a 192k -shortest \
  final.mp4
```
`<total_duration>` is the stitched video's actual duration (from
`ffprobe`) — get the exact number, don't estimate it, or the fade-out
timing will be off or the track will cut short/long.

## Concurrency

Starter plan caps at **2 concurrent generation jobs**. Submitting a
`generate_video_batch` of more than 2 will return
`submission_failed` for the overflow with:
`"Rate limit reached: max 2 concurrent job(s) on starter (annual) plan."`
This is expected, not a bug — poll the accepted jobs down with
`jobs_wait`, and once fewer than 2 are active, resubmit the failed
ones individually via `generate_video`.
