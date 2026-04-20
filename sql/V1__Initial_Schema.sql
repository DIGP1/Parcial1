
CREATE TABLE rango_investigador (
    id_rango SERIAL PRIMARY KEY,
    nombre_rango VARCHAR(100) NOT NULL
);

CREATE TABLE investigador (
    id_investigador SERIAL PRIMARY KEY,
    id_rango INT NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    documento_identidad VARCHAR(50) NOT NULL
);

CREATE TABLE laboratorio (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE equipo (
    id_equipo SERIAL PRIMARY KEY,
    id_laboratorio INT NOT NULL,
    nombre_equipo VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    responsable_mantenimiento VARCHAR(100) NOT NULL
);


CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);


CREATE TABLE detalle_reserva_equipo (
    id_reserva INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_reserva, id_equipo)
);


CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    usuario_db VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    tipo_operacion VARCHAR(20) NOT NULL,
    tabla_afectada VARCHAR(50) NOT NULL,
    detalle_cambio TEXT
);