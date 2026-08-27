# DISCOVERY OUTPUT
Process: Usuario toma una parte por la app
Date: 2026-08-27

## Trigger (Start Event)
Usuario abre la app para ver la lista de solicitudes abiertas con partes disponibles.

## End Result (End Event)
La parte queda registrada como "tomada" a nombre del usuario. No hay plazo ni seguimiento automático que arranque desde aquí — eso corresponde a un proceso separado (flujo 4: confirmación de estudio completado).

## Participants / Lanes
- Usuario
- Backend (la app es solo interfaz; no toma decisiones propias en este flujo)

## Steps (ordered)
1. Usuario abre la app y ve la lista de solicitudes abiertas con partes disponibles | Responsible: Usuario | Type: user-system
2. Usuario selecciona un Masejet libre | Responsible: Usuario | Type: manual
3. Backend verifica el estatus de verificación del usuario en la tabla de usuarios | Responsible: Backend | Type: automatic-service
4. Backend intenta registrar la toma en partes_tomadas, con bloqueo a nivel de base de datos para evitar condiciones de carrera | Responsible: Backend | Type: automatic-service
5. Si se registró con éxito: la parte desaparece de disponibles para los demás y el usuario ve pantalla de éxito con el Masejet y la solicitud a la que pertenece | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Usuario está verificado? → Si no: se le niega la toma con mensaje específico ("no puedes tomar partes todavía porque tu cuenta está pendiente de verificación"). → Si sí: continúa al intento de registro.
- Condición de carrera (dos usuarios seleccionan el mismo Masejet casi simultáneamente): gana quien la base de datos registre primero, mediante una restricción/constraint que impide duplicados. El segundo intento es rechazado automáticamente y ese usuario ve "esta parte ya no está disponible", con la lista actualizándose.

## Friction Points
- 🟡 Dependencia con el flujo 6 (verificación de usuarios): sin ese flujo funcionando, nadie puede tomar partes.
- 🔵 Requiere una restricción a nivel de base de datos (no un chequeo manual) para evitar que un mismo Masejet se asigne a dos personas al mismo tiempo — si no se implementa correctamente, es un punto real de falla de datos.

## Notes
- No hay actor externo (no interviene Stripe) ni participación del administrador en tiempo real en este flujo — el rol del admin ya ocurrió antes, en el flujo 6 (verificación).
- Sigue el mismo patrón de confirmación que el flujo 1 (pantalla de éxito dentro de la app).
- Sin límite de cuántas partes puede tomar un mismo usuario (a la vez o en total).
- El flujo 4 (confirmación de estudio completado) es la continuación natural, pero es un proceso separado que el usuario dispara cuando decide — no está encadenado automáticamente desde este flujo.
