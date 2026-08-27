# DISCOVERY OUTPUT
Process: Verificación de usuario por el admin
Date: 2026-08-27

## Trigger (Start Event)
Usuario se registra en la app con teléfono y confirma OTP.

## End Result (End Event)
Usuario queda "verificado" (puede tomar partes) o "rechazado" (puede corregir sus datos y reintentar sin límite de intentos).

## Participants / Lanes
- Usuario
- App (interfaz)
- Backend (sistema)
- Admin (puede haber varios en paralelo)

## Steps (ordered)
1. Usuario se registra con teléfono y confirma OTP (verificación automática de que el número es real) | Responsible: Usuario + App | Type: user-system
2. Usuario llena sus datos: nombre, Kolel, CLABE | Responsible: Usuario | Type: user-system
3. Backend marca al usuario en estatus "pendiente" y notifica a los admins (WhatsApp/SMS o notificación en panel) que hay un registro nuevo | Responsible: Backend | Type: automatic-service
4. Un admin entra a la cola de pendientes y abre el registro de un usuario para revisarlo | Responsible: Admin | Type: user-system
5. Backend marca ese registro como "en revisión por [admin]" para bloquear que otro admin lo tome al mismo tiempo (mismo patrón que la toma de Masejtot) | Responsible: Backend | Type: automatic-service
6. Admin revisa con base en su conocimiento de la comunidad (reconoce el nombre/Kolel, o contacta al usuario directamente si tiene duda) y aprueba o rechaza | Responsible: Admin | Type: manual
7. Backend actualiza el estatus del usuario y registra la acción en log_admin | Responsible: Backend | Type: automatic-service
8. Backend notifica al usuario por WhatsApp/SMS el resultado (con motivo si fue rechazo) | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Admin aprueba? → Si sí: usuario pasa a "verificado", ya puede tomar partes. → Si no: admin escribe un motivo breve, usuario queda "rechazado", puede corregir sus datos y reenviar tantas veces como haga falta, sin límite de intentos.

## Friction Points
- 🔴 No hay documento de identidad de por medio — la verificación depende enteramente del conocimiento personal del admin sobre la comunidad (reconocer nombres/Kolelim), lo cual es subjetivo y no escala bien si crece la base de usuarios o cambia el admin.
- 🔵 El bloqueo "en revisión por [admin]" evita que dos admins procesen al mismo usuario a la vez — mismo patrón que la protección de partes_tomadas.

## Notes
- Puede haber varios administradores en paralelo — de ahí la importancia de log_admin para saber quién hizo qué.
- Este flujo es prerequisito de los flujos "Usuario toma una parte por la app", "Usuario toma una parte por llamada" y, por extensión, "Confirmación de estudio completado" y "Retiro de saldo" — nadie puede tomar partes, completar estudio, ni retirar saldo sin pasar primero por aquí.
