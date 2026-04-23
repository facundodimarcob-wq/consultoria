const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
    const { Turnos } = this.entities;

    this.before(['CREATE', 'UPDATE'], 'Turnos', (req) => {
        const { fechaHora } = req.data;

        if (fechaHora) {
            const fechaTurno = new Date(fechaHora);
            const ahora = new Date();

            // --- REGLA 1: No fechas pasadas ---
            if (fechaTurno < ahora) {
                return req.error(400, "No puedes programar un turno para una fecha u hora que ya pasó.", "fechaHora");
            }

            // --- REGLA 2: Horario laboral (08:00 a 18:00) ---
            const hora = fechaTurno.getHours();

            if (hora >= 18 || hora < 8) {
                return req.error(400, "El horario debe estar dentro de la jornada laboral (08:00 a 18:00 hs).", "fechaHora");
            }
        }
    });
});