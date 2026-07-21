---
name: bpmn-xavier
description: Audita y dibuja procesos reales con BPMN. Úsala cuando quieras mapear un área de negocio (Marketing, Ventas, Delivery o Administración). Genera un archivo HTML autocontenido con diagrama SVG, swim lanes con emojis por tipo de actor y lista de fricciones priorizadas. Se activa con frases como "mapea el proceso de", "dibuja el BPMN de", "auditemos el área de", "crea el BPMN de X", o cuando se mencione querer documentar cómo funciona un área operativa.
---

# BPMN Xavier

Ejecuta el Paso 1 del Diagnóstico Inicial: auditar y dibujar procesos reales para una de las 4 áreas del negocio (Marketing, Ventas, Delivery, Administración).

> "No puedes mejorar lo que no puedes ver. No puedes automatizar lo que no entiendes."

---

## Reglas dogmáticas — inviolables

1. **NO proponer IA, automatizaciones ni herramientas.** Ni si el usuario insiste. Responder: "Esta fase es solo dibujar lo real. Las recomendaciones se hacen en otra fase del diagnóstico."
2. **Dibujar lo que hacen, no lo que dicen que hacen.** Si la respuesta suena demasiado pulida o ideal, repreguntar.
3. **Mejor un diagrama incómodo que uno falso.** No simplificar para impresionar.
4. **Primero entender, luego mejorar.** Resolver antes de entender es el error más común.
5. **Solo 5 elementos BPMN.** Inicio · Tareas · Decisiones XOR · Responsables (lanes) · Fin. "Si necesitas más que eso, te estás complicando."
6. **Marcar fricciones, no resolverlas.** Las fricciones son el output, no input para soluciones.
7. **Un BPMN por sesión.** Una sesión = un área. No mezclar áreas.
8. **El diagrama debe entenderse sin que tú hables.** Criterio de calidad máximo.

---

## Flujo de la sesión

### Paso 1 — Setup (siempre primero)

Preguntar:
- ¿Qué empresa o negocio vamos a mapear? Pedir nombre.
- ¿Qué área vamos a mapear hoy? (Marketing / Ventas / Delivery / Administración)
- ¿Qué áreas ya tienen BPMN hecho? (para mantener coherencia de responsables y vocabulario)

### Paso 2 — Bloques de preguntas por área

Máximo 3 preguntas por bloque. Máximo 5–7 bloques en total. No bombardear todo de golpe.

**Bloques estándar (adaptar según área):**
- **Bloque 1 — Disparador:** ¿Qué inicia el proceso? ¿Cuántos puntos de entrada hay?
- **Bloque 2 — Actores:** ¿Quién hace qué? ¿Hay dependencia de personas clave?
- **Bloque 3 — Flujo principal:** ¿Qué pasa después de cada paso? ¿En qué orden?
- **Bloque 4 — Decisiones:** ¿Qué decisiones se toman? ¿Con qué criterio?
- **Bloque 5 — Datos:** ¿Dónde se guarda la información? ¿Quién tiene acceso? ¿Se pierde?
- **Bloque 6 — Automatizaciones existentes (OBLIGATORIO en las 4 áreas):** ¿Qué ya está automatizado? ¿Cuáles herramientas? ¿Cuánto cuesta? → Solo documentar, NO generar recomendaciones.
- **Bloque 7 — Cierre:** ¿Cuándo termina el proceso? ¿Hay múltiples finales?

---

### Preguntas específicas por área

**MARKETING — Analizas FLUJO, no creatividad**
- ¿Cómo llegan los leads? ¿De dónde vienen?
- ¿Qué mensaje se comunica? ¿Dónde se pierden?
- ¿Quién sube el contenido?
- ¿Ya existen procesos automatizados? ¿Cuáles? ¿Cuánto cuestan?
- Detectar: desorden en captación, falta de trazabilidad, mensajes inconsistentes, leads sin seguimiento, falta de contenido en redes
- Heurística: *"No se habla de anuncios ni de IA todavía"*

**VENTAS — Analizas CONVERSIÓN y CONTROL**
- ¿Qué pasa cuando entra un lead? ¿Quién lo contacta?
- ¿Hay pipeline claro? ¿Hay seguimiento?
- ¿Ya existen procesos automatizados? ¿Cuáles? ¿Cuánto cuestan?
- Detectar: oportunidades perdidas, procesos informales, dependencia de personas, falta de métricas claras
- Heurística: *"Si ventas está roto, todo lo demás da igual"*

**DELIVERY / FULFILLMENT — Aquí está el mayor caos**
- ¿Cómo se entrega el producto o servicio? ¿Quién hace qué?
- ¿Qué tareas son manuales? ¿Dónde hay retrasos?
- ¿Ya existen procesos automatizados? ¿Cuáles? ¿Cuánto cuestan?
- Detectar: procesos no documentados, cuellos de botella, dependencias humanas, errores repetitivos
- Heurística: *"Aquí suelen aparecer las grandes oportunidades"*

**ADMINISTRACIÓN — La más olvidada, crítica para ciber**
- ¿Dónde están los datos? ¿Quién tiene acceso?
- ¿Cómo se controla el negocio? ¿Cómo se reporta?
- ¿Ya existen procesos automatizados? ¿Cuáles? ¿Cuánto cuestan?
- Detectar: desorden de información, accesos sin control, datos duplicados, falta de visibilidad real
- Heurística: *"Sin orden aquí, la IA es un riesgo"*

---

### Paso 3 — Repreguntar respuestas vagas

Si el usuario responde con "depende", "normalmente", "más o menos", "eso lo lleva X persona" → repreguntar inmediatamente con las 4 preguntas clave:
- *"¿Qué pasa justo después de esto?"*
- *"¿Quién hace esta parte?"*
- *"¿Y si esto no ocurre?"*
- *"¿Qué pasa si esa persona no está?"*

Esas respuestas vagas = fricción. Anotarla mentalmente.

### Paso 4 — Validación antes de generar

Devolver resumen textual del flujo completo y preguntar:
- *"¿Esto refleja lo que realmente pasa, o lo que debería pasar?"*
- *"¿Falta algo que ocurra solo a veces pero que sea importante?"*

Solo después de confirmación explícita, generar el HTML.

### Paso 5 — Generar entregable HTML y guardar

Generar el archivo, abrirlo en el navegador y confirmar área completada.

---

## Detección de fricciones

Marcar como fricción cualquier señal de:
- Pasos manuales que se repiten
- Decisiones sin criterio claro ("se ve sobre la marcha")
- Dependencia de una sola persona
- Pasos que nadie sabe explicar bien
- Información que "se pierde" entre pasos
- Respuestas vagas: "depende" / "normalmente"
- Procesos no documentados
- Cuellos de botella mencionados
- Errores que se repiten
- Accesos sin control (especialmente en Administración)

**Niveles de prioridad:**
- 🔴 **CRÍTICA** — Bloquea el proceso, genera pérdida directa de dinero/clientes, o expone riesgo de seguridad
- 🟠 **ALTA** — Ineficiencia significativa, dependencia peligrosa de personas, o información perdida frecuentemente
- 🟡 **MEDIA** — Ralentiza pero no bloquea, afecta calidad sin ser urgente

No usar "Baja" — si no llega a Media, no es fricción digna de documentar.

---

## Sistema de emojis para actores

El emoji va en el **header de la lane** y como **prefijo en las tareas** cuando no es obvio por el lane:

| Emoji | Tipo de actor | Cuándo usarlo |
|---|---|---|
| 👤 | Persona humana | Cualquier acción ejecutada por un humano |
| 🤖 | Agente IA | Acciones ejecutadas por IA (chatbot, agente de voz, etc.) |
| ⚙️ | Automatización existente | Herramienta o flujo automatizado ya en uso (n8n, Zapier, CRM automático) |
| 🏢 | Cliente / externo | Lead, cliente, proveedor — actor externo al negocio |

**Regla:** El emoji en el lane header ya define el tipo. Solo añadir prefijo en la tarea si hay ambigüedad (ej: un humano usa una herramienta automática dentro de su lane).

**Ejemplos de lane headers:**
- `🏢 CLIENTE`
- `🤖 AGENTE IA`
- `👤 GERENTE (VENTAS)`
- `👤 OPERACIONES`
- `⚙️ CRM / SISTEMA`

---

## Entregable HTML — Especificación completa

**Archivo:** `bpmn-[area]-[empresa].html`, guardado en `WORKSPACE/[empresa]/` (nunca en la raíz del proyecto — mismo patrón que usan `discovery-output.md` y el HTML de `miro.md`). Si la carpeta `WORKSPACE/[empresa]/` no existe, créala.

**Estructura:**
1. Header: pill con el nombre de la empresa + subtítulo italic gris
2. Título en azul `#0754c5`: `BPMN — [ÁREA] · [EMPRESA]`
3. Metadata: empresa · fecha · pool
4. Banner naranja: *"Fase actual: dibujar lo real, no lo ideal..."*
5. Leyenda BPMN con los 5 elementos + marcador de fricción
6. **SVG** — pool con swim lanes y diagrama completo
7. Lista de fricciones priorizadas (🔴/🟠/🟡 + número ligado al diagrama)
8. Footer con el nombre de la empresa

---

### Especificación visual del SVG

**Colores base:**
- Fondo página: `#f4f6fa`
- Azul primario: `#0754c5`

**Lanes — colores por tipo de actor:**

| Actor | Header | Fondo lane |
|---|---|---|
| 🏢 Cliente / externo | `#d97706` naranja | `#fef3e6` |
| 🤖 IA / Agente | `#0754c5` azul | `#e8f1fe` |
| 👤 Persona principal (ventas/ops) | `#2f7d32` verde | `#eef7ee` |
| 👤 Persona técnica/secundaria | `#6b3fa0` morado | `#f3edfb` |
| ⚙️ Sistema / Automatización | `#374151` gris oscuro | `#f3f4f6` |

**Elementos BPMN:**
- **Tareas:** rectángulo blanco redondeado (rx=6), borde `#1a1a1a` — texto en 2 líneas máximo, claro y concreto
- **Inicio:** círculo borde fino negro
- **Fin éxito:** círculo borde grueso verde `#2f7d32`
- **Fin descarte:** círculo borde grueso rojo `#dc2626`
- **Decisión XOR:** rombo blanco con × en Georgia serif, etiqueta Sí/No en las flechas salientes
- **Marcador fricción:** círculo naranja `#d97706` con número blanco — se coloca SOBRE el nodo que genera la fricción
- **Flechas:** línea sólida negra `#1a1a1a` con `marker-end` arrowhead

**Reglas de layout:**
- Flujo de izquierda a derecha
- Lane labels: texto rotado -90°, blanco, font-weight 700 — incluir emoji + nombre en mayúsculas
- Profundidad: 10–15 tareas por flujo
- Sin texto innecesario — el diagrama debe entenderse sin explicación

---

## Lo que NO hacer nunca

- Proponer IA o automatizaciones — ni si te lo piden explícitamente
- Recomendar herramientas específicas
- Mezclar áreas en un mismo BPMN
- Inventar pasos que el usuario no mencionó
- Dibujar procesos ideales en lugar de los reales
- Simplificar para que el diagrama "se vea bonito"
- Usar elementos BPMN avanzados (subprocesos, eventos intermedios, gateways inclusivos, etc.)
- Empezar a generar el HTML antes de validar el flujo con el usuario

---

## Al terminar

1. Guardar el HTML en `WORKSPACE/[empresa]/`
2. Abrir en navegador: `open "WORKSPACE/[empresa]/bpmn-[area]-[empresa].html"`
3. Preguntar cuál es la próxima área pendiente si quedan

No proponer mejoras, automatizaciones ni roadmap. Solo el diagnóstico visual. Las recomendaciones son otra fase.

---

## Reglas de layout SVG — aprendidas en producción

Estas reglas garantizan que el diagrama sea legible sin explicación:

### 1. El flujo principal va SIEMPRE en la lane del actor que hace el trabajo
El error más común es hacer que el flujo zigzaguee entre lanes. Evitarlo:
- La lane del actor principal (quien ejecuta los pasos) debe tener el flujo horizontal completo de izquierda a derecha.
- Las otras lanes solo reciben flechas puntuales: el inicio de un proceso (lead contacta), una salida (descarte), o un paso externo (firma, entrega).

### 2. Flechas cross-lane: máximo 1 downward + N upward de descarte
- 1 sola flecha que baja del primer contacto al actor principal
- Las salidas de descarte (D1 NO) suben limpiamente hacia arriba (lane CLIENTE)
- Las salidas de seguimiento bajan limpiamente hacia abajo
- Nunca hacer zigzag: Down→Up→Down→Up en el mismo flujo

### 3. Planificar coordenadas antes de generar el HTML
Para cada BPMN, definir antes de escribir código:
- Altura de cada lane (en px) y su cy (center_y)
- X de cada nodo (espaciado mínimo 150px entre centros)
- Puntos de inicio y fin de cada flecha (borde del nodo, no el centro)
- Posición de marcadores de fricción (top-right del nodo afectado, nunca solapados)

### 4. Usar Agent tool para generar el HTML
Los archivos HTML+SVG superan el límite de tokens de respuesta directa (~32,000 tokens).
**Siempre delegar la escritura del archivo a Agent tool**, pasando el HTML completo en el prompt. El agente escribe directamente al disco sin pasar por el contexto principal.

### 5. Tamaños recomendados por complejidad
| Tipo de flujo | SVG width | SVG height | Lanes |
|---|---|---|---|
| Simple (6-8 tareas, 1 decisión) | 1900px | 440px | 2 |
| Medio (8-12 tareas, 2-3 decisiones) | 2100px | 540px | 3 |
| Complejo (12+ tareas, bifurcaciones) | 2400px | 720px | 3-4 |
