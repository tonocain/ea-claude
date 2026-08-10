# Email outreach — Krato Recorridos

Two-email sequence for the 54 leads in Airtable's `RECORRIDOS - LEADS` table. Voice matches the landing page: warm, direct, short sentences, no corporate framing, transparent about price. Content below is the actual send copy (Spanish), not documentation.

Mail-merge field needed: `{{Empresa}}` (from the Empresa column). Everything else is fixed. Updated 2026-08-05 to reflect what's actually on the landing page now (demo video, traditional-vs-us comparison, real pricing) — the first draft predated all three.

## Email 1 — first touch

### Subject — pick one
- A) `Un recorrido en video para {{Empresa}}`
- B) `{{Empresa}} — casi nadie en Airbnb usa esto todavía`

A is the safe, clear default. B leans harder into the landing page's hook line — tends to pull higher opens from curiosity, slightly more risk of reading like a pitch.

### Body
```
Hola,

Vi el listing de {{Empresa}} en Airbnb. Como casi todos en CDMX, solo tiene fotos.

Convertimos esas mismas fotos en un recorrido en video — vertical, cinematográfico, listo en 2 días hábiles. Sin sesión nueva, sin fotógrafo que agendar. Desde $70 USD por video.

Aquí puedes ver uno real, hecho para un depa en CDMX:
https://projectkrato.com/recorridos

Si te late, contesta este correo o escríbeme por WhatsApp: https://api.whatsapp.com/send/?phone=525585389878&text&type=phone_number&app_absent=0

Antonio
Krato Recorridos — un proyecto de Project Krato
```

### HTML version (used for the actual Gmail drafts)

Branded HTML instead of plain text — white card on light-gray background, Krato Recorridos wordmark, the demo video's poster image (linked to the landing page, since email can't autoplay video), a Rausch-red CTA button, matching the site's visual system. Table-based layout for email-client compatibility; inline styles throughout (email clients strip `<style>` tags). Plain-text `body` above is kept as the fallback/alt version on every draft.

Accented characters are written as plain UTF-8 (á, é, í, ó, ú, ñ), not HTML entities — Gmail's API handles UTF-8 fine, and hand-written entities are exactly what caused the `esc&riacute;beme` bug in the first pass (an invalid entity name, should never have needed one).

```html
<!DOCTYPE html>
<html>
<body style="margin:0;padding:0;background-color:#f7f7f7;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background-color:#f7f7f7;padding:32px 16px;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Helvetica,Arial,sans-serif;">
<tr><td align="center">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;background-color:#ffffff;border-radius:14px;overflow:hidden;">
<tr><td style="padding:32px 40px 0;">
<span style="font-size:18px;font-weight:700;color:#222222;">Krato <span style="color:#ff385c;">Recorridos</span></span>
</td></tr>
<tr><td style="padding:24px 40px 0;font-size:16px;line-height:1.6;color:#3f3f3f;">
<p style="margin:0 0 16px;">Hola,</p>
<p style="margin:0 0 16px;">Vi el listing de <strong style="color:#222222;">{{Empresa}}</strong> en Airbnb. Como casi todos en CDMX, solo tiene fotos.</p>
<p style="margin:0 0 16px;">Convertimos esas mismas fotos en un recorrido en video — vertical, cinematográfico, listo en <strong>2 días hábiles</strong>. Sin sesión nueva, sin fotógrafo que agendar. Desde <strong>$70 USD</strong> por video.</p>
</td></tr>
<tr><td style="padding:8px 40px 0;" align="center">
<a href="https://projectkrato.com/recorridos" style="display:block;text-decoration:none;">
<img src="https://projectkrato.com/recorrido-demo-poster.jpg" width="220" alt="Ejemplo de recorrido en video" style="display:block;border-radius:12px;margin:0 auto;border:0;" />
</a>
<p style="margin:8px 0 0;font-size:12px;color:#6a6a6a;">Así se ve un recorrido real — dale clic para verlo</p>
</td></tr>
<tr><td style="padding:28px 40px 8px;" align="center">
<a href="https://projectkrato.com/recorridos" style="display:inline-block;background-color:#ff385c;color:#ffffff;font-weight:600;font-size:15px;text-decoration:none;padding:14px 28px;border-radius:8px;">Ver el recorrido</a>
</td></tr>
<tr><td style="padding:8px 40px 32px;" align="center">
<p style="margin:0;font-size:14px;color:#3f3f3f;">Si te late, contesta este correo o escríbeme por <a href="https://api.whatsapp.com/send/?phone=525585389878&text&type=phone_number&app_absent=0" style="color:#ff385c;text-decoration:none;font-weight:600;">WhatsApp</a>.</p>
</td></tr>
<tr><td style="padding:20px 40px;border-top:1px solid #ebebeb;">
<p style="margin:0;font-size:13px;color:#222222;font-weight:600;">Antonio</p>
<p style="margin:2px 0 0;font-size:12px;color:#6a6a6a;">Krato Recorridos — un proyecto de <a href="https://projectkrato.com" style="color:#6a6a6a;">Project Krato</a></p>
</td></tr>
</table>
</td></tr>
</table>
</body>
</html>
```

### Sent (2026-08-05) — batch 1 of 54
CityStays, Hospeda Hoy, Niu Coliving, Hosteando, Naya Homes — reviewed and sent by Antonio. CRM updated: Estado → Contactado, Notas logged, Fecha de seguimiento set to 2026-08-10 (Email 2 follow-up window) on all 5.

### Sent (2026-08-05) — batch 2 of 54, 15 of 54 total
Nemvo, Hana175, Grand Chapultepec Residencial, Hotel San Lucas, Mr. W, Lamartine 619 Residencial, Armonia Airbnb, Guestology, Pm Tec Group, GoRent. 3 bounced (confirmed via Gmail delivery-failure notifications, not just Antonio's read of them):
- **Mr. W** (hola@hellomrw.com) — address doesn't exist (550 5.1.1)
- **Pm Tec Group** (rrhh@pm-tec-group.com.mx) — address doesn't exist (550 5.1.1)
- **GoRent** (contacto@gorent.mx) — inbox actually full

Antonio WhatsApp'd all 3 directly as a fallback: "Hola les envie un email pero me arroja gmail q tu buzon esta lleno, te puedo compartir un poco de info por aca?" — logged in each lead's Notas, Estado → Contactado, follow-up date pulled in to 2026-08-07 (sooner than the email-only 2026-08-10 window, since WhatsApp gets faster replies). The other 7 delivered fine, same 2026-08-10 follow-up as batch 1.

**Pattern for future batches:** check Gmail for delivery-failure notifications (`subject:(Delivery OR Undelivered OR failure)`) after each send — a `mailto:` bounce doesn't mean the lead is dead, it means switch channel. 41 leads remaining after this batch.

### Sent (2026-08-05) — batch 3 of 54, 25 of 54 total
Enrique Y Ricardo, Inmense Hotels, Casanevo, Rentas Vacacionales LG, Casa Corp Boutique Suites Condesa, Hugo Brauer Apartments, Hotel Boutique Emma, Maia Home, Suites Havre, Bamboo Skylife. No new bounces (checked Gmail delivery-failure notifications — only the same 3 from batch 2 exist). CRM: Estado → Contactado, Notas logged, Fecha de seguimiento 2026-08-10 on all 10.

29 leads remaining after this batch (excludes the "antonio" self-test record, which stays untouched).

**Note on Gmail's send capability:** Claude's Gmail MCP connector can create/update/manage drafts but has no send tool — sending has to happen from Antonio's side in Gmail directly. Draft-then-Antonio-sends is the actual working pattern, not a one-shot "send" flow.

### Sent (2026-08-05) — batch 4 of 54, 35 of 54 total
Rent A Kent, Hauzio, Otium PM, Casa Donceles, MD Rentals, HOMi, Casa Filomeno, Hostales Del Sur, Casai, DR Vacation Rental. No new bounces. CRM: Estado → Contactado, Notas logged, Fecha de seguimiento 2026-08-10 on all 10.

19 leads remaining after this batch (excludes "antonio" self-test record).

### Sent (2026-08-05) — batch 5 of 54, 45 of 54 total
The Local Way, Hotel Singular Mexico, ULIV Polanco, Virtual Homes, Kasava Homes, Lomah, FAIR Property Management, Host Me Tender, Oasis Collections, Stadia Suites. 1 new bounce:
- **Virtual Homes** (reservas@virtualhomes.mx) — address doesn't exist. Not yet followed up on another channel — flag for Antonio (no WhatsApp sent for this one like the batch-2 bounces).

Other 9 delivered fine. CRM: Estado → Contactado, Notas logged, Fecha de seguimiento 2026-08-10 (2026-08-07 for Virtual Homes).

8 leads remaining after this batch (excludes "antonio").

### Drafted, not yet sent (2026-08-05) — batch 6 (final) of 54, 53 of 54 total
HostPal, BADA MÉXICO, Anaxagoras 41 Suite, Mares Living, Suites Teca Once, MyPlace Leisure Homes, Mr Herold Homes, Espacio Hauzz By Eliana — in Gmail as drafts, waiting on Antonio to send. This is the last batch — every real lead (53 of 54, all except the "antonio" self-test record) will have a first-touch email drafted once these go out.

## Email 2 — follow-up (send ~4 días después, solo a quien no contestó)

Same subject line, sent as a reply in the same thread (`Re: ...`) — not a new cold email.

### Body
```
Hola de nuevo,

Sé que el correo se pierde fácil, solo quería asegurarme de que te llegó.

Si te late ver cómo se vería el video de {{Empresa}}, aquí está el ejemplo: https://projectkrato.com/recorridos

Cualquier duda, contesto rápido.

Antonio
```

## Notes

- Price is now stated plainly ("Desde $70 USD por video") instead of omitted — matches the brand's transparency principle, and on a first cold touch it pre-qualifies replies (no one replies just to ask "cuánto cuesta" and then goes quiet).
- Still two reply doors (email or WhatsApp), not the form — replying directly is lower-friction than a form for a first cold touch. The landing page (video + comparison table + pricing) is what closes the gap, not the email itself.
- Follow-up is deliberately short and low-pressure — no new pitch, just a bump. A third "break-up" email is a reasonable next add once we see real reply rates, not before.
- Not sending anything yet — this is copy for review before any real send.
