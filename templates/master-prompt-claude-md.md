<!-- Language note: written in Spanish, including the prompt-to-paste block — this is delivery content for Spanish-speaking friends, same deviation as sessions 01-06, see note there. -->

# Master Prompt — Crea tu primer CLAUDE.md

Handout para el final de la Sesión 1 ("Master Claude"), hands-on de la Parte 3. Cada quien lo pega en Claude Code, dentro de su propia carpeta de proyecto, justo después de instalarlo.

**Fuente:** grounded en lo enseñado en `sessions/01-mentalidad-fundamentos-claude-code.md` — Parte 3, "Por qué el contexto lo es todo" (los 3 tipos de contexto y el Manual Interno de la Clase 02/05 del vault). La estructura de salida está calibrada contra un `CLAUDE.md` real que Antonio ya usa en producción (ejemplo: "Kit Cazador de Webs") — no son solo categorías abstractas, tiene que quedar así de concreto y útil.

**Nota de alcance:** el paso 4 de la entrevista (la tarea principal, paso a paso) es, en el fondo, el borrador de la primera skill que van a formalizar en la Sesión 2 — vale la pena decirlo en vivo, conecta las dos sesiones.

---

## El prompt (copiar y pegar tal cual en Claude Code)

```
Estoy arrancando un proyecto nuevo en Claude Code y necesito tu ayuda para
escribir mi primer CLAUDE.md — el archivo de contexto permanente que vas a
leer al inicio de cada sesión en este proyecto.

Entrevístame con las siguientes preguntas, una por una. Espera mi respuesta
antes de pasar a la siguiente. Si no sé qué responder todavía, digo "skip"
y seguimos — lo completamos después.

1. ¿Quién eres y qué es este proyecto o negocio? En un par de frases: a qué
   te dedicas, a quién le sirves, tu sector. Esto se convierte en tu
   identidad como asistente.
2. Tono y formato — ¿en qué idioma respondo siempre? ¿cómo quieres que
   hable (cercano, formal, sin jerga técnica, lo que sea)?
3. Primer arranque — cuando abra este proyecto y tú solo me saludes o no
   sepas bien qué pedirme, ¿qué debería hacer yo? Piensa en cómo te
   gustaría que te reciba y qué te recuerde que puedes pedirme.
4. La tarea principal — ¿cuál es LA cosa que más vas a hacer conmigo en
   este proyecto? Descríbemela paso a paso, como si se la explicaras a
   alguien que nunca la ha hecho: qué es lo primero, qué sigue, cómo sabes
   que terminó.
5. Reglas — las líneas rojas: cosas que nunca debo hacer sin tu aprobación
   (ej. prometer algo a un cliente, inventar datos que no tengo, mandar
   algo afuera sin que lo revises). Y: ¿dónde deben guardarse los
   resultados de lo que hagamos juntos?

Cuando termine de responder, escribe un CLAUDE.md con esta estructura:

# [Nombre del proyecto — tú lo eliges con lo que te dije en la pregunta 1]

[Un párrafo: quién soy, qué hace este asistente, para quién trabajo. El
idioma y tono de la pregunta 2 van aquí también como instrucción directa —
ej. "Habla SIEMPRE en español, cercano y sin jerga técnica."]

## Primer arranque

[Qué hacer cuando el usuario solo saluda o no sabe qué pedir, de la
pregunta 3. Termina con un ejemplo concreto de qué puede escribir para
arrancar.]

## [Nombre real de la tarea principal, de la pregunta 4 — no le pongas un
nombre genérico como "El trabajo", ponle el nombre que tiene de verdad en
el negocio]

[Los pasos de la pregunta 4, convertidos en instrucciones. Si el proceso
tiene fases, que se vayan narrando una por una mientras se ejecuta, para
que se vea el progreso.]

## Reglas

- [Las líneas rojas de la pregunta 5]
- Los resultados van siempre a [la carpeta o lugar de la pregunta 5]
- Nunca inventes datos que no tengas — solo lo real

Reglas para el archivo:
- Conciso y concreto — si algo no aplica a mi negocio, no lo pongas de
  relleno.
- Mejor que sobre contexto a que falte, pero sin relleno genérico que no
  sea cierto sobre mí.
- Respóndeme siempre en español.
```

---

## Notas para el facilitador (Antonio — esto no va en el handout)

- Antes de que lo peguen, conecta con lo que se acaba de explicar: *"La pregunta 1 es el '¿quién eres tú?' de los 3 tipos de contexto que vimos. Las preguntas 2 y 5 son las categorías del Manual Interno."*
- La pregunta 4 (tarea principal paso a paso) vale la pena marcarla en vivo: *"Lo que acaban de describir ahí es, literalmente, el borrador de su primera skill — en la Sesión 2 lo vamos a formalizar."* Les da un gancho claro hacia la siguiente sesión.
- Si alguien se traba en una pregunta, "skip" es válido — no dejes que el grupo entero se detenga por una respuesta perfecta.
- Al terminar, da una vuelta y revisa: ¿el `CLAUDE.md` suena a *su* negocio, con nombres y pasos reales, o salió genérico? Un resultado genérico casi siempre viene de una pregunta 1 o 4 apurada — vale la pena repetirla en vivo si pasa. El estándar es que la sección de la tarea principal tenga el nombre y los pasos reales de su negocio, no un placeholder tipo "El trabajo: paso 1, paso 2".
- Esto produce una v1. A propósito no es la entrevista completa de 6 secciones del Capstone (Sesión 6) — esa va mucho más a fondo (equipo, objetivos, tareas recurrentes). No dejes que se confundan las dos.
