# DISCOVERY OUTPUT
Process: Vencimiento de una solicitud
Date: 2026-08-27

## Trigger (Start Event)
Cron job diario (una vez al día) que revisa todas las solicitudes abiertas y compara su fecha límite contra la fecha actual.

## End Result (End Event)
Solicitud marcada "cancelada por tiempo", con la porción no estudiada resuelta según la decisión del donador (reembolso, extensión de plazo, o donación). Las partes ya confirmadas conservan su pago para quien las estudió.

## Participants / Lanes
- Backend (sistema)
- Donador
- Usuario (quien tenía partes tomadas sin completar)

## Steps (ordered)
1. Cron job diario revisa solicitudes abiertas y detecta cuáles llegaron a su fecha límite | Responsible: Backend | Type: automatic-service
2. Backend marca la solicitud como "vencida, en ventana de gracia" (estado temporal, ni cancelada ni abierta) | Responsible: Backend | Type: automatic-service
3. Backend notifica al donador (app + WhatsApp/SMS) que la solicitud llegó a su fecha límite, que hay partes en proceso, y que en unos días le presentará las opciones finales | Responsible: Backend | Type: automatic-service
4. Durante la ventana de gracia (propuesta: 3-5 días, sin definir formalmente aún), los usuarios que ya tenían partes tomadas pueden confirmarlas y cobrar con normalidad | Responsible: Usuario | Type: user-system
5. Al cerrar la ventana de gracia, backend calcula el reembolso final prorrateando el precio total del Shas entre el número de Masejtot, según lo que quedó realmente sin completar | Responsible: Backend | Type: automatic-service
6. Backend presenta al donador las opciones sobre la porción no estudiada (app y/o WhatsApp/SMS): reembolso, extender el plazo, o dejarla como donación | Responsible: Backend | Type: automatic-service
7. Solicitud queda marcada "cancelada por tiempo"; las partes ya confirmadas conservan su pago para quien las estudió | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Fecha límite ya pasó? → Solo aplica a solicitudes que sí tienen fecha límite puesta (las que no la tienen nunca entran a este flujo). Si sí: pasa a ventana de gracia.
- Partes tomadas pero no completadas al momento del vencimiento: cuentan como "no completadas" para el cálculo de reembolso, pero se les da la ventana de gracia para confirmarse y cobrar de todas formas — el reembolso al donador solo se calcula y ejecuta hasta que cierra esa ventana, evitando el conflicto de pagar dos veces por la misma porción.
- ¿Qué decide el donador sobre la porción no estudiada? → Reembolso / Extender plazo / Dejar como donación.

## Friction Points
- 🟡 Duración de la ventana de gracia sin definir formalmente (propuesta informal: 3-5 días) — pendiente de decisión de negocio.
- 🔵 El estado intermedio "vencida, en ventana de gracia" agrega complejidad que hay que manejar con cuidado (similar a otros estados intermedios ya vistos en flujos anteriores: pago en proceso, retiro en proceso).

## Notes
- Depende directamente del flujo "Donador crea una solicitud" (solo aplica a solicitudes con fecha límite) y del flujo "Confirmación de estudio completado" (la ventana de gracia usa la misma lógica de confirmar y cobrar).
- Con este cierran los 7 flujos planeados para este cliente/proyecto.
