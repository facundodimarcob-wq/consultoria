const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { Turnos, EstadosTurno } = this.entities;

    // Dropdown de estados
    this.on('READ', EstadosTurno, (req) => {
        return [{ ID: 'Pendiente' }, { ID: 'Completado' }, { ID: 'Cancelado' }];
    });

    this.before(['CREATE'], Turnos, async (req) => {
        // --- GENERACIÓN AUTOMÁTICA DEL ID ---
        // Genera un código aleatorio tipo TRN-1234
        const randomID = Math.floor(1000 + Math.random() * 9000);
        req.data.idTurno = `TRN-${randomID}`;

        // --- LÓGICA DE HORARIOS (La que ya teníamos) ---
        const { fechaHora } = req.data;
        if (fechaHora) {
            const date = new Date(fechaHora);
            let horaReal = date.getUTCHours() - 3; 
            if (horaReal < 0) horaReal += 24;

            const ahora = new Date();
            if (date < ahora.getTime() - 300000) {
                return req.error(400, 'No puedes programar turnos en el pasado.', 'fechaHora');
            }

            const horaApertura = 8;
            const horaCierre = 18;

            if (horaReal < horaApertura || horaReal >= horaCierre) {
                return req.error(400, `La clínica atiende de 8:00 a 18:00 hs. (Detectado: ${horaReal}:00 hs)`, 'fechaHora');
            }
        }
    });
});