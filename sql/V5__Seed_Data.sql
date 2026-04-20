
INSERT INTO rango_investigador (nombre_rango) VALUES
('Junior'),
('Semi-Senior'),
('Director de Proyecto'), 
('Técnico de Laboratorio'),
('Investigador Principal');


INSERT INTO investigador (id_rango, nombres, apellidos, documento_identidad) VALUES
(1, 'Ana', 'Gómez', '01234567-8'),
(2, 'Carlos', 'Pérez', '02345678-9'),
(3, 'Elena', 'Ruiz', '03456789-0'), 
(4, 'Luis', 'Martínez', '04567890-1'),
(5, 'María', 'López', '05678901-2');


INSERT INTO laboratorio (nombre, nivel_bioseguridad, capacidad) VALUES
('Lab Genética Básica', 1, 20),
('Lab Cultivo Celular', 2, 15),
('Lab Virología', 3, 10),
('Lab Patógenos Peligrosos', 4, 5), 
('Lab Biología Molecular', 2, 12);


INSERT INTO equipo (id_laboratorio, nombre_equipo, estado, responsable_mantenimiento, ultima_revision) VALUES
(1, 'Microscopio Óptico', 'Operativo', 'Juan Ramos', '2025-10-01'),
(2, 'Incubadora CO2', 'Operativo', 'Juan Ramos', '2025-11-15'),
(3, 'Cabina de Bioseguridad', 'Mantenimiento', 'Roberto Díaz', '2025-12-01'),
(4, 'Ultracongelador -80C', 'Operativo', 'Marta Flores', '2025-09-20'),
(5, 'Centrífuga Refrigerada', 'Fuera de Servicio', 'Roberto Díaz', '2025-08-10');


INSERT INTO reserva (id_investigador, id_laboratorio, fecha_reserva, hora_inicio, hora_fin) VALUES
(1, 1, '2026-05-01', '08:00:00', '10:00:00'),
(2, 2, '2026-05-02', '09:00:00', '12:00:00'),
(3, 4, '2026-05-03', '13:00:00', '16:00:00'), 
(4, 3, '2026-05-04', '10:00:00', '11:30:00'),
(5, 5, '2026-05-05', '14:00:00', '17:00:00');

INSERT INTO detalle_reserva_equipo (id_reserva, id_equipo) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 3),
(5, 5);