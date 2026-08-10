# Diagnóstico de Procesos — Victoria Specialty Coffee
**Consultoría de procesos | Áreas: Admin · Marketing · Ventas · Delivery**

---

## 0. Antes de la reunión — contexto a confirmar

- [x] **Instagram confirmado:** @victoria_specialtycoffee es "Victoria Specialty Coffee House", barra de café de especialidad en **Local 38, Plaza Polanco, Calle Jose Luis Lagrange núm. 38, Polanco 1ª Sección, CDMX**. 1.8K+ seguidores, 126 posts. Descrita como "pionera en la zona" (TikTok/FB, menciones desde 2023).
  - Ligada a **Mono Rojo Coffee Company** (@___monorojo___), tostador de café de especialidad en el mismo local (Local 38, Plaza Polanco) — la bio de Victoria dice "El Club de Café de Compañía @___monorojo___". Probable relación de marca/socio o concepto compartido — pregunta al dueño cómo se relacionan (ver sección 2, Apertura).
  - **Negocios descartados por confusión de nombre** (no son este cliente): "Café Victoria" organic en Riverhead NY (EUA), "Victoria Specialty Coffee" @victoriaspecialtycoffee — finca cafetalera en Jaén, Cajamarca, Perú (nota: handle sin guion bajo, distinto al de tu cliente), "Victoria Coffee Roasters" en Victoria, TX (EUA), "Victoria Coffee" @victoriacoffee.co en Massachusetts (EUA).
- [x] **¿Un solo punto de venta o varias sucursales?** No se encontró evidencia de más de un local — todo apunta a un solo punto de venta (Local 38, Plaza Polanco). Confirmar en la cita, pero no lo trates como sorpresa si dicen que es solo uno.

_(Investigado con Firecrawl el 2026-07-22 — ver `.claude/rules/scraping.md`)_

---

## 1. Objetivo de la reunión
Identificar cuellos de botella en los 4 procesos clave, priorizar por impacto/esfuerzo, y dejar 2-3 quick wins accionables + un roadmap de automatización (tu área natural con Krato: n8n, WhatsApp, Airtable/Supabase).

---

## 2. Guion de preguntas por área

### 🔑 Apertura
1. ¿Eres el dueño del negocio? (Sí/No)
2. Si no: ¿qué puesto tienes?
3. ¿Qué te hizo buscar ayuda con esto justo ahora? (el "por qué ahora" suele ser el dolor más fuerte — úsalo para la propuesta)
4. ¿Cómo se relaciona Victoria con Mono Rojo Coffee Company? (¿misma dueña, marca hermana, alianza de espacio en Plaza Polanco?)
5. ¿Cuánto tiempo llevan operando?
6. ¿Quién más del negocio está involucrado en las decisiones de estas 4 áreas? (aparte de con quién estás hablando ahora)

### 🗂️ Admin
1. ¿Cómo llevan hoy el control de inventario (café, leche, insumos, empaques)? ¿Excel, papel, app?
2. ¿Cómo controlan costos y márgenes por producto? ¿Saben cuál es su producto más/menos rentable?
3. ¿Cómo manejan nómina, turnos y asistencia del personal?
4. ¿Tienen algún reporte diario/semanal de cierre de caja? ¿Quién lo revisa y qué hace con esa info?
5. ¿Qué tan seguido hay discrepancias de caja o inventario "fantasma"?
6. ¿Usan algún POS? ¿Cuál? ¿Están conformes con él?
7. ¿Qué usan para pagos y facturación (terminal, CFDI, facturación manual)? ¿Es un dolor o ya está resuelto?

### 📣 Marketing
1. ¿Quién produce el contenido de Instagram — dueño, empleado, agencia?
2. ¿Tienen calendario de contenido o publican "cuando se puede"?
3. ¿Miden qué tipo de post genera más visitas/pedidos reales (no solo likes)?
4. ¿Hacen algo de WhatsApp marketing, email, o solo redes sociales?
5. ¿Tienen base de datos de clientes (aunque sea básica)?
6. ¿Cómo consiguen nuevos clientes hoy — orgánico, pauta, boca a boca, ubicación?
7. ¿Quién genera las ideas de contenido y cuál es el proceso de principio a fin (de la idea a la publicación)?
8. ¿Corren pauta paga (ads en Meta/Instagram/Google)? ¿Quién la arma, ejecuta y decide el presupuesto?
9. ¿Cómo y dónde almacenan su material (fotos, videos, diseños)? ¿Google Drive, celular, en la nube, desordenado?

### 💰 Ventas
1. ¿Cómo se toman los pedidos en local — mostrador, QR, app propia?
2. ¿Tienen upselling estructurado (ej. "¿le agregamos un shot extra?") o es improvisado por barista?
3. ¿Manejan algún programa de lealtad/recurrencia?
4. ¿Saben cuál es su ticket promedio? ¿Y su tasa de clientes recurrentes vs. nuevos?
5. ¿Hay temporadas/horarios muertos que les gustaría activar?
6. ¿Usan algún CRM?
7. ¿Usan algún ERP?
8. ¿Tienen algún SOP (proceso de ventas documentado), o es venta sin estructura (a criterio del momento)?

### 🛵 Delivery
1. ¿Trabajan con apps (Rappi, Uber Eats, DiDi Food) o delivery propio?
2. Si es por apps: ¿qué % de su venta representa y qué tanto se come la comisión el margen?
3. ¿Tienen datos del % de pedidos que pasan por apps de terceros vs. propios? (para identificar qué tan dependientes son de esas plataformas)
4. ¿Cómo gestionan pedidos de delivery en horas pico sin que se choque con el flujo del local?
5. ¿Han medido tiempos de entrega, quejas, o pedidos cancelados/mal armados?
6. ¿Tienen pedidos por WhatsApp directo? ¿Cómo se procesan (manual, alguien contesta, bot)?

---

## 3. Framework de diagnóstico (para llenar en vivo o después)

| Área | Proceso actual | Dolor / cuello de botella | Impacto (Alto/Medio/Bajo) | Esfuerzo de solución | Oportunidad de automatización |
|---|---|---|---|---|---|
| Admin | | | | | |
| Marketing | | | | | |
| Ventas | | | | | |
| Delivery | | | | | |

**Cómo priorizar al final:** marca 2-3 filas como "Alto impacto / Bajo esfuerzo" → esos son tus quick wins para proponer primero.

---

## 4. Señales de alerta a escuchar (red flags típicas de cafeterías)
- Todo vive "en la cabeza del dueño" — sin procesos documentados
- Inventario y costos no se calculan por producto (no saben su margen real)
- Marketing reactivo, sin objetivo de conversión medible
- Delivery por apps sin calcular el impacto real de comisión en el margen
- Pedidos por WhatsApp respondidos manualmente sin sistema (aquí hay una oportunidad clara para ti: bot de pedidos tipo Kiwi)

---

## 5. Cierre de la reunión — qué llevarte
- [ ] 1 mapa de proceso actual por área (aunque sea a mano/mental)
- [ ] Los 2-3 dolores que el dueño menciona sin que se los preguntes (son los que más le duelen)
- [ ] Acuerdo de siguiente paso: propuesta escrita, con alcance y precio (tu referencia: ~MX$1,750/hr o paquete)