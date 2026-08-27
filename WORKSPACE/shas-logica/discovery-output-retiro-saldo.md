# DISCOVERY OUTPUT
Process: Retiro de saldo
Date: 2026-08-27

## Trigger (Start Event)
Usuario (o admin a su nombre, por llamada) solicita retirar saldo disponible de su monedero.

## End Result (End Event)
Monto transferido vía Stripe Connect a la CLABE registrada del usuario, saldo actualizado, con registro en transacciones y log_usuarios.

## Participants / Lanes
- Usuario
- App (interfaz, camino por app)
- Admin (camino por llamada)
- Stripe Connect (externo)
- Backend (sistema)

## Steps (ordered)

### Camino por app
1. Usuario entra a la app y ve su saldo disponible | Responsible: Usuario | Type: user-system
2. Usuario presiona "retirar" e indica el monto (retiro parcial permitido, mínimo $1,000 MXN) | Responsible: Usuario | Type: user-system
3. Backend verifica que tenga cuenta de Stripe Connect conectada; si no existe, intenta crearla con su CLABE registrada | Responsible: Backend | Type: automatic-service
4. Backend marca el monto como "retiro en proceso" (no se resta del saldo disponible todavía, pero se congela para evitar que se pida en otro retiro simultáneo) | Responsible: Backend | Type: automatic-service
5. Backend solicita la transferencia a Stripe Connect | Responsible: Backend | Type: automatic-service
6. Si Stripe confirma éxito: se resta el saldo de forma definitiva y se registra en transacciones y log_usuarios | Responsible: Backend | Type: automatic-service

### Camino por llamada
1. Usuario sin internet llama pidiendo retirar | Responsible: Usuario | Type: manual
2. Admin busca el saldo disponible del usuario en el panel | Responsible: Admin | Type: user-system
3. Si cumple el mínimo, admin inicia el retiro a nombre del usuario desde su panel | Responsible: Admin | Type: user-system
4-6. Misma lógica que el camino por app (verificar/crear cuenta Stripe Connect, congelar monto, solicitar transferencia, resta definitiva solo si Stripe confirma éxito) | Responsible: Backend | Type: automatic-service

## Decisions
- ¿Monto solicitado cumple el mínimo de $1,000 MXN? → Si no: no se permite continuar con el retiro. → Si sí: continúa.
- ¿La cuenta de Stripe Connect se creó/existe correctamente? → Si falla (CLABE inválida o rechazada por Stripe): usuario ve un error específico y queda bloqueado de retirar hasta corregir su CLABE en su perfil (editable en cualquier momento), luego reintenta. → Si sí: continúa a la transferencia.
- ¿Stripe confirma la transferencia? → Si sí: saldo se resta de forma definitiva, transacción registrada. → Si falla: el saldo vuelve a estar disponible como antes (se libera el monto congelado), se avisa al usuario que el retiro falló y puede reintentar.

## Friction Points
- 🟡 El mínimo de $1,000 MXN existe por el costo fijo de comisión de Stripe por transferencia — es una decisión de negocio, no técnica.
- 🔵 El monto "congelado" durante el proceso evita retiros duplicados simultáneos, pero depende de que ese estado intermedio se maneje correctamente (mismo patrón de cuidado que el flujo de creación de solicitud con el pago).

## Notes
- Este flujo depende del flujo "Confirmación de estudio completado", que es la única forma de generar saldo.
- El camino por llamada sigue el mismo patrón que los flujos de toma de partes y confirmación de estudio: mismo efecto final, distinto disparador (admin en vez de usuario directamente).
