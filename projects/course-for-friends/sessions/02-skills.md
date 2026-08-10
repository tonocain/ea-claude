<!-- Language note: written in Spanish (delivery language for the workshop) — same deviation as session 01, see note there. -->

# Sesión 2 — Skills

**Formato:** taller en vivo, cada quien sobre su propio proyecto/negocio (mismo del `CLAUDE.md` de la Sesión 1).
**Fuente principal:** vault `05-claude-code.md`, Subtema 2 — Skills (material de Tribu Divisual).

## Estructura (outline confirmado, 2026-07-27)

1. Qué es una skill y para qué sirve
2. Anatomía de un `SKILL.md`
3. Local vs Global — dónde viven y cómo se instalan
4. Cómo decide Claude cuándo usarla (+ carga progresiva de contexto)
5. Framework de 6 pasos para construir tu propia skill
6. El ciclo de feedback
7. Hands-on de cierre — cada quien construye su primera skill real

---

## 1. Qué es una skill y para qué sirve

Claude Code olvida todo entre conversaciones — cada vez que lo abres, empieza desde cero (salvo lo que ya quedó permanente en el `CLAUDE.md` de la Sesión 1). Una **skill** resuelve un problema distinto: es un archivo de texto con instrucciones permanentes para una tarea o proceso específico — no todo tu contexto general, sino "así se hace esto".

**Analogía para la sesión:** sin skill = empleado nuevo que olvida todo cada día. Con skill = empleado que tiene el manual de esa tarea puntual en la mesa y lo consulta cada vez que la hace.

**Los 3 usos:**
- **Consistencia** — le comunicas tu framework, tono, o estilo de código preferido para ese tipo de tarea.
- **Automatizar workflows** — guarda instrucciones de tareas repetitivas (cómo crear cierto tipo de archivo, cómo documentar algo).
- **Conocimiento del proyecto** — documenta reglas propias de un proceso para que Claude las recuerde siempre que lo repita.

**Diferencia con el `CLAUDE.md` de la Sesión 1 (aclarar en vivo):** el `CLAUDE.md` se lee siempre, en cada mensaje — es el "quién eres". Una skill se carga solo cuando la tarea la necesita — es el "así se hace X". Las skills son **opcionales**: no las necesitas para empezar (ya lo comprobaron en la Sesión 1 sin ninguna instalada), pero son el siguiente paso natural en cuanto se descubren repitiendo el mismo proceso una y otra vez.

---

## 2. Anatomía de un `SKILL.md`

Un `SKILL.md` tiene dos partes:

1. **Front matter (YAML)** — entre líneas `---`. Es lo único que Claude Code lee en la primera pasada, para decidir si esta skill aplica (~100 tokens, no el archivo completo). `name` y `description` son **obligatorios** — le dicen a Claude cómo se llama la skill y cuándo usarla. Campos opcionales para casos avanzados: `disable-model-invocation` (la skill solo se dispara por `/comando`, nunca sola por lenguaje natural), `allowed-tools`, `argument-hint`, `model`, `hooks`, `agent`.
2. **Instrucciones paso a paso** — el cuerpo en markdown. Es lo que Claude ejecuta una vez decide que esa es la skill correcta.

**Ejemplo mínimo para mostrar en vivo:**
```markdown
---
name: seguimiento-cliente
description: Redacta un mensaje de seguimiento para un cliente que no ha respondido en X días. Úsala cuando pidan "mándale seguimiento a [cliente]" o "recuérdale a [cliente]".
---

1. Pregunta hace cuántos días fue el último contacto si no se especifica.
2. Redacta un mensaje corto (máx. 3 frases), tono profesional pero cercano.
3. Nunca prometas descuentos ni fechas de entrega sin que el usuario las confirme.
```

**Regla oficial:** mantener el `SKILL.md` por debajo de **500 líneas** — si necesita más, ese material de referencia detallado se mueve a archivos aparte.

**Self-contained vs. archivos externos** — cuando una skill necesita más contexto (tono de marca, un script, una lista de datos), ese material extra puede vivir en dos sitios:
- **Self-contained:** todo bajo la misma carpeta de la skill (`SKILL.md` + `scripts/` + `references/` juntos).
- **Separado:** los scripts/referencias viven en otra parte del proyecto y el `SKILL.md` los referencia por ruta — útil cuando varias skills comparten los mismos archivos.

Los scripts que puede ejecutar una skill normalmente son **Python o JS**.

---

## 3. Local vs Global — dónde viven y cómo se instalan

### ¿Dónde viven?

```
tu-proyecto/
└── .claude/
    └── skills/
        └── nombre-de-la-skill/
            └── SKILL.md
```

La carpeta `.claude` se crea sola al instalar la primera skill. Claude Code la revisa cada vez que abres el proyecto — no hace falta activar nada a mano.

### ¿Local o global?

| | Local (un proyecto) | Global (todos los proyectos) |
|---|---|---|
| **Carpeta** | `tu-proyecto/.claude/skills/` | `~/.claude/skills/` |
| **Cuándo usarla** | Reglas de ese proyecto específico: ese cliente, esas tecnologías. | Hábitos tuyos de siempre: idioma, estilo, preferencias generales — aplican en cualquier proyecto que abras. |

**Ejemplo para la sesión:** si alguien trabaja con dos negocios distintos (dos carpetas de proyecto separadas), una skill de "cómo redacto propuestas" puede ir global si la usan igual en los dos; una skill de "cómo se factura en este negocio específico" va local, solo en esa carpeta.

### ¿Cómo se instala?

- **Opción A — Terminal:**
  ```bash
  claude skill install nombre.skill          # local
  claude skill install --global nombre.skill # global
  ```
- **Opción B — VS Code:** ícono ✦ → escribir `/plugins` → panel de gestión.
- **Opción C — Lenguaje natural (la más fácil, recomendada para hoy):**
  - *"Instala esta skill de forma global para todos mis proyectos"*
  - *"Instala esta skill solo en este proyecto"*

---

## 4. Cómo decide Claude cuándo usarla (+ carga progresiva de contexto)

### Dos formas de disparar una skill

- **Explícita:** slash command con el nombre (ej. `/seguimiento-cliente`) → dispara esa skill directo, sin ambigüedad.
- **Lenguaje natural:** ej. *"mándale seguimiento a Juan"* → Claude lee el `CLAUDE.md`, analiza la petición y busca entre las skills instaladas cuál encaja (comparando contra el `description` de cada una). Si encuentra una que aplica, la invoca; si no, responde con su conocimiento general. **No toda petición dispara una skill** — solo cuando el `description` de alguna coincide con lo que se pidió.

**Por qué importa esto para el hands-on de hoy:** el `description` que le pongan a su skill es lo único que decide si se dispara sola o no. Un `description` vago = la skill nunca se activa por lenguaje natural, solo por slash command.

### Carga progresiva de contexto — por qué no gasta tokens de más

Con muchas skills instaladas, leer el contenido completo de todas en cada mensaje sería carísimo. Por eso Claude Code carga en 3 niveles:

| Nivel | Qué lee | Cuándo | Costo aprox. |
|---|---|---|---|
| **1 — Búsqueda inicial** | Solo `name` + `description` de **todas** las skills instaladas. | Siempre, para decidir cuál encaja. | ~100 tokens por skill. |
| **2 — Ejecución** | El `SKILL.md` completo de la skill elegida. | Solo una vez identificada la correcta. | ~1,000–2,000 tokens. |
| **3 — Archivos extra** | Scripts, referencias, plantillas, assets. | Solo si el paso concreto los necesita. | Variable. |

**El punto para la sesión:** pueden tener 20 skills instaladas sin que eso encarezca cada mensaje — Claude solo "abre" la que realmente necesita.

---

## 5. Framework de 6 pasos para construir tu propia skill

Este es el framework que van a usar en el hands-on de cierre, aplicado a su propio proyecto:

1. **Nombre y trigger** — cómo se llama y qué frase en lenguaje natural la debería disparar.
2. **Objetivo** — en una frase: ¿qué logra la skill y cuál es el output final?
3. **Proceso paso a paso** — si lo hicieras a mano, ¿qué harías, en qué orden, qué mirarías, qué decisiones tomarías? Esto es lo que va en el cuerpo del `SKILL.md`.
4. **Archivos de referencia** — ¿qué contexto extra hace falta? (guía de marca, datos del proyecto, plantillas, prioridades actuales).
5. **Reglas** — ¿qué puede salir mal? ¿qué guardrails hacen falta? (ej. "nunca prometas descuentos sin confirmar").
6. **Ciclo de auto-mejora** — cómo se va a ir afinando con el uso (desarrollado a fondo en el Punto 6 de hoy).

**Atajo a mencionar:** existe una skill oficial llamada `skill-creator` que automatiza este mismo framework — va haciendo estas 6 preguntas y construye el `SKILL.md` por ti. Útil para quien quiera ir más rápido en el hands-on, pero vale la pena que la primera vez lo piensen ellos mismos punto por punto, para que entiendan qué está pasando por debajo.

---

## 6. El ciclo de feedback

**Ninguna skill sale perfecta a la primera** — hay que dejarlo clarísimo antes del hands-on para que nadie se frustre en el primer intento.

El proceso normal: **invocar → observar cómo trabaja el agente → dar feedback → el agente ajusta el `SKILL.md` → repetir.** Las primeras veces conviene quedarse mirando la ejecución completa — así se detectan pasos que se pueden dejar fijos de una vez (ej. si la skill siempre busca el mismo dato, se guarda directo en el `SKILL.md` en vez de recalcularlo cada vez). Después de 10-30 ejecuciones con ajustes, el resultado se vuelve consistente.

**Cuándo crear una skill, en el día a día después del curso:** cuando se descubran repitiendo el mismo proceso, o corrigiendo a Claude siempre de la misma forma (ej. "no uses guiones largos"). No hace falta que sea compleja — puede ser un `.md` de 50 líneas.

### Testing y debugging: síntoma → fix

Tabla para tener a la mano durante el hands-on — cuando algo no salga como esperan, buscar aquí primero:

| Síntoma | Fix |
|---|---|
| Hace los pasos mal o en el orden equivocado | Editar las instrucciones del `SKILL.md`. |
| Falta tono, estilo o contexto | Añadir un archivo de referencia (y apuntarlo bien desde el `SKILL.md`). |
| Comete el mismo error una y otra vez | Añadir una regla explícita. |
| No se dispara cuando debería | Revisar el YAML — el `description` no es lo bastante específico. |
| Se dispara demasiado seguido sin que lo pidan | Considerar `disable-model-invocation` para que solo se dispare por `/comando`. |
| Funciona bien pero podría mejorar | No hay atajo — hay que iterar: ejecutar, observar, afinar. |

---

## 7. Hands-on de cierre — cada quien construye su primera skill real

Sobre el mismo proyecto de la Sesión 1 (el que ya tiene `CLAUDE.md`).

1. **Identificar la tarea:** pensar en algo que hacen más de una vez en su negocio/proyecto — un tipo de mensaje, un formato de reporte, un proceso con pasos fijos.
2. **Planearla con el framework de 6 pasos** (Punto 5) — nombre/trigger, objetivo, proceso paso a paso, archivos de referencia si aplica, reglas.
3. **Construir el `SKILL.md`** — pedírselo a Claude Code en lenguaje natural con lo planeado en el paso 2, o usar `skill-creator` si quieren ir más rápido.
4. **Decidir local o global** (Punto 3) — ¿es específica de este proyecto o la van a querer en todos?
5. **Probarla en vivo** — invocarla, observar la ejecución completa, dar al menos una ronda de feedback real y dejar que Claude ajuste el `SKILL.md` (Punto 6). No basta con que exista — tiene que haberse corregido al menos una vez en la sesión.

**Entregable de la sesión:** primera skill real instalada, sobre su propio proyecto, probada y ajustada al menos una vez en vivo.

---

## Sesión 2 — completa (2026-07-27)

Los 7 puntos están redactados en `sessions/02-skills.md`. Duración estimada: ~100-110 min (6 puntos conceptuales ~50-55 min + hands-on con al menos una ronda de iteración real ~50-55 min — el hands-on de skills tarda más que el de la Sesión 1 porque incluye probar y corregir, no solo instalar y escribir).
