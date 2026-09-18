DROP DATABASE IF EXISTS medisistema;
CREATE DATABASE medisistema;
USE medisistema;

CREATE TABLE medicos (
    id INT PRIMARY KEY,
    dni VARCHAR(20),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    tipo VARCHAR(50)
);


CREATE TABLE empleados (
    id INT PRIMARY KEY,
    dni VARCHAR(20),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    puesto VARCHAR(50)
);


CREATE TABLE pacientes (
    id INT PRIMARY KEY,
    dni VARCHAR(20),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    medico_id INT,
    FOREIGN KEY (medico_id) REFERENCES medicos(id)
);


CREATE TABLE horarios (
    id INT PRIMARY KEY,
    medico_id INT,
    dia VARCHAR(20),
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (medico_id) REFERENCES medicos(id)
);


CREATE TABLE sustituciones (
    id INT PRIMARY KEY,
    sustituto_id INT,
    sustituido_id INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (sustituto_id) REFERENCES medicos(id),
    FOREIGN KEY (sustituido_id) REFERENCES medicos(id)
);


CREATE TABLE vacaciones_empleados (
    id INT PRIMARY KEY,
    empleado_id INT,
    estado VARCHAR(50),
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

INSERT INTO medicos VALUES
(1, '111111', 'keiler', 'serrano', 'Titular'),
(2, '222222', 'Laura', 'Martinez', 'Titular'),
(3, '333333', 'Jorge', 'Perez', 'Interino'),
(4, '444444', 'yorman', 'Lopez', 'Sustituto');


INSERT INTO empleados VALUES
(1, '555555', 'profe', 'javier', 'ATS'),
(2, '666666', 'Pedro', 'Sanchez', 'Celador');


INSERT INTO pacientes VALUES
(1, '77777', 'Juan', 'Garcia', 1),
(2, '88888', 'Maria', 'Lopez', 1),
(3, '99999', 'Jose', 'Gomez', 2);


INSERT INTO horarios VALUES
(1, 1, 'Lunes', '08:00:00', '14:00:00'),
(2, 2, 'Martes', '09:00:00', '15:00:00'),
(3, 3, 'Lunes', '15:00:00', '20:00:00');


INSERT INTO sustituciones VALUES
(1, 4, 1, '2026-09-10', '2026-09-25'),
(2, 4, 2, '2026-01-01', '2026-01-15');


INSERT INTO vacaciones_empleados VALUES
(1, 1, 'Disfrutada', '2026-07-01', '2026-07-10'),
(2, 1, 'Planificada', '2026-12-20', '2026-12-25');

SELECT 
    m.nombre,
    COUNT(p.id) AS total_pacientes
FROM medicos m
LEFT JOIN pacientes p 
    ON m.id = p.medico_id
GROUP BY m.id, m.nombre;

SELECT 
    e.nombre,
    v.estado,
    SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias
FROM empleados e
JOIN vacaciones_empleados v
    ON e.id = v.empleado_id
GROUP BY e.id, e.nombre, v.estado;

SELECT 
    m.nombre,
    SUM(TIME_TO_SEC(h.hora_fin) - TIME_TO_SEC(h.hora_inicio)) / 3600 AS horas
FROM medicos m
JOIN horarios h
    ON m.id = h.medico_id
GROUP BY m.id, m.nombre
ORDER BY horas DESC;

SELECT 
    m.nombre,
    COUNT(s.id) AS cantidad
FROM medicos m
JOIN sustituciones s
    ON m.id = s.sustituto_id
WHERE m.tipo = 'Sustituto'
GROUP BY m.id, m.nombre;

SELECT 
    COUNT(*) AS actualmente_sustituyendo
FROM sustituciones
WHERE fecha_inicio <= CURDATE()
  AND fecha_fin >= CURDATE();
