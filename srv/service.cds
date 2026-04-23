
using { ConsultoriaM as my } from '../db/schema';

service ConsultoriaMService {
    entity Doctores as projection on my.Doctores;
    entity Pacientes as projection on my.Pacientes;
    entity Turnos as projection on my.Turnos;
    entity Receta as projection on my.Recetas;
}
annotate ConsultoriaMService with @requires :
[
    'authenticated-user'
];
annotate ConsultoriaMService.Turnos with @(
    // 1. Esto configura la Grilla (la lista principal)
    UI.LineItem: [
        { Value: idTurno, Label: 'ID Turno' },
        { Value: fechaHora, Label: 'Fecha y Hora' },
        { Value: motivo, Label: 'Motivo' },
        { Value: estado, Label: 'Estado' },
        { Value: doctor.apellido, Label: 'Doctor' }
    ],
    // 2. Esto configura el Título de la página de edición
    UI.HeaderInfo: {
        TypeName: 'Turno',
        TypeNamePlural: 'Turnos',
        Title: { Value: idTurno }
    },
    // 3. Esto crea los "Casilleros" (el formulario)
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', Label: 'Información General', Target: '@UI.FieldGroup#Formulario' }
    ],
    UI.FieldGroup #Formulario: {
        Data: [
            { Value: idTurno, Label: 'Código de Turno' },
            { Value: fechaHora, Label: 'Fecha y Hora del Turno' },
            { Value: motivo, Label: 'Motivo de la consulta' },
            { Value: estado, Label: 'Estado' },
            { Value: doctor_ID, Label: 'ID del Doctor' },
            { Value: paciente_ID, Label: 'ID del Paciente' }
        ]
    }
);

