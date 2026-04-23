using { ConsultoriaM as my } from '../db/schema';

service ConsultoriaMService {
    @odata.draft.enabled
    entity Doctores as projection on my.Doctores;
    
    @odata.draft.enabled
    entity Pacientes as projection on my.Pacientes;

    @odata.draft.enabled
    entity Turnos as projection on my.Turnos;

    entity Receta as projection on my.Recetas;

    // Entidad virtual para los estados (esto soluciona el problema del desplegable)
    @readonly
    entity EstadosTurno {
        key ID : String;
    }
}

// Anotaciones para los buscadores (Value Helps)
annotate ConsultoriaMService.Turnos with {
    // Configuración del desplegable de Estado como una entidad
    estado @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'EstadosTurno',
            Parameters : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : estado, ValueListProperty : 'ID' }
            ]
        }
    );

    doctor @(Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Doctores',
        Parameters : [
            { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : doctor_ID, ValueListProperty : 'ID' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'nombre' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'apellido' }
        ]
    });

    paciente @(Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Pacientes',
        Parameters : [
            { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : paciente_ID, ValueListProperty : 'ID' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'nombre' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'apellido' }
        ]
    });

    idTurno @readonly;
}

annotate ConsultoriaMService.Turnos with @(
    // 1. Configuración de la Tabla (Lista)
    UI.LineItem: [
        { Value: idTurno, Label: 'ID Turno' },
        { Value: fechaHora, Label: 'Fecha y Hora' },
        { Value: motivo, Label: 'Motivo' },
        { Value: estado, Label: 'Estado' },
        { Value: doctor.apellido, Label: 'Doctor' },
        { Value: paciente.apellido, Label: 'Paciente' }
    ],

    // 2. Título de la página de detalle
    UI.HeaderInfo: {
        TypeName: 'Turno',
        TypeNamePlural: 'Turnos',
        Title: { Value: idTurno }
    },

    // 3. Formulario de creación y edición
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', Label: 'Información General', Target: '@UI.FieldGroup#Formulario' }
    ],

    UI.FieldGroup #Formulario: {
        Data: [
            { Value: idTurno, Label: 'Código de Turno' },
            { Value: fechaHora, Label: 'Fecha y Hora del Turno' },
            { Value: motivo, Label: 'Motivo de la consulta' },
            { Value: estado, Label: 'Estado' },
            { Value: doctor_ID, Label: 'Doctor (Seleccionar)' },
            { Value: paciente_ID, Label: 'Paciente (Seleccionar)' }
        ]
    }
);

// Mapeo de IDs a nombres legibles
annotate ConsultoriaMService.Doctores with {
    ID @Common.Text: { $value: apellido, @UI.TextArrangement: #TextFirst };
}
annotate ConsultoriaMService.Pacientes with {
    ID @Common.Text: { $value: apellido, @UI.TextArrangement: #TextFirst };
}