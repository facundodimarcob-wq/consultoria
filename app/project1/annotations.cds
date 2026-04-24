using ConsultoriaMService as service from '../../srv/service';
annotate service.Turnos with {
    doctor @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Doctores',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : doctor_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'nombre',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'especialidad',
                },
            ],
        },
        Common.ExternalID : doctor.apellido,
        Common.ValueListWithFixedValues : true,
)};

annotate service.Turnos with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Información General',
            Target : '@UI.FieldGroup#Formulario',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'DOCTOR',
            ID : 'DOCTORES',
            Target : '@UI.FieldGroup#DOCTORES',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Paciente',
            ID : 'Paciente',
            Target : '@UI.FieldGroup#Paciente',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Recetas',
            ID : 'Recetas',
            Target : 'recetas/@UI.LineItem#Recetas',
        },
    ],
    UI.FieldGroup #DOCTORES : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : doctor.apellido,
                Label : 'apellido',
            },
            {
                $Type : 'UI.DataField',
                Value : doctor.nombre,
                Label : 'nombre',
            },
            {
                $Type : 'UI.DataField',
                Value : doctor.ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : doctor.especialidad,
                Label : 'especialidad',
            },
        ],
    },
    UI.FieldGroup #Paciente : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : paciente.apellido,
                Label : 'apellido',
            },
            {
                $Type : 'UI.DataField',
                Value : paciente.nombre,
                Label : 'nombre',
            },
            {
                $Type : 'UI.DataField',
                Value : paciente.dni,
                Label : 'dni',
            },
            {
                $Type : 'UI.DataField',
                Value : paciente.email,
                Label : 'email',
            },
            {
                $Type : 'UI.DataField',
                Value : paciente.ID,
                Label : 'ID',
            },
        ],
    },
);

annotate service.Turnos with {
    paciente @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Pacientes',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : paciente_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'nombre',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'dni',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.ExternalID : paciente.apellido,
        Common.ValueListWithFixedValues : true,
)};

annotate service.Receta with @(
    UI.LineItem #Recetas : [
        {
            $Type : 'UI.DataField',
            Value : turno.recetas.tipo,
            Label : 'tipo',
        },
        {
            $Type : 'UI.DataField',
            Value : turno.recetas.medicamento,
            Label : 'medicamento',
        },
        {
            $Type : 'UI.DataField',
            Value : turno.recetas.indicaciones,
            Label : 'indicaciones',
        },
        {
            $Type : 'UI.DataField',
            Value : turno.recetas.fecha,
            Label : 'fecha',
        },
    ]
);

