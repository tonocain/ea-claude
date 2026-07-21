<!-- Language rule: all file content in English. User communicates in Spanish; reply in Spanish, write files in English. -->
# BPMN Discovery Workflow

Five skills model, draw, and optimize a client's business processes using BPMN notation (`.claude/skills/discovery`, `bpmn-export`, `miro-bpmn`, `optimize`, `bpmn-xavier`). Each is a self-contained mode with a single responsibility — never mix their jobs. They self-trigger from natural language (see each skill's `description`).

Two separate pipelines — don't cross them:
- **Single named process** (e.g. "creación de contrato de arrendamiento"): `discovery` → `bpmn-export` and/or `miro-bpmn`.
- **Whole-area business audit** (Marketing, Ventas, Delivery, or Administración as a unit — maps to the KRATO "Know" phase): `bpmn-xavier`, self-contained — runs its own interview and never touches `discovery`'s output.

**Deliverables live in `WORKSPACE/[cliente]/`, not `projects/`.** `projects/` is for Antonio's own internal initiatives; `WORKSPACE/` is client discovery/BPMN work product, one subfolder per client:
```
WORKSPACE/[cliente]/
├── discovery-output.md                ← output of discovery
├── bpmn-[proceso]-[cliente].html      ← output of bpmn-export
└── bpmn-[area]-[cliente].html         ← output of bpmn-xavier
```

**Client identification:** before doing any work, determine which client folder inside `WORKSPACE/` the request belongs to. If unclear, ask in Spanish: "¿Para qué cliente o proyecto es esto?" If the folder doesn't exist, create it as part of the relevant skill's deliverable step.

**File chain (state awareness):** check for these before starting work, inside the relevant `WORKSPACE/[cliente]/` folder:
- `discovery-output.md` → if present, both `bpmn-export` and `miro-bpmn` should default to reading it instead of re-interviewing.
- Miro board state → if a board was created this session (via `miro-bpmn`), `optimize` should default to CONTINUATION mode over STANDALONE.

**Global rules across all 5 skills:**
- Never propose AI, automation, or specific tools while discovering, drawing, or optimizing — those are separate, later conversations Antonio will explicitly start.
- Always document the real process, not the idealized one.
- One skill's job is never absorbed into another. If asked to "also suggest improvements" mid-drawing, redirect to the `optimize` skill instead.
- If a request is ambiguous (board vs. HTML, named process vs. whole area), ask in Spanish which one is meant before proceeding — don't guess.
