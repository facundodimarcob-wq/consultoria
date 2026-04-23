namespace ConsultoriaM;

using { cuid, managed } from '@sap/cds/common';

entity Doctores : cuid, managed {
    nombre       : String(100);
    apellido     : String(100);
    especialidad : String(50);
    email        : String(100);
    turnos       : Association to many Turnos on turnos.doctor = $self;
    recetas      : Association to many Recetas on recetas.doctor = $self;
}

entity Pacientes : cuid, managed {
    nombre          : String(100);
    apellido        : String(100);
    dni             : String(20);
    telefono        : String(20);
    email           : String(100);
    edad            : String(100);
    obraSocial      : String(100);
    carnet          : String(100);
    turnos          : Association to many Turnos on turnos.paciente = $self;
    recetas         : Association to many Recetas on recetas.paciente = $self;
}

entity Turnos : cuid, managed {
    fechaHora    : DateTime;
    idTurno      : String(20);
    especialidad : String(50);
    motivo       : String(255);
    
    // AQUÍ ESTÁ LA MAGIA: El enum va directo en el campo
    estado       : String(20) enum {
        Pendiente  = 'Pendiente';
        Completado = 'Completado';
        Cancelado  = 'Cancelado';
    } default 'Pendiente';
    
    doctor       : Association to one Doctores;
    paciente     : Association to one Pacientes;
    recetas      : Association to many Recetas on recetas.turno = $self;
}

entity Recetas : cuid, managed {
    tipo     : tipo_receta;
    fecha    : Date;
    doctor   : Association to one Doctores;
    paciente : Association to one Pacientes;
    turno    : Association to one Turnos;
}

// Mantenemos solo el de receta si quieres
type tipo_receta : String enum {
    estudio;
    medicamento;
    certificado;
}