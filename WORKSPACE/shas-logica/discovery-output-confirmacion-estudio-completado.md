# DISCOVERY OUTPUT
Process: Confirmación de estudio completado
Date: 2026-08-27

## Trigger (Start Event)
Usuario marca como "completado" un Masejet que había tomado previamente, ya sea por la app o avisando por llamada.

## End Result (End Event)
Pago fijo del Masejet acreditado al saldo (monedero) del usuario, con registro en log_usuarios y transacciones. Si esa era la última parte pendiente de la solicitud, la solicitud se marca "completada" y se notifica al donador.

## Participants / Lanes
- Usuario
- App (interfaz, solo en el camino por app)
- Admin (solo en el camino por llamada)
- Backend (sistema)

## Steps (ordered)

### Camino por app
1. Usuario entra a "mis partes tomadas" en la app | Responsible: Usuario | Type: user-system
2. Usuario presiona "completado" en un Masejet (solo ve sus propias partes pendientes) | Responsible: Usuario | Type: manual
3. Backend acredita el pago fijo de ese Masejet al saldo del usuario | Responsible: Backend | Type: automatic-service
4. Backend genera registro en log_usuarios y transacciones | Responsible: Backend | Type: automatic-service
5. Backend checa si esa era la última parte pendiente de la solicitud | Responsible: Backend | Type: automatic-service

### Camino por llamada
1. Usuario llama avisando que terminó | Responsible: Usuario | Type: manual
2. Admin busca al usuario por su número de teléfono en el panel y ve sus partes tomadas pendientes de confirmar (no re-verifica identidad, ya se validó cuando tomó la parte) | Responsible: Admin | Type: user-system
3. Admin selecciona y marca como completada la parte correspondiente | Responsible: Admin | Type: user-system
4. Backend valida que esa parte no esté ya marcada como completada (bloqueo anti-duplicado) | Responsible: Backend | Type: automatic-service
5. Si pasa la validación: mismo efecto que el camino por app — se acredita saldo, se registra en logs, se checa si era la última parte pendiente | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Esa parte era la última pendiente de la solicitud? → Si sí: la solicitud se marca "completada" y se notifica al donador (app + WhatsApp/SMS) de que el Shas ya se terminó de estudiar en su memoria. → Si no: no pasa nada adicional, la solicitud sigue "abierta".
- (Solo camino por llamada) ¿La parte ya estaba marcada como completada? → Si sí: el sistema bloquea el registro duplicado, para evitar acreditar el pago dos veces. → Si no: se procesa normal.

## Friction Points
- 🔴 Toda la confirmación es de buena fe — no hay validación de que el estudio realmente se hizo (ni tiempo mínimo ni evidencia). Riesgo de fraude/abuso, ya que acredita dinero real.
- 🟡 En el camino por llamada, la integridad depende de que el admin seleccione bien al usuario y la parte correctos en su panel — el bloqueo de doble-completado solo mitiga parcialmente (no evita marcar la parte equivocada desde el inicio).
- 🔵 El camino por app está protegido por diseño (el usuario solo ve sus propias partes pendientes), pero el camino por llamada no tiene esa misma barrera estructural.

## Notes
- El saldo es un monedero real dentro de la app con retiro funcional vía Stripe Connect a la CLABE del usuario — ese es el flujo 5 ("retiro de saldo"), que depende de este.
- Ambos caminos (app y llamada) convergen en el mismo efecto final una vez que el backend procesa la confirmación.
