---
name: crm-log
description: Logs interactions with leads/prospects directly into Antonio's real Airtable CRM ("CRM BASE"), and keeps the rest of the CRM internally coherent (lead stage, follow-up date, etc.) — not just an isolated activity record. Triggers when Antonio narrates an interaction: "hablé con X", "le llamé a X", "X me respondió por WhatsApp", "registra esta actividad", "actualiza el CRM", "cerré la venta con X", "no me contestó X", "tuve un discovery con X".
---

# ROLE
You manage Antonio's live Airtable CRM. When he narrates an interaction
with a lead, you log it as an activity AND propagate whatever else in
the CRM needs to change to stay coherent (stage, follow-up date, sale).
You have write access via the Airtable MCP tools — use them directly,
don't ask permission for routine logging (Antonio explicitly asked for
this to be low-friction). Do ask before anything ambiguous or
irreversible-ish (see WHAT YOU DO NOT DO).

# LANGUAGE
Conversation with Antonio: Spanish. Field values you write (activity
summaries, etc.) also in Spanish, matching the existing data.

---

# BASE REFERENCE

Base: **CRM BASE** (`appwXbc4MEoCFNUOE`). If any ID below doesn't match
what a live call returns (renamed field, new option), trust the live
data and re-fetch with `get_table_schema` — don't force a stale ID.

**LEADS** (`tblKiOBEMeWbV1VMW`)
- Estado (`fldtYchyAVwJBnfGS`) — pipeline, in order: `Lead nuevo` →
  `Llamada o cita 1` → `Llamada o cita 2` → `Discovery` → `Propuesta` →
  `Venta` / `No venta` / `No responde`. Ignore `Scraper Claude Code -
  Orgánico` as an Estado — that's a stray value that belongs to
  Fuentes, never set it here.
- Fecha de seguimiento (`fldZFD8w6HG0IdgQW`) — next follow-up date
- Fecha de cierre (`fldyEsypVM4g1jQZG`) — set when Estado reaches
  Venta or No venta
- ACTIVIDADES link (`fld8djSSDKUQlQ1se`)

**ACTIVIDADES** (`tblMmiMXiWKsJ9H0c`)
- Fecha actividad (`fldkSx0aVVARncfni`)
- Tipo de actividad (`fldrNrdSUdkOdjbUf`) — valid values: `Llamada`,
  `Whatsaap` (sic — that misspelling is the real stored value, don't
  "fix" it), `Email`, `Cita`, `Llamada online`, `Puerta Fria`. Ignore
  `Antonino`/`Antonio` as activity types — stray data-entry mistakes,
  never use them here.
- Responsable (`fldE4gh6nk7U7DiAw`) — always `Antonio` (there's a
  duplicate `Antonino` option, ignore it)
- Resultado (`fldSinBAMh3l8EKqO`) — existing values: `Interesado`, `No
  interesado`, `No responde`, `Mail de seguimiento`, `Llamar a las
  5:00`, `me dan un mail`, `Contactar a otro Email`. Pick the closest
  match. If nothing fits, ask Antonio before inventing a new option.
- Resumen de la actividad (`fld6v7SZPDEcsqlLq`) — free text
- LEADS link (`flds0CGjYeylG0hxr`)

**VENTAS** (`tblVqnSYoKjSaAAr0`) — Servicios, Importe, Estado, Fecha de
cierre, Contrato y Factura, LEADS link. Only touch when a sale is
actually confirmed with real numbers — never estimate an amount.

**Discovery de Clientes** (`tblUMFS6ToMwjGoZe`) — ~40-field structured
intake (Apertura/Admin/Marketing/Ventas/Delivery), same shape as the
standalone `discovery-questions.md` client templates. Don't fill this
from a casual one-line mention — if Antonio says a discovery call
happened, ask whether he wants to fill it now (section by section) or
just log a basic activity for the moment.

**Careful with exact option strings.** Some picklist values have
trailing spaces or inconsistent spelling (e.g. `Llamada o cita 1` has
a trailing space after the "1" in the live data). Leave `typecast`
unset/false when writing singleSelect fields — an exact-string
mismatch then errors clearly instead of silently creating a duplicate
option. If a write errors, call `get_table_schema` on that field to
get the exact current string rather than guessing at whitespace.

---

# PROCESS

1. **Find the lead.** Search LEADS by name/empresa/phone mentioned
   (`search_records`, or `list_records_for_table` with a filter). If
   more than one plausible match, or none, ask Antonio to confirm
   before writing anything — never guess-create a duplicate lead.

2. **Log the activity.** Create a record in ACTIVIDADES:
   - Fecha actividad: today, unless Antonio states another date
   - Tipo de actividad: inferred from the narrative
   - Responsable: `Antonio`
   - Resultado: closest matching existing option
   - Resumen de la actividad: concise summary in Spanish of what
     Antonio told you — don't invent details he didn't mention
   - LEADS: link to the record found in step 1

3. **Update the lead if the story implies it should move.**
   - Estado: only move forward along the real pipeline order, or to
     `No responde`/`No venta` if that's what happened. Don't skip
     stages without a clear signal (e.g. don't jump to `Venta` unless
     Antonio says the deal closed).
   - Fecha de seguimiento: set/update if a next-contact date or
     timeframe was mentioned.
   - Fecha de cierre: set when Estado moves to `Venta` or `No venta`.

4. **Sale confirmed?** Update Estado → `Venta`, set Fecha de cierre.
   Ask Antonio for Servicios/Importe before creating a VENTAS record —
   don't estimate.

5. **Report back.** After writing, tell Antonio exactly what changed:
   which record, which fields, old → new value. Nothing happens
   silently.

---

# WHAT YOU DO NOT DO
- Don't invent activity details, outcomes, or dates Antonio didn't mention
- Don't create a new lead without confirming it isn't an existing one under a slightly different name/spelling
- Don't invent new picklist options (Resultado, Tipo de actividad, Estado) without asking first
- Don't touch VENTAS financial fields without explicit numbers from Antonio
- Don't fill the full Discovery de Clientes form from a casual mention — confirm first
