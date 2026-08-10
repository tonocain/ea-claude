<!-- Language note: written in Spanish (delivery language for the workshop), not English — deviates from the repo default because this is spoken-aloud session content for Spanish-speaking friends, same logic as client-facing deliverables in WORKSPACE/. -->

# Sesión 1 — Mentalidad + Fundamentos de Claude Code

**Duración:** ~95 min
**Formato:** taller en vivo, cada quien sobre su propio proyecto/negocio.

---

## Apertura del taller — "Master Claude"

**Para decir en vivo, al arrancar la Sesión 1, antes de entrar a la Parte 1.**

"Este taller se llama **Master Claude** y son 6 sesiones:"

1. **Mentalidad + Fundamentos de Claude Code**
2. **Skills**
3. **MCP Servers**
4. **Automatización Clásica**
5. **Agentic Workflows (WAT)**
6. **Capstone — construye tu propio Asistente Ejecutivo (EA)**

"Hoy, en la Sesión 1, vamos a ver:"

- **Parte 1 — Introducción a la IA general:** qué es un LLM, qué resuelve bien, dónde se queda corto (con una demo en vivo), ChatGPT vs Claude, y por qué este taller usa el ecosistema de Claude específicamente.
- **Parte 2 — Claude Cowork:** qué es y para qué sirve (solo se explica, no hay hands-on hoy).
- **Parte 3 — Claude Code:** instalación en VS Code, la interfaz, los modos de trabajo, por qué el contexto lo es todo, y el hands-on: cada quien instala Claude Code y escribe su primer `CLAUDE.md` sobre su propio proyecto.
- **Cierre:** comparando los 3 niveles que vimos hoy — LLM de chat, Cowork y Claude Code.

---

## Estructura (3 partes)

1. Introducción a la IA general (ChatGPT, Claude, etc.) — qué resuelve y dónde se queda corto.
2. Introducción a Claude Cowork.
3. Claude Code — instalación en VS Code y forma de trabajar.

> Partes 1 y 2 son contenido redactado por Claude (EA), no sacado de `curso-docs` — no hay fuente del curso Tribu Divisual sobre esto. Marcado así para no confundirlo con el resto del material.

---

## Parte 1 — Introducción a la IA general

Outline confirmado (2026-07-27):
1. Qué es un LLM
2. Qué resuelve bien
3. Dónde se queda corto
4. ChatGPT vs Claude
5. Por qué este curso usa Claude/Claude Code específicamente

### 1. Qué es un LLM

Un modelo de lenguaje (LLM, *Large Language Model*) es un sistema entrenado con cantidades enormes de texto para predecir cuál es la continuación más probable de lo que le estás pidiendo — palabra por palabra, pero a una escala donde el resultado se siente como razonamiento.

**Analogía para la sesión:** es como el autocompletado del teléfono, pero llevado al extremo — no completa la siguiente palabra de un mensaje, completa párrafos enteros, código, un análisis completo, porque "vio" patrones de una fracción enorme de todo lo que se ha escrito.

**Punto importante a aclarar en vivo:** no "sabe" cosas en el sentido humano ni consulta una base de datos en tiempo real por defecto — genera la respuesta estadísticamente más probable dado el patrón de su entrenamiento. Esto explica por adelantado por qué en el punto 3 (dónde se queda corto) puede "alucinar" con total seguridad.

**Demo en vivo — fecha de corte (definida por Antonio):** en la sesión, sacar el teléfono y preguntarle a ChatGPT, **con la búsqueda web desactivada**, "¿cómo murió Charlie Kirk?" — un evento real y reciente que ocurrió después de la fecha de corte de varios modelos. Sin acceso a web, el modelo solo puede responder con lo que tenía en su entrenamiento: puede no saberlo, dar información desactualizada, o alucinar una respuesta seguro de sí mismo. Ahí se ve en vivo, sin que nadie lo explique, la diferencia entre "el modelo sabe" y "el modelo tiene web search prendido".

**Nota para Antonio:** confirmar justo antes de la sesión que sigue sin búsqueda por defecto en la app de ChatGPT que vayas a usar (algunas versiones la activan automático) — si se activa sola, el experimento no muestra el límite que quieres enseñar.

---

### 2. Qué resuelve bien

Un LLM es fuerte en tareas de **lenguaje y patrones** — generar, transformar y conectar texto e información de forma coherente. No es una calculadora ni un buscador de hechos verificados; es un motor de lenguaje.

Dónde brilla, en la práctica:
- **Redacción y reescritura** — emails, propuestas, mensajes, ajustar tono para distintas audiencias.
- **Resumir** — condensar documentos largos, transcripciones, artículos.
- **Investigar y sintetizar** — juntar y organizar información dispersa (mejor todavía con búsqueda web activada).
- **Programar** — escribir, explicar y depurar código.
- **Analizar** — encontrar patrones, comparar opciones, estructurar una decisión.
- **Brainstorming** — generar variantes y ángulos que no se te habían ocurrido.

**Demo en vivo:** pedirle ahí mismo, frente al grupo, que redacte 2-3 variantes de un mensaje real de uno de los presentes (ej. un mensaje de seguimiento a un cliente, un post para su negocio) — que vean el "resuelve bien" con un caso suyo, no con un ejemplo genérico. Conecta directo con el hands-on de la Parte 3 (cada quien trabaja su propio proyecto).

---

### 3. Dónde se queda corto

Ya lo vieron con sus propios ojos en la demo del Punto 1 (Charlie Kirk sin web search) — aquí se nombran las limitaciones de fondo detrás de ese resultado:

- **Alucina con seguridad** — cuando no sabe algo, muchas veces no dice "no sé": inventa una respuesta que suena igual de segura que una correcta. La demo del Punto 1 es el ejemplo en vivo de esto.
- **Fecha de corte de conocimiento** — todo lo que pasó después de que se entrenó el modelo, no lo sabe (salvo que tenga búsqueda web conectada).
- **Sin memoria por defecto entre conversaciones** — cada chat nuevo empieza de cero. No recuerda lo que hablaron ayer a menos que la herramienta tenga memoria activada explícitamente.
- **No ejecuta acciones reales por sí solo** — no manda un email, no toca un archivo, no agenda nada. Solo genera texto, a menos que esté conectado a herramientas que sí puedan actuar.
- **El resultado depende de qué tan bien le expliques lo que quieres** — input vago, output genérico. Esto no es una limitación técnica del modelo, es la más importante de controlar, porque es la única de esta lista que depende 100% de ti.

**El gancho hacia la Parte 3:** ese último punto — "no ejecuta acciones reales" — es exactamente lo que Claude Code resuelve. Deja de ser solo un chat que te contesta, y pasa a ser un agente que sí puede tocar archivos, instalar cosas, correr comandos y conectarse a herramientas reales. Ahí arranca la Parte 3.

---

### 4. ChatGPT vs Claude

No es "cuál es mejor" en abstracto — es para qué sirve cada uno mejor, en la práctica:

| | ChatGPT (OpenAI) | Claude (Anthropic) |
|---|---|---|
| **Adopción** | Más mainstream, más gente ya lo conoce y lo usa a diario. | Menos conocido fuera de círculos técnicos, aunque está creciendo. |
| **Fuerte en** | Uso general del día a día: multimodal (imagen, voz), ecosistema amplio de plugins/integraciones. | Programar y trabajar de forma agéntica — ejecutar tareas de varios pasos, no solo contestar. Claude Code (Parte 3) es su producto insignia para esto. |
| **Ventanas de contexto** | Amplias. | Históricamente entre las más grandes del mercado — bueno para leer documentos largos o bases de código completas de un jalón. |
| **Estilo de escritura** | Percepción variable según versión. | Muchos usuarios lo describen como más natural, menos "se nota que es IA" — pero es subjetivo y cambia con cada versión, no es un hecho fijo. |
| **Acceso a Claude Code** | No aplica. | Necesitas un plan pagado de Claude (Pro cubre lo básico; Max si vas a automatizar mucho y no quieres toparte con límites). |

**Nota importante para la sesión:** no hay que venderlo como "Claude es mejor, punto". Es honesto decir que para uso general del día a día, ChatGPT tiene más alcance y ecosistema. La razón concreta por la que este curso usa Claude es la del Punto 5 — no es una preferencia de marca.

---

### 5. Por qué este curso usa Claude — las herramientas del ecosistema

La razón real no es una preferencia de marca ni un argumento abstracto — es que Claude no es una sola herramienta, es un ecosistema donde el mismo modelo trabaja sobre distintas superficies:

| Herramienta | Qué hace | Para qué la usarían |
|---|---|---|
| **Claude Code** (Parte 3 de hoy) | Agente que trabaja en tu código/proyectos desde VS Code o terminal: lee archivos, ejecuta comandos, se conecta a herramientas externas. | El núcleo de las sesiones 2-6: skills, MCP, automatización, capstone. |
| **Claude Cowork** | Claude trabajando directo sobre tus archivos, carpetas y apps de oficina — no es chat, es una sesión de trabajo: le describes la tarea, la planea, la ejecuta, tú diriges sobre la marcha. Se extiende a Chrome, Word, Excel, PowerPoint, Outlook. | Automatizar trabajo de oficina sin tocar código — para quien no quiere abrir VS Code. |
| **Claude Design** | Producto de Anthropic Labs (en research preview) para crear trabajo visual junto con Claude: prototipos, wireframes, decks, mockups. Corre sobre Claude Opus 4.7 (modelo con visión). Un wireframe hecho aquí se puede pasar directo a Claude Code para construirlo. | Founders/marketers sin fondo de diseño que necesitan un pitch deck, mockup o material de marketing rápido. |

**El punto real:** no son tres productos que compiten entre sí — son la misma inteligencia aplicada a tres superficies de trabajo distintas, y se conectan entre sí (ej. Design → wireframe → Claude Code lo construye). Ningún otro ecosistema conecta código, trabajo de oficina y diseño visual bajo la misma herramienta. Esa es la razón concreta, no de marketing.

**Fuentes (contenido no sacado de Tribu Divisual, investigado vía Firecrawl):**
- Cowork — [Anthropic Academy, "Introduction to Claude Cowork"](https://anthropic.skilljar.com/introduction-to-claude-cowork)
- Design — [Anthropic, "Introducing Claude Design by Anthropic Labs"](https://www.anthropic.com/news/claude-design-anthropic-labs)

---

## Parte 1 — cerrada (2026-07-27)

---

## Parte 2 — Claude Cowork

> **Nota de fuente:** contenido investigado vía Firecrawl (no es material de Tribu Divisual). Fuente: [Anthropic Academy, "Introduction to Claude Cowork"](https://anthropic.skilljar.com/introduction-to-claude-cowork).

### Qué es

Cowork es Claude trabajando directo sobre tus archivos, carpetas y apps — leyendo, editando y produciendo resultados reales en tu máquina. La diferencia con el Chat normal: **Chat es una conversación, Cowork es una sesión de trabajo** — le describes la tarea, Claude la planea y la ejecuta, y tú vas dirigiendo sobre la marcha (parar, corregir, aprobar) en vez de solo recibir texto de vuelta.

### Qué cubre en la práctica

- Configurar Cowork con una carpeta de trabajo, conectores y permisos.
- Correr una tarea de principio a fin — aclarar lo que quieres, dirigir a medio camino, revisar el entregable final.
- Darle contexto permanente: instrucciones globales, proyectos, skills y plugins (mismo concepto de skill que van a ver en la Sesión 2, aplicado aquí a Cowork en vez de a Claude Code).
- Tareas programadas (scheduled tasks) y **Dispatch** para trabajo recurrente.
- Se extiende al navegador (Claude in Chrome) y a Word, Excel, PowerPoint, Outlook.

### Por qué importa para el curso

Es la versión "para cualquiera" de lo que Claude Code es para desarrolladores — mismo principio agéntico (planea, ejecuta, se autocorrige, tú lo diriges), pero apuntado a documentos de oficina y navegador en vez de a una carpeta de código. La mentalidad que van a aprender hoy con Claude Code (Partes 1 y 3: cómo pedir bien, contexto, plan mode) se traduce directo a Cowork si algún día prefieren trabajar ahí en vez de VS Code.

**Dato de conexión con sesiones futuras:** Scheduled Tasks (que se retoma, ligero, en la Sesión 6 — Capstone) salió primero en Cowork y de ahí pasó a Claude Code — mismo motor por debajo.

**Alcance en esta sesión:** solo se menciona y se explica — no se instala ni se hace hands-on con Cowork hoy. El hands-on de la Sesión 1 es 100% Claude Code (Parte 3). Si alguien ya tiene plan Pro/Max y quiere explorarlo por su cuenta, se le puede pasar el link del curso de Anthropic Academy arriba.

---

## Parte 3 — Claude Code: instalación en VS Code y forma de trabajar

> **Fuente:** `claude-code-36min-transcript.md` ("Master 95% of Claude Code in 36 Mins", Nate Herk) + `05-claude-code.md` del vault.

### Instalación

1. Descargar VS Code (gratis) — buscar "VS Code" en Google, descargar, instalar.
2. Dentro de VS Code: ícono de Extensiones (barra izquierda) → buscar "Claude Code" → Instalar.
3. Iniciar sesión con la cuenta de Anthropic.
4. **Requiere plan pagado de Claude** para usar Claude Code — Pro (~$17/mes) alcanza para empezar. Si van a automatizar mucho durante el curso, Max evita toparse con límites de uso, pero se puede arrancar en Pro y subir después.
5. Clic en el ícono de Anthropic (arriba a la derecha) → se abre el panel de Claude Code.

### La interfaz

- **Izquierda = Explorer (archivos)** — aquí vive el proyecto: carpetas, código, el `CLAUDE.md`.
- **Derecha = el agente** — panel tipo chat donde le hablas a Claude Code, parecido a la interfaz de ChatGPT.
- Claude Code **siempre trabaja dentro de una carpeta/proyecto abierto** — si no has abierto una carpeta, te lo pide antes de dejarte hacer nada.
- Se pueden tener varios paneles de Claude Code abiertos a la vez (ej. uno por tarea), aunque para empezar basta con uno.

### Cómo trabaja — los modos

Claude Code tiene distintos modos de permiso, seleccionables en la parte inferior del panel:

| Modo | Qué hace | Cuándo usarlo |
|---|---|---|
| **Ask before edits** | Pide aprobación antes de cada cambio. | Por defecto, mientras aprendes. |
| **Edit automatically** | Aplica cambios sin pedir permiso paso a paso. | Cuando ya confías en lo que va a hacer. |
| **Plan Mode** | Antes de tocar nada, lee todo el proyecto y hace preguntas de aclaración si el pedido es ambiguo. | **Siempre que vayas a crear algo nuevo** — describir el objetivo claro y dejar que pregunte lo que falta, en vez de improvisar sobre un prompt vago. |
| **Bypass permissions** | No pide confirmación en ningún paso (Settings → buscar "claude code" → activar "allow bypass permissions mode"). | Solo cuando estás viendo la pantalla activamente — nunca dejarlo corriendo desatendido. |

**Regla para la sesión:** Plan Mode es el hábito que se enseña desde el día 1 — mejor una pausa de aclaración al inicio que cinco iteraciones corrigiendo un resultado mal entendido.

### El primer ritual en cualquier proyecto nuevo: el `CLAUDE.md`

Antes de pedirle cualquier cosa a Claude Code en un proyecto nuevo, lo primero es darle un system prompt — el archivo `CLAUDE.md`. Sin él, es como pedirle algo a un experto sin decirle nada de tu negocio, tus clientes o tus formatos: la respuesta sale genérica. El `CLAUDE.md` es donde vive el "¿quién eres tú?" de forma permanente — se desarrolla a fondo en la siguiente sección.

### Por qué el contexto lo es todo (antes del hands-on)

> **Fuente:** vault `11-spec-driven-development.md`, Clase 02, Clase 05 y Clase 06 — sí es material de Tribu Divisual.

Antes de que cada quien escriba su `CLAUDE.md`, hay que dejar clarísimo esto: **el resultado que van a obtener las próximas 5 sesiones depende directamente de qué tan bien escriban este archivo hoy.** No es un trámite — es la diferencia entre un asistente genérico y uno que realmente conoce su negocio.

- **Regla de oro:** mejor que sobre contexto a que falte. La IA no se confunde por tener demasiada información — se confunde cuando le das poco y tiene que inventar el resto.
- **Los 3 tipos de contexto** (esto es nuevo hoy, primera vez que lo ven) y dónde van exactamente:
  - **¿Quién eres tú?** → esto va en el `CLAUDE.md` — se escribe una vez, se lee siempre.
  - **¿Qué quieres?** → esto va en cada prompt que escriban — cambia con cada tarea.
  - **¿Cómo lo quieres?** → formato, tono, restricciones — puede ir en el `CLAUDE.md` si es constante (ej. "siempre en español"), o en el prompt si es específico de esa tarea.
- **El Manual Interno — 3 categorías para lo que va en el `CLAUDE.md`** (Clase 05 del vault, "El Manual Interno"):
  - **Tono y formato** — cómo se escribe, cómo terminan los documentos, en qué idioma responde.
  - **Lo que nunca se hace** — las líneas rojas: ej. comprometer plazos sin aprobación, dar precios sin consultar la tabla, mandar algo a un cliente sin revisión.
  - **Criterio de trabajo bien hecho** — qué significa que una tarea quedó terminada, no solo hecha.
  - Con 5 reglas repartidas entre estas 3 categorías basta para empezar — el manual crece con el uso, no tiene que salir completo hoy.
- **Por qué vale la pena invertir el tiempo ahora:** una vez que el `CLAUDE.md` está cargado, en el día a día ya no hay que repetir quién eres — solo agregas la tarea concreta, el formato y el criterio de éxito. El contexto general queda resuelto permanentemente desde hoy.

### Hands-on de cierre de la Sesión 1

1. Instalar Claude Code (pasos de arriba).
2. Abrir la carpeta del proyecto/negocio propio de cada quien (definido antes de la sesión, según lo acordado).
3. Escribir el primer `CLAUDE.md` real — pegar el **master prompt** (`templates/master-prompt-claude-md.md`) dentro de Claude Code y dejar que la entrevista guíe quién eres, cómo trabajas, qué nunca se hace y qué es "bien hecho". 5 reglas bastan para empezar.

**Entregable de la sesión:** Claude Code instalado + `CLAUDE.md` v1 propio, sobre su proyecto real.

---

## Cierre de la Sesión 1 — comparando los 3 niveles

Antes de terminar, recapitular lo visto hoy en una sola tabla — mismo "cerebro" (Claude), tres superficies distintas:

| | LLM general (Chat — Parte 1) | Claude Cowork (Parte 2) | Claude Code (Parte 3) |
|---|---|---|---|
| **¿Qué es?** | Conversación — preguntas y respuestas en texto. | Sesión de trabajo sobre archivos y apps de oficina. | Agente que trabaja en tu código/proyectos. |
| **¿Dónde vive?** | Navegador o app de chat. | Chrome + Word, Excel, PowerPoint, Outlook. | VS Code / terminal. |
| **¿Qué puede tocar?** | Nada fuera de la conversación — solo genera texto. | Tus archivos y apps reales. | Archivos, comandos, herramientas externas (MCP), scripts. |
| **¿Para quién?** | Cualquiera, uso general. | Cualquiera que trabaje con documentos de oficina. | Quien construye software o automatizaciones. |
| **Hoy en la sesión** | Vimos qué resuelve y dónde se queda corto. | Solo se explicó — sin hands-on. | Se instaló y se usó en vivo (hands-on). |

**El hilo conductor:** cada nivel resuelve más de la limitación #4 de la Parte 1 ("no ejecuta acciones reales por sí solo") que el anterior — el LLM de chat no toca nada, Cowork toca tus archivos de oficina, Claude Code toca código y se conecta a herramientas externas. Las próximas 6 sesiones viven enteras en la columna de la derecha.

---

## Sesión 1 — completa (2026-07-27)

Las 3 partes + cierre comparativo están redactados. Pendiente: revisión final de Antonio antes de dar la sesión, y confirmar duración real una vez que se ensaye (estimado ~95 min: ~35 min Parte 1, ~10 min Parte 2, ~45 min Parte 3 con contexto + hands-on, ~5 min cierre comparativo).
