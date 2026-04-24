namespace ConsultoriaM;
using { cuid, managed } from '@sap/cds/common';

entity Doctores : cuid, managed {
    nombre       : String(100);
    apellido     : String(100);
    especialidad : String(50);
    email        : String(100);
    turnos       : Association to many Turnos on turnos.doctor = $self;
    // Cambiado a Association para evitar conflicto de Draft
    recetas      : Association to many Recetas on recetas.doctor = $self;
}

entity Pacientes : cuid, managed {
    nombre     : String(100);
    apellido   : String(100);
    dni        : String(20);
    telefono   : String(20);
    email      : String(100);
    // ... otros campos
    turnos     : Association to many Turnos on turnos.paciente = $self;
    // ESTA SERÁ LA COMPOSICIÓN PRINCIPAL (El dueño de la receta es el paciente)
    recetas    :  Association to many Recetas on recetas.paciente = $self;
}

entity Turnos : cuid, managed {
    fechaHora    : DateTime;
    idTurno      : String(20);
    motivo       : String(255);
    estado       : String(20) enum { Pendiente; Completado; Cancelado; } default 'Pendiente';
    doctor       : Association to one Doctores;
    paciente     : Association to one Pacientes;
    // Cambiado a Association
    recetas      :  Composition of many  Recetas on recetas.turno = $self;
}

entity Recetas : cuid, managed {
    tipo         : tipo_receta;
    medicamento  : String(50);
    indicaciones : String(255);
    fecha        : Date;
    doctor       : Association to one Doctores;
    paciente     : Association to one Pacientes; // Este es el padre
    turno        : Association to one Turnos;
}

type tipo_receta : String enum { estudio; medicamento; certificado; }