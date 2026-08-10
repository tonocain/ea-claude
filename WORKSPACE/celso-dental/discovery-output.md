# DISCOVERY OUTPUT
Process: Agendar cita de paciente
Date: 2026-07-23

## Trigger (Start Event)
Un paciente (nuevo o recurrente) escribe por WhatsApp Business pidiendo información o cita. Llega desde el botón "HACER CITA" del sitio web, Instagram, o referido de otro paciente.

## End Result (End Event)
El paciente tiene una cita confirmada con el doctor/especialista correspondiente, registrada en la agenda, con recordatorio enviado un día antes.

## Participants / Lanes
- Ale (recepcionista / coordinadora de citas)
- Doctores / especialistas (9 en total, 6 áreas: odontología general, estética dental y prostodoncia, ortodoncia, periodoncia, endodoncia, medicina estética)
- Paciente
- WhatsApp Business
- Google Calendar compartido (+ agenda física de respaldo)

## Steps (ordered)
1. Paciente escribe por WhatsApp | Responsible: Paciente | Type: manual
2. Ale lee el mensaje e identifica qué servicio busca | Responsible: Ale | Type: manual
3. Ale revisa el Calendar/agenda para ver qué doctor tiene espacio | Responsible: Ale | Type: user-system
4. Si el tratamiento cruza especialidades, Ale coordina dos agendas de doctores distintos a mano | Responsible: Ale | Type: manual
5. Ale confirma horario con el paciente por WhatsApp | Responsible: Ale | Type: manual
6. Ale anota la cita en Calendar y, a veces, también en un Excel de seguimiento aparte | Responsible: Ale | Type: user-system
7. Un día antes, Ale manda recordatorio manual por WhatsApp a cada paciente del día siguiente | Responsible: Ale | Type: manual
8. Paciente llega a su cita | Responsible: Paciente | Type: manual

## Decisions
- After step 3: ¿el doctor solicitado tiene horario disponible? → si sí: se agenda directo / si no: Ale ofrece otro horario o doctor
- After step 3: ¿el tratamiento requiere más de un especialista? → si sí: coordinación cruzada manual entre agendas (paso 4) / si no: sigue flujo normal (paso 5)

## Friction Points
- 🔴 Ale es punto único de falla: si no está (día libre, enferma, vacaciones), nadie más sabe coordinar la agenda de los 9 doctores — no hay respaldo documentado del proceso.
- 🟡 Coordinación cruzada entre especialidades se hace a ojo comparando calendarios manualmente, lo que genera choques de horario ocasionales.
- 🔵 Recordatorios del día anterior son manuales: si Ale está saturada, a veces no se mandan y se generan no-shows.
- 🔵 No queda registro estructurado de por qué canal llegó cada paciente (sitio web, Instagram, referido) — se pierde el dato de origen del lead.

## Notes
Datos simulados para fines de demo (grabación de video mostrando el uso de la skill de discovery). El negocio (CELSO, estudio dental y facial en Polanco) y su método actual de agenda (WhatsApp manual, sin CRM) sí provienen de investigación real hecha previamente vía Firecrawl; los nombres de pasos, roles y fricciones específicas fueron inventados por Claude para completar el levantamiento sin una entrevista real al cliente.
