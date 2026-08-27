# DISCOVERY OUTPUT
Process: Usuario toma una parte por llamada
Date: 2026-08-27

## Trigger (Start Event)
Usuario sin internet recibe SMS de solicitud nueva (broadcast automático disparado en el flujo "Donador crea una solicitud", solo a usuarios verificados) y llama al número de soporte.

## End Result (End Event)
Parte queda registrada como "tomada" a nombre del usuario, con confirmación por SMS.

## Participants / Lanes
- Usuario
- Admin
- Backend (sistema / panel del admin)

## Steps (ordered)
1. Usuario sin internet recibe SMS de solicitud nueva y llama al número de soporte | Responsible: Usuario | Type: manual
2. Admin contesta la llamada | Responsible: Admin | Type: manual
3. Admin verifica en el panel que el usuario esté verificado | Responsible: Admin | Type: user-system
4. Admin registra manualmente en el panel qué Masejet tomó el usuario | Responsible: Admin | Type: user-system
5. Backend intenta guardar la toma en partes_tomadas con la misma protección de base de datos del flujo "Usuario toma una parte por la app" | Responsible: Backend | Type: automatic-service
6. Si se registró con éxito: la parte se marca como tomada y el sistema envía SMS de confirmación al usuario con el Masejet asignado | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Usuario está verificado? → Si no: el admin le explica por teléfono que su cuenta está pendiente de verificación y termina la llamada (para efectos de tomar partes); no se registra nada. → Si sí: continúa al registro.
- ¿La parte sigue disponible al momento de registrar? → Si el Masejet ya fue tomado por alguien más (por ejemplo, vía app un instante antes), la base de datos rechaza el intento; el admin ve el rechazo en su panel y le informa al usuario por teléfono, ofreciéndole otra parte libre. → Si sigue disponible: se registra con éxito.

## Friction Points
- 🟡 Depende del flujo de verificación (flujo 6) igual que la toma por app — sin usuario verificado, no hay toma posible.
- 🟡 Depende de que el admin esté disponible para contestar la llamada — es un solo punto de falla humano para todo este canal (sin admin, no hay toma por teléfono).
- 🔵 Comparte la misma protección de base de datos que la toma por app (constraint en partes_tomadas), así que un conflicto de Masejet ya tomado se resuelve igual, solo que aquí lo ve y comunica el admin en vez de la app.

## Notes
- El SMS que dispara este flujo es el mismo broadcast automático agregado al flujo "Donador crea una solicitud" (paso 9), dirigido solo a usuarios verificados.
- A diferencia de la toma por app, aquí sí hay confirmación por SMS después de colgar, porque el usuario no tiene pantalla de app donde ver el éxito.
- Mismo criterio que la toma por app: sin límite de cuántas partes puede tomar un usuario.
