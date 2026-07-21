# Referencia técnica: BPMN → Miro layout DSL

Esta skill dibuja usando la herramienta `layout_create` del MCP de Miro (NO
`diagram_create` — ese tool solo soporta flowchart/uml/erd genéricos, sin
vocabulario suficiente para notación BPMN con colores de fase y fricciones).

Antes de construir el DSL, siempre llama `layout_get_dsl` una vez por
conversación para confirmar la especificación vigente (puede cambiar de
versión). Lo de abajo es el mapeo BPMN → esa especificación, validado contra
el tablero "Curso miro" (https://miro.com/app/board/uXjVHAWx70Q=/) que el
equipo del cliente ya reconoce.

## Constantes de layout

```
X_START   = 0      # x del primer nodo del flujo principal
X_STEP    = 260     # distancia entre centros de nodos consecutivos
TASK_Y    = 0        # fila principal (tareas, eventos, gateways)
BANNER_Y  = -180     # fila de banners de fase, arriba del flujo
FRICTION_Y = -90     # stickies de fricción, entre banner y flujo
BANNER_H  = 50
TASK_W    = 200
TASK_H    = 80
EVENT_D   = 60       # circle w=h=60
GATEWAY_D = 100       # rhombus w=h=100
DATA_W    = 90
DATA_H    = 70
```

Todo en board-absolute (sin `parent=` frame), salvo que el usuario pida
encapsular el diagrama dentro de un frame — en ese caso resta las
coordenadas del frame como de costumbre.

## Alineación vertical de nodos (altura)

Regla del cliente: los recuadros deben quedar a la misma altura siempre que
sea posible.

- **Default: todo nodo va en `TASK_Y` (la fila principal)** — eventos,
  tareas, gateways. No lo saques de esa fila solo porque viene después de
  un gateway.
- **Excepción, la ÚNICA que aplica:** una rama de un gateway que contiene
  **dos o más pasos secuenciales** antes de reunirse de nuevo con el flujo
  principal (ej. "si K: consulta a Jonathan → Jonathan define montos, luego
  sigue"). Esos 2+ pasos SÍ pueden ir en su propia fila (`TASK_Y + 140`,
  ver ejemplo de t3/t4 en el mapeo de abajo) porque agruparlos visualmente
  como un mini-sub-flujo ayuda a leerlos como una unidad.
- **Una rama de un solo paso se queda en `TASK_Y`**, igual que el resto —
  aunque eso signifique que el conector de esa rama entre en diagonal o con
  un `shape=elbowed` corto hacia el gateway/tarea de origen. No la bajes de
  fila solo por venir de un gateway; bajar de fila es exclusivamente para
  agrupar 2+ pasos consecutivos de una misma rama.
- Al planificar el eje X (ver más abajo), cuenta también los nodos que SÍ
  quedaron en una fila secundaria para calcular anchos de banner y
  divisores — pero para el ancho del banner de fase usa el rango de X real
  ocupado por todos los nodos de esa fase (fila principal + filas
  secundarias), no solo `X_STEP * count`.

## Reglas aprendidas en producción (`layout_create` / `layout_update`)

- **`size` mínimo en SHAPE es 10.** `size=9` (o menor) hace que ESE item
  falle con `HTTP 400` — y si va en el mismo lote que otros items, tumba el
  lote completo sin mensaje específico (todos los items reportan el mismo
  "Bulk create failed: HTTP 400", no solo el culpable). Nunca uses `size`
  menor a 10, en ningún elemento.
- **Esto NO es un límite de cantidad de items.** La primera vez que se
  construyó esta skill se pensó (equivocadamente) que había un tope de ~10
  items por `layout_create` — en realidad TODOS los fallos fueron causados
  por `size=9` en algún gateway del lote. Un solo `layout_create` con el
  diagrama completo (60-70 items) funciona bien en una sola llamada
  mientras ningún SHAPE use `size < 10`. No dividas el DSL en lotes
  pequeños por precaución — desperdicia llamadas y tokens sin necesidad.
- **`border_color` debe fijarse explícito para que el borde se vea.** Si
  omites `border_color` en un SHAPE, Miro lo crea con `border_opacity=0`
  (invisible) aunque `border_width` esté seteado — no basta con poner
  `border_width`. Regla: todo SHAPE con borde visible lleva
  `border_color=#1a1a1a` explícito (o el color que corresponda).
- **`align`/`valign` no vienen centrados por default.** El default es
  `align=left valign=top`. Para banners, tareas, gateways y eventos, fija
  siempre `align=center valign=middle` explícito.
- **Retrocesos de flujo van con línea punteada.** Cualquier CONNECTOR que
  regresa a un paso anterior (loop de corrección, "No"/"Sí" que vuelve
  atrás) lleva `stroke_style=dashed`. El flujo hacia adelante siempre usa
  `stroke_style=normal` (el default, no hace falta especificarlo).
- **Ninguna línea debe pasar por encima de una figura.** Un retroceso que
  conecta dos nodos lejanos en la fila principal (mismo `y`) cruza en línea
  recta por encima de todos los nodos intermedios si no se le da una ruta
  alterna — el DSL no tiene waypoints manuales, así que la única forma de
  evitarlo es forzar el punto de salida/entrada del CONNECTOR hacia el lado
  vacío del diagrama con `start_snap`/`end_snap`. Deja SIEMPRE una franja
  vacía debajo de la fila principal de tareas (no coloques nada en
  `y > TASK_H/2 + 20` salvo el propio retroceso) y en todo retroceso usa:
  `start_snap=bottom end_snap=bottom` — así el conector sale por abajo del
  nodo origen, viaja por la zona vacía y entra por abajo del nodo destino,
  sin cruzar ningún nodo intermedio. Ejemplo completo:
  `CONNECTOR from=X to=Y shape=elbowed stroke_color=#1a1a1a stroke_style=dashed start_snap=bottom end_snap=bottom "No"`.
- **Los conectores van después de todos los shapes**, referenciando cada
  endpoint por su **ID numérico real** (no el alias original) si vienen de
  una llamada `layout_create` anterior — el alias solo existe dentro del
  mismo `layout_create` que lo declaró. Extrae el ID del `result_dsl` de la
  respuesta (aparece como `...?moveToWidget=<ID>` reemplazando el alias).
  Si todo el diagrama va en una sola llamada (recomendado, ver arriba), los
  conectores pueden usar los alias directo, sin este paso.
- **`layout_update` hace match de texto EXACTO** contra el DSL interno
  actual. Ese DSL interno usa formato decimal con `.0` (`border_width=2.0`,
  `fill_opacity=0.0`) — el mismo formato que devuelve `layout_read`. El
  `result_dsl` que devuelve `layout_update` después de una edición usa
  formato SIN `.0` (`border_width=2`) — es solo para lectura humana, NUNCA
  lo uses como `old_string` de la siguiente edición o el match fallará.
  Antes de cualquier edición, basa el `old_string` en la salida más
  reciente de `layout_read`.
- **`layout_update` también borra** (`new_string=""`) y sirve para
  reemplazos masivos por fragmento común con `replace_all=true` — por
  ejemplo, arreglar el borde de 30 shapes de una sola vez con un fragmento
  compartido como `border_width=2.0 border_opacity=0.0`. Mucho más
  eficiente que editar item por item.

Planifica el eje X completo (cuántos nodos, en qué orden) ANTES de escribir
la primera línea de DSL. Los loops de retroceso (ej. "No: regresa al paso 6")
NO se dibujan como nodos duplicados — se conectan con un CONNECTOR de vuelta
al alias del nodo original, con caption "No".

## Colores de fase (ciclo fijo, reusar siempre en este orden)

1. `#1565c0` azul
2. `#2e7d32` verde
3. `#e65100` naranja
4. `#6a1b9a` morado
5. `#00695c` teal
→ si hay una 6ª fase, vuelve a `#1565c0`.

Banner: `SHAPE type=rectangle fill=<color> h=50 w=<ancho de esa fase> font=open_sans size=14 color=#FFFFFF align=center valign=middle border_color=#1a1a1a "Fase N: [Nombre]"`
Ancho del banner = `X_STEP * (número de nodos de esa fase)`, centrado sobre esos nodos.

Divisor entre fases: `SHAPE type=rectangle w=30 h=<banner + fila de tareas> fill=#bbbbbb border_color=#1a1a1a align=center valign=middle "│"` en el punto medio entre la última tarea de una fase y la primera de la siguiente. Hazlo lo bastante alto para cubrir desde el banner hasta la fila de tareas (no solo la altura del banner) — así se ve como una división real entre fases, no una rayita suelta arriba.

## Mapeo de elementos BPMN

| Elemento BPMN | DSL | Notas |
|---|---|---|
| Evento inicio | `SHAPE type=circle w=60 h=60 border_width=2 border_color=#1a1a1a align=center valign=middle fill_opacity=0 "Inicio"` | sin relleno |
| Evento intermedio | `SHAPE type=circle w=60 h=60 border_style=dashed border_color=#1a1a1a align=center valign=middle fill_opacity=0 "..."` | |
| Evento fin | `SHAPE type=circle w=60 h=60 border_width=8 border_color=#1a1a1a align=center valign=middle fill_opacity=0 "FIN"` | borde grueso simula el doble círculo BPMN |
| Inicio por mensaje | igual a inicio + conector de mensaje entrante (ver abajo) | no hay icono de sobre nativo; el mensaje se representa con el connector, no con el nodo |
| Tarea manual (sin sistema) | `SHAPE type=round_rectangle w=200 h=80 border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=11 "✋ [Actor] [verbo] [objeto]"` | prefijo ✋ en el content |
| Tarea usuario+sistema | igual, prefijo `"👤 ..."` | |
| Tarea de servicio (automática) | igual, prefijo `"⚙️ ..."` | |
| Llamada/reunión | `border_width=5` en vez de 2 | |
| Transacción/pago | `border_width=4` (no hay doble borde nativo — ponytail: aproximación de un solo borde grueso, si hace falta el doble borde exacto usar dos SHAPE superpuestos) | |
| Gateway exclusivo (XOR) | `SHAPE type=rhombus w=100 h=100 border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=10 "×"` | caption Sí/No va en el CONNECTOR saliente, no en el nodo; `size` nunca menor a 10 |
| Gateway paralelo (+) | `SHAPE type=rhombus w=100 h=100 border_width=4 border_color=#1a1a1a align=center valign=middle font=noto_sans size=10 "+"` | |
| Gateway inclusivo (○) | `SHAPE type=rhombus w=100 h=100 border_width=4 border_color=#1a1a1a align=center valign=middle font=noto_sans size=10 "○"` | |
| Almacenamiento de datos | `SHAPE type=can w=90 h=70 border_color=#1a1a1a align=center valign=middle "..."` | |
| Objeto de datos | `SHAPE type=round_rectangle w=80 h=100 border_color=#1a1a1a align=center valign=middle "📄 ..."` | ponytail: no existe shape de página doblada nativo, se aproxima con rectángulo + emoji |
| Sequence flow, hacia adelante (mismo flujo) | `CONNECTOR from=A to=B end_cap=arrow stroke_color=#1a1a1a` | shape=elbowed si hay salto de fila (branch), curved por default está bien para el flujo principal; stroke_style=normal (default) |
| Sequence flow, retroceso (loop "No"/"Sí" que regresa a un paso anterior) | `CONNECTOR from=A to=B shape=elbowed end_cap=arrow stroke_color=#1a1a1a stroke_style=dashed start_snap=bottom end_snap=bottom` | siempre dashed (distingue el loop del flujo principal) y siempre `start_snap=bottom end_snap=bottom` (rutea por la zona vacía debajo de la fila principal, sin cruzar nodos intermedios) |
| Message flow (entre participantes distintos) | `CONNECTOR from=A to=B start_cap=oval end_cap=arrow stroke_color=#1a1a1a` | círculo en el origen = start_cap=oval |
| Association (hacia notas/artefactos) | `CONNECTOR from=A to=B stroke_style=dotted start_cap=none end_cap=none` | |
| Rama de decisión ("Sí"/"No") | usa `"caption"` al final del CONNECTOR | ej. `e5 CONNECTOR from=dec1 to=task9 end_cap=arrow "No"` |

Banners de fase y divisores también llevan `border_color=#1a1a1a align=center valign=middle` explícitos, por la misma razón (ver Reglas arriba).

## Marcadores de fricción

```
STICKY parent=<none> x=<centro del nodo> y=FRICTION_Y w=140 color=red   "🔴 [descripción corta]"   # riesgo/bloqueo
STICKY parent=<none> x=<centro del nodo> y=FRICTION_Y w=140 color=yellow "🟡 [descripción corta]"   # dependencia de una persona / excepción
```
Coloca el sticky directamente arriba del nodo (tarea o decisión) que genera
la fricción, usando el mismo `x` que ese nodo. Nunca lo sobrepongas con el
banner de fase — si `FRICTION_Y` choca con `BANNER_Y`, sube el banner
(`BANNER_Y = -220`) en vez de mover el sticky.

## Leyenda

Coloca un `TEXT` en la esquina inferior derecha del diagrama completo (x =
último X_STEP usado + 300, y = TASK_Y + 200) con la leyenda de colores y
símbolos usados, tamaño 11, font=open_sans.

## Ejemplo mínimo (referencia de formato, no copiar literal)

```
b1 SHAPE x=390 y=-180 w=780 h=50 type=rectangle fill=#1565c0 font=open_sans size=14 color=#FFFFFF align=center valign=middle border_color=#1a1a1a "Fase 1: Recepción"

ev1 SHAPE x=0   y=0 w=60  h=60  type=circle border_width=2 border_color=#1a1a1a align=center valign=middle fill_opacity=0 "Inicio"
t1  SHAPE x=260 y=0 w=200 h=80  type=round_rectangle border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=11 "👤 Antonio revisa documentación"
d1  SHAPE x=520 y=0 w=100 h=100 type=rhombus border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=10 "×"
t2  SHAPE x=780 y=0 w=200 h=80  type=round_rectangle border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=11 "👤 Antonio envía a Benny"
t0  SHAPE x=-260 y=0 w=200 h=80 type=round_rectangle border_width=2 border_color=#1a1a1a align=center valign=middle font=noto_sans size=11 "👤 Paso anterior (destino del loop)"

fr1 STICKY x=520 y=-90 w=140 color=yellow "🟡 Antonio es orquestador único"

c1 CONNECTOR from=ev1 to=t1 end_cap=arrow stroke_color=#1a1a1a
c2 CONNECTOR from=t1 to=d1 end_cap=arrow stroke_color=#1a1a1a
c3 CONNECTOR from=d1 to=t2 end_cap=arrow stroke_color=#1a1a1a "Sí"
c4 CONNECTOR from=d1 to=t0 shape=elbowed end_cap=arrow stroke_color=#1a1a1a stroke_style=dashed start_snap=bottom end_snap=bottom "No"
```

Nota: `size=10` en el gateway (`d1`) — nunca menos, ver Reglas arriba. `c4`
es un retroceso (vuelve a un paso anterior `t0`), por eso lleva
`stroke_style=dashed` Y `start_snap=bottom end_snap=bottom` (para no cruzar
por encima de `t1` que está en medio del camino); `c1`-`c3` son flujo hacia
adelante y usan el `stroke_style=normal` default (no hace falta
escribirlo).
