-- creacion de relaciones y restricciones
ALTER TABLE investigador
ADD CONSTRAINT fk_investigador_rango
FOREIGN KEY (id_rango) REFERENCES rango_investigador(id_rango)
ON DELETE CASCADE;

ALTER TABLE equipo
ADD CONSTRAINT fk_equipo_laboratorio
FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio)
ON DELETE CASCADE;


ALTER TABLE reserva
ADD CONSTRAINT fk_reserva_investigador
FOREIGN KEY (id_investigador) REFERENCES investigador(id_investigador)
ON DELETE CASCADE;


ALTER TABLE reserva
ADD CONSTRAINT fk_reserva_laboratorio
FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio)
ON DELETE CASCADE;


ALTER TABLE detalle_reserva_equipo
ADD CONSTRAINT fk_detalle_reserva
FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
ON DELETE CASCADE;

ALTER TABLE detalle_reserva_equipo
ADD CONSTRAINT fk_detalle_equipo
FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
ON DELETE CASCADE;

ALTER TABLE laboratorio
ADD CONSTRAINT chk_nivel_bioseguridad
CHECK (nivel_bioseguridad >= 1 AND nivel_bioseguridad <= 4);


ALTER TABLE equipo
ADD CONSTRAINT chk_estado_equipo
CHECK (estado IN ('Operativo', 'Mantenimiento', 'Fuera de Servicio'));


ALTER TABLE reserva
ADD CONSTRAINT chk_horas_reserva_logicas
CHECK (hora_inicio < hora_fin);


--Creacion de indices
CREATE INDEX idx_reserva_fecha ON reserva(fecha_reserva);


CREATE INDEX idx_equipo_laboratorio_fk ON equipo(id_laboratorio);
CREATE INDEX idx_reserva_investigador_fk ON reserva(id_investigador);
CREATE INDEX idx_reserva_laboratorio_fk ON reserva(id_laboratorio);