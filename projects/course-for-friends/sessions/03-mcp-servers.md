<!-- Language note: written in Spanish (delivery language for the workshop) — same deviation as sessions 01-02, see note there. -->

# Sesión 3 — MCP Servers

**Formato:** taller en vivo, cada quien sobre su propio proyecto/negocio.
**Fuente principal:** vault `14-mcp-servers.md` (material de Tribu Divisual/Nate Herk) + `.claude/skills/miro-bpmn/` de este mismo repo como ejemplo real y en vivo.

## Estructura (outline confirmado, 2026-07-27)

1. Qué es un MCP server
2. MCP vs Skills — con `miro-bpmn` como ejemplo real
3. Setup general — cómo se conecta cualquier MCP server
4. Las tools de Miro, agrupadas
5. El patrón cheat sheet
6. Self-healing en acción (con la regla real de `miro-bpmn`)
7. Hands-on de cierre — conectar un MCP relevante a su proyecto + mini skill

---

## 1. Qué es un MCP server

Por defecto, Claude Code solo puede trabajar con archivos en tu computadora — no puede tocar nada fuera de esa carpeta. Un **MCP (Model Context Protocol) server** es lo que extiende esa capacidad hacia afuera: un puente entre Claude Code y un servicio externo (una API, una base de datos, un board de Miro, lo que sea).

**Analogía para la sesión:** piénsalo como un app store, o como el puerto USB-C universal — en vez de tener que aprenderte un cable distinto (una integración distinta) para cada servicio, te conectas una vez al "puerto" y de ahí en adelante el agente sabe qué hacer con lo que sea que conectaste.

**Mecánica, en 2 pasos:**
1. **Instalas el servidor MCP una vez** y le das tu API key o credenciales — normalmente vía un archivo `.env`, **nunca pegada directo en el chat**.
2. **A partir de ahí, Claude Code puede usar ese servicio cuando lo necesite.** No eliges tú qué endpoint llamar ni armas la petición a mano — el agente lee las herramientas (`tools`) que expone el servidor MCP y decide sola cuál invocar según lo que le pediste.

---

## 2. MCP vs Skills — con `miro-bpmn` como ejemplo real

Dos formas distintas de darle capacidades extra a Claude Code, fáciles de confundir — y hoy hay un ejemplo real, corriendo en este mismo repo, para verlo en vivo: la skill `miro-bpmn`.

| | MCP server | Skill |
|---|---|---|
| **Qué hace** | Trae datos y ejecuta acciones sobre un servicio externo real. | Da conocimiento e instrucciones — cómo hacer algo. No toca nada fuera de tus archivos por sí misma. |
| **Se activa** | El agente lee las tools que expone el servidor y decide sola cuál invocar. | Claude Code revisa qué skills tiene instaladas y carga la que encaje con la petición. |
| **En `miro-bpmn`** | El **MCP de Miro** — tools como `layout_create`, `layout_read`, `layout_update`, `board_create` — son las que de verdad dibujan figuras en un board real y visible. | El **`SKILL.md` de `miro-bpmn`** — 6 pasos: localizar el `discovery-output.md`, analizar fases/tareas/gateways, pedir el board, construir el DSL, crear en Miro, validar con el usuario. Puro proceso, ni una sola figura se dibuja desde aquí. |

**El momento "ahá" para la sesión:** cuando alguien dice *"dibuja el BPMN de [cliente] en Miro"*, Claude Code carga la skill `miro-bpmn` porque su `description` encaja con la petición — la skill es el cerebro que decide **qué** dibujar y **en qué orden**. Pero la skill por sí sola no puede tocar Miro: en el Paso 5 (Crear en Miro), le pasa el trabajo al MCP de Miro, que es quien realmente ejecuta `layout_create` y hace aparecer las figuras en el board. **Skill = cómo. MCP = manos.**

**Cuándo usar cuál, la regla simple:** ¿necesitas que el agente toque algo fuera de sus archivos locales (un board, un email, una base de datos)? MCP. ¿Te encuentras repitiéndole lo mismo una y otra vez sobre cómo hacer algo? Skill.

---

## 3. Setup general — cómo se conecta cualquier MCP server

Mismos 4 pasos sin importar cuál sea el servicio (Miro, Gmail, Airtable, lo que sea):

1. **Crear un `.env`** en el proyecto para guardar la API key.
2. **Pedirle a Claude Code que instale/conecte el servidor MCP** — cada servicio publica su propio comando de instalación en su documentación (buscar "[nombre del servicio] MCP server" o "running on Claude Code").
3. **Pegar la API key** (sacada del dashboard del servicio) en el `.env` y guardar. **Nunca se pega la key directo en el chat.**
4. **Recargar la ventana** (`Cmd/Ctrl+Shift+P` → "Developer: Reload Window") para que Claude Code reconozca el nuevo servidor MCP.

**Nota para la sesión:** Miro ya está conectado en este entorno (por eso `miro-bpmn` funciona sin configurar nada hoy) — no hace falta montarlo en vivo para el ejemplo. Pero cada quien va a necesitar pasar por estos 4 pasos en el hands-on de cierre, con el MCP que le sirva a su propio negocio.

---

## 4. Las tools de Miro, agrupadas

El MCP de Miro conectado en este entorno expone **más de 30 tools** — mucho más que el ejemplo de 5 tools de Firecrawl que documenta el vault. Agrupadas por categoría:

| Categoría | Tools de ejemplo | Para qué |
|---|---|---|
| **Boards** | `board_create`, `board_search_boards`, `board_list_items` | Crear un board nuevo, buscar uno existente, listar qué hay dentro. |
| **Layout / diagramas** ⭐ | `layout_create`, `layout_read`, `layout_update`, `layout_get_dsl` | Dibujar y editar figuras/conectores en un board — **las que usa `miro-bpmn`**. |
| **Documentos** | `doc_create`, `doc_get`, `doc_update` | Crear y editar documentos dentro de Miro. |
| **Tablas** | `table_create`, `table_sync_rows`, `table_list_rows` | Tablas de datos dentro de un board. |
| **Imágenes** | `image_create`, `image_get_url` | Subir o insertar imágenes. |
| **Prototipos** | `prototype_create` | Prototipos interactivos. |
| **Comentarios** | `comment_create`, `comment_list_comments` | Dejar y leer comentarios en el board. |

**El punto para la sesión:** `miro-bpmn` no usa las 30+ tools — solo necesita 4-5 del grupo de layout, más `board_create` cuando hace falta un board nuevo. Una skill bien enfocada no tiene que dominar todo lo que el MCP ofrece, solo la porción que su tarea específica necesita.

---

## 5. El patrón cheat sheet

Cuando un MCP expone varias tools (como Miro con sus 30+), ayuda pedirle a Claude que genere un **cheat sheet** en markdown dentro del proyecto: qué tools hay disponibles y cuándo usar cada una, con el detalle técnico necesario. Le da a Claude Code una referencia rápida para acertar a la primera en vez de ir descubriendo a prueba y error.

**Ejemplo real — `miro-bpmn/reference.md`:** no es teoría, es el archivo que ya existe en este repo. Contiene, entre otras cosas:
- **Qué tool usar y cuál NO** — `layout_create` sí, `diagram_create` no (ese solo sirve para flowchart/uml/erd genéricos, sin vocabulario para BPMN con colores de fase).
- **Constantes de layout exactas** — distancias entre nodos, alturas de fila, tamaños de figura — para que cada diagrama salga con la misma proporción sin que Claude las tenga que inventar cada vez.
- **Reglas aprendidas en producción** — errores reales que ya pasaron y cómo evitarlos, para no repetirlos.

**Por qué se mantiene separado del `SKILL.md` / `CLAUDE.md`:** el `SKILL.md` de `miro-bpmn` se queda corto y legible (los 6 pasos del proceso) y solo **apunta** al `reference.md` para el detalle técnico pesado. Mismo criterio de "contexto mínimo necesario" que ya vieron con el `CLAUDE.md` en la Sesión 1 — no todo tiene que vivir en el mismo archivo.

---

## 6. Self-healing en acción — la regla real de `miro-bpmn`

El vault documenta self-healing con un ejemplo de Firecrawl (un `extract` que devolvió vacío, el agente lo detectó y cambió de estrategia solo, en el momento). Hoy usamos un ejemplo distinto, más concreto: una regla que ya está escrita en `miro-bpmn/SKILL.md` para cuando falla la llamada al MCP de Miro.

**La situación:** `layout_create` recibe el diagrama completo en una sola llamada — shapes, texto, conectores, todo junto. Si un solo parámetro está mal (ej. una figura con `size < 10`), el MCP rechaza **todo el lote** con un error HTTP 400 — no dice cuál de los 20-30 elementos fue el culpable.

**La regla:** en vez de reintentar a ciegas o rendirse, **bisectar** — partir el lote a la mitad, reenviar cada mitad por separado para ver cuál falla, y repetir sobre la mitad culpable hasta aislar el elemento exacto. La skill incluso anota de antemano dónde suele estar el problema ("casi siempre es un `size` chico en un gateway"), porque ya pasó antes.

**Dos sabores de self-healing, para que quede claro:**
- **En el momento** (el ejemplo de Firecrawl del vault) — el agente descubre el problema y decide cómo resolverlo ahí mismo, improvisando.
- **Pre-escrito en la skill** (este ejemplo) — alguien ya vivió ese error una vez, y en vez de que el agente lo vuelva a improvisar cada vez, la solución quedó anotada en el `SKILL.md`/`reference.md` para la próxima. **Esto es literalmente el ciclo de feedback de la Sesión 2** en acción: la skill se afinó después de un fallo real.

---

## 7. Hands-on de cierre — MCP + mini skill, mismo patrón que `miro-bpmn`

Sobre el mismo proyecto de las Sesiones 1 y 2.

1. **Identificar el servicio externo** que les serviría tocar de verdad (Gmail, Airtable, Google Calendar, su CRM — lo que ya usen en su negocio).
2. **Conectarlo como MCP** siguiendo los 4 pasos del Punto 3.
3. **Explorar sus tools** — pedirle a Claude Code que liste qué puede hacer ese MCP, igual que se vio con Miro en el Punto 4.
4. **Construir una mini skill** que lo use — aplicando el framework de 6 pasos de la Sesión 2, sobre una tarea puntual de su negocio. Mismo patrón que `miro-bpmn`: la skill decide el cómo, el MCP pone las manos.
5. **Probarla en vivo** — tiene que producir un resultado real y visible (un email de verdad, una fila real en una hoja, lo que sea), no solo texto describiendo lo que haría.
6. **Si algo falla:** aplicar el Punto 6 — diagnosticar antes de rendirse, y anotar la solución en el `SKILL.md` para la próxima vez.

**Entregable de la sesión:** un MCP conectado + una mini skill que lo usa, probada en vivo con un resultado real, sobre su propio negocio.

---

## Sesión 3 — completa (2026-07-27)

Los 7 puntos están redactados en `sessions/03-mcp-servers.md`. Duración estimada: ~95-110 min (6 puntos conceptuales ~45-50 min + hands-on con conexión de MCP real + construcción y prueba de skill ~50-60 min — el paso de conectar el MCP correcto de cada quien puede variar bastante en tiempo según el servicio).
