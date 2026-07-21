---
name: miro-bpmn
description: Usa esta skill cuando el usuario pida dibujar, poner o visualizar un proceso BPMN en un board de Miro. Se activa con frases como "dibújalo en Miro", "ponlo en el board", "dibuja el BPMN de X", "visualiza este proceso en Miro". Toma un discovery-output.md ya levantado (o una descripción inline) y crea el diagrama en un board real de Miro vía el MCP.
argument-hint: [cliente]
---

# miro-bpmn

Dibuja procesos BPMN en un board real de Miro usando el MCP (`layout_create`).
Solo dibuja — no interviews en profundidad, no optimiza, no propone
automatización ni IA. Todo el contenido del board y toda la conversación con
el usuario van en español LATAM.

Para la tabla de mapeo BPMN → DSL, colores de fase, constantes de layout y
un ejemplo de referencia, ver [reference.md](reference.md). Léelo antes de
construir el DSL la primera vez en la conversación.

## Paso 1 — Localizar el input

Busca `discovery-output.md` dentro de `WORKSPACE/[cliente]/` (si `$ARGUMENTS`
trae el nombre del cliente, úsalo directo; si no, pregunta "¿Para qué
cliente o proceso es esto?").

- **Si existe** → léelo. Confirma brevemente: "Encontré el levantamiento de
  [proceso]. ¿Lo dibujo tal cual o quieres ajustar algo antes?"
- **Si no existe** → dile al usuario: "No encuentro un levantamiento previo
  para [cliente]. ¿Quieres que primero levantemos el proceso, o me lo
  describes aquí directo?" Acepta una descripción inline si el usuario
  prefiere saltarse el discovery formal — en ese caso extrae tú mismo pasos,
  responsables, decisiones y fricciones de lo que te cuente.

## Paso 2 — Análisis previo

A partir del discovery-output.md (o la descripción inline), arma
internamente:

1. Lista de FASES/ETAPAS del proceso
2. Lista ordenada de TAREAS, agrupadas por fase, cada una con responsable y
   tipo (manual / usuario+sistema / servicio automático)
3. DECISIONES (gateways) con sus ramas
4. Evento de INICIO y evento de FIN
5. PUNTOS DE FRICCIÓN (🔴 riesgo/bloqueo, 🟡 dependencia de una persona)

Preséntaselo al usuario en español, formato limpio: "Antes de dibujar,
¿esto refleja la realidad del proceso?" Ajusta según su feedback antes de
seguir. No avances al Paso 3 sin confirmación explícita.

## Paso 3 — Pedir el board de Miro

Pregunta: "¿En qué board de Miro lo dibujo? Pásame la URL." Si el usuario no
tiene uno, ofrece crear uno nuevo con `board_create` — pero confirma
explícitamente antes de crearlo (es una acción visible/compartida, no
reversible con un simple undo local).

## Paso 4 — Construir el DSL

1. Llama `layout_get_dsl` (una sola vez por conversación) para confirmar la
   especificación vigente.
2. Planifica las coordenadas completas antes de escribir la primera línea:
   cuántos nodos, en qué orden, cuántas fases → usa las constantes de
   [reference.md](reference.md) (`X_STEP`, `TASK_Y`, `BANNER_Y`, etc.). Todo
   nodo va en `TASK_Y` por default — solo baja de fila una rama de gateway
   si tiene 2+ pasos secuenciales propios; una rama de un solo paso se
   queda en `TASK_Y` (ver "Alineación vertical" en reference.md).
3. Traduce cada elemento del análisis del Paso 2 a DSL usando la tabla de
   mapeo de [reference.md](reference.md): banners de fase, divisores,
   eventos, tareas, gateways, conectores, stickies de fricción, leyenda.
4. Los loops de retroceso ("No: regresa al paso X") se resuelven con un
   `CONNECTOR` de vuelta al alias del nodo original — nunca dupliques nodos.
   Ese CONNECTOR nunca debe cruzar por encima de otras figuras: usa
   `start_snap=bottom end_snap=bottom` para que rutee por la zona vacía
   debajo de la fila principal (deja esa zona libre al planear el layout),
   ver [reference.md](reference.md).

## Paso 5 — Crear en Miro

Llama `layout_create` con el diagrama completo en **una sola llamada**
(shapes + stickies + texto + conectores, usando alias — no hace falta
trocear en lotes). El único requisito duro es que ningún `SHAPE` use
`size < 10`, ver [reference.md](reference.md). Si el lote falla completo
con HTTP 400, bisecta para aislar el item/parámetro inválido — casi
siempre es un `size` chico en un gateway, no un problema de cantidad.
Recuerda `border_color` y `align=center valign=middle` explícitos en cada
SHAPE (ver reference.md) para que bordes y texto salgan visibles y
centrados desde el primer intento.

## Paso 6 — Validación

Una vez dibujado, pregunta en español:
"El diagrama está listo en Miro. Revísalo y dime:
1. ¿Hay algún paso que falta o está mal ubicado?
2. ¿Los responsables de cada tarea son correctos?
3. ¿Las decisiones reflejan la realidad o son simplificadas?
4. ¿Hay fricciones que no marqué y deberían estar?"

Itera con `layout_update` hasta que el usuario confirme. Antes de cada
edición, llama `layout_read` para tener el DSL actual exacto — `layout_update`
hace match de texto literal contra ese estado, y su propio formato de
respuesta no sirve como input de la siguiente edición (ver reglas de
formato en [reference.md](reference.md)). Para arreglos que aplican a
muchos items por igual (ej. bordes, alineación), usa un fragmento común con
`replace_all=true` en vez de editar item por item. Señal de que quedó bien:
"ahora lo veo claro" o equivalente.

## Lo que esta skill NO hace

- No interviewa en profundidad (eso es la skill de discovery — si no hay
  discovery-output.md y el usuario quiere el levantamiento completo,
  redirige a esa skill en vez de improvisar preguntas largas aquí).
- No propone IA, automatización, ni herramientas — ni si el usuario insiste
  a mitad de la sesión. Responde: "Esta fase es solo dibujar lo real, eso
  se ve después."
- No optimiza ni critica el proceso — solo lo dibuja.
- No dibuja la versión ideal — dibuja lo que la gente realmente hace.
- No crea un board nuevo sin confirmación explícita del usuario.
