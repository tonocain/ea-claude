# DISCOVERY OUTPUT
Process: Donador crea una solicitud
Date: 2026-08-27

## Trigger (Start Event)
Donador abre la app para crear una nueva solicitud de dedicatoria (Shas).

## End Result (End Event)
Solicitud queda "abierta" en el sistema, con todas las partes (Masejtot) del catálogo elegido generadas y disponibles para ser tomadas.

## Participants / Lanes
- Donador
- App (interfaz)
- Stripe (externo)
- Backend (sistema)

## Steps (ordered)
1. Donador abre la app e inicia la creación de una solicitud | Responsible: Donador | Type: manual
2. Donador llena el formulario: elige tipo de Shas (Mishná o Guemará), fecha límite (opcional), y nombre de dedicatoria "en memoria de" (obligatorio) | Responsible: Donador | Type: user-system
3. App muestra el precio fijo correspondiente al tipo elegido (monto único, no se multiplica por Masejet) | Responsible: App | Type: automatic-service
4. Donador paga con tarjeta vía Stripe | Responsible: Donador + Stripe | Type: user-system
5. Stripe procesa el cobro y responde éxito/rechazo al backend | Responsible: Stripe | Type: automatic-service
6. Backend consulta el catálogo de Masejtot correspondiente al tipo elegido y genera todas las partes disponibles | Responsible: Backend | Type: automatic-service
7. Backend confirma la solicitud como "abierta" (solo si el paso 6 fue exitoso) | Responsible: Backend | Type: automatic-service
8. App muestra pantalla de éxito (tipo de Shas, monto, dedicatoria) y envía confirmación por WhatsApp/SMS; Stripe manda su propio recibo de pago por separado | Responsible: App | Type: automatic-service

## Decisions
- Después del paso 5: ¿Stripe aprueba el pago? → Si no: nada se guarda en la base, el donador ve un mensaje de error (tarjeta rechazada, fondos insuficientes, etc.) y puede reintentar sin límite de intentos; no se crea ningún registro. → Si sí: continúa al paso 6.
- Después del paso 6: ¿Se generaron las partes correctamente? → Si sí: se confirma todo junto (solicitud abierta + partes generadas), pasa al paso 8. → Si no: el backend reintenta automáticamente la generación un par de veces; si sigue fallando, la solicitud se marca como "error, requiere revisión" y se notifica al admin en su panel (el pago ya se cobró, así que nunca se deja como si nada hubiera pasado).
- Selección de tipo de Shas: si el catálogo de un tipo está vacío o mal configurado, el sistema impide que el donador pueda elegir esa opción, para evitar cobrar por algo que no se puede generar.
- Fecha límite: si el donador no la especifica, la solicitud queda abierta indefinidamente sin ningún default del sistema. Esto la excluye del futuro flujo de "vencimiento de solicitud", que solo aplica a solicitudes con fecha límite puesta.

## Friction Points
- 🔴 Pago exitoso pero falla la generación de partes: caso crítico porque hay dinero cobrado sin que el sistema haya cumplido su parte. Mitigado con reintentos automáticos + alerta al admin, pero sigue siendo un punto a vigilar de cerca.
- 🔵 Sin fecha límite, la solicitud puede quedar "abierta" indefinidamente sin ningún mecanismo de seguimiento automático (hasta que exista el flujo de vencimiento, que solo cubre las que sí tienen fecha).

## Notes
- Catálogos de Mishná y Guemará son independientes entre sí: distinta cantidad de Masejtot y distinto precio fijo cada uno.
- El administrador no participa en este flujo puntual — su intervención empieza después, en verificación de usuarios o en el registro de tomas por llamada.
- Este es el primero de una serie de flujos relacionados que el cliente irá entregando. El flujo de "vencimiento de solicitud" depende de este (solo aplica a solicitudes con fecha límite).
