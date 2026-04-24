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
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : doctor.apellido,
    )
};

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
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : paciente.apellido,
    )
};

annotate service.Turnos with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'TURNOS',
            Target : '@UI.FieldGroup#Formulario',
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
                Value : doctor.especialidad,
                Label : 'especialidad',
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
                Value : doctor.email,
                Label : 'email',
            },
        ],
    },
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
);

annotate service.Doctores with @(
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : apellido,
            Label : 'apellido',
        },
        {
            $Type : 'UI.DataField',
            Value : nombre,
            Label : 'nombre',
        },
        {
            $Type : 'UI.DataField',
            Value : especialidad,
            Label : 'especialidad',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View Doctores',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'DOCTORES',
            ID : 'DOCTORES',
            Target : '@UI.FieldGroup#DOCTORES',
        },
    ],
    UI.FieldGroup #DOCTORES : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : apellido,
                Label : 'apellido',
            },
            {
                $Type : 'UI.DataField',
                Value : nombre,
                Label : 'nombre',
            },
            {
                $Type : 'UI.DataField',
                Value : especialidad,
                Label : 'especialidad',
            },
        ],
    },
);

annotate service.Doctores with {
    apellido @Common.ExternalID : nombre
};

