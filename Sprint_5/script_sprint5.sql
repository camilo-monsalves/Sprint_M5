CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    email VARCHAR(100),
    veces_utilizado INT DEFAULT 1
);

CREATE TABLE operario (
	id_operario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    email VARCHAR(100), 
    veces_servicio INT DEFAULT 1
);

CREATE TABLE soporte (
	id_soporte INT PRIMARY KEY AUTO_INCREMENT,
    id_operario INT,
    id_usuario INT,
    fecha DATE,
    evaluacion INT,
    FOREIGN KEY (id_operario) REFERENCES operario (id_operario),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

-- usuarios

INSERT INTO usuario (nombre, apellido, edad, email, veces_utilizado)
VALUES ('Juan', 'Pérez', 30, 'juan@example.com', 7),
('María', 'Gómez', 25, 'maria@example.com', 2),
('Pedro', 'López', 35, 'pedro@example.com', 3),
('Ana', 'Martínez', 28, 'ana@example.com', 8),
('Luis', 'González', 32, 'luis@example.com', 5);

-- operarios

INSERT INTO operario (nombre, apellido, edad, email, veces_servicio)
VALUES ('Juan', 'Pérez', 30, 'juan@example.com', 9),
('María', 'Gómez', 25, 'maria@example.com', 11),
('Pedro', 'López', 35, 'pedro@example.com', 7),
('Ana', 'Martínez', 28, 'ana@example.com', 14),
('Luis', 'González', 32, 'luis@example.com', 6);

-- soportes

INSERT INTO soporte (id_operario, id_usuario, fecha, evaluacion)
VALUES (1, 1, '2023-07-01', 6),
 (2, 2, '2023-07-02', 9),
 (3, 3, '2023-07-03', 2),
 (4, 4, '2023-07-04', 10),
 (5, 5, '2023-07-05', 6),
 (1, 2, '2023-07-06', 1),
 (3, 4, '2023-07-07', 5),
 (5, 1, '2023-07-08', 8),
 (2, 3, '2023-07-09', 3),
 (4, 5, '2023-07-10', 4);

-- Seleccione las 3 operaciones con mejor evaluación.

SELECT id_soporte, evaluacion
FROM soporte
ORDER BY evaluacion DESC
LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.

SELECT id_soporte, evaluacion
FROM soporte
ORDER BY evaluacion ASC
LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.
SELECT nombre, apellido, veces_servicio
FROM operario
WHERE veces_servicio = ( SELECT MAX(veces_servicio) FROM operario);

-- Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT nombre, apellido, veces_utilizado
FROM usuario
WHERE veces_utilizado = (SELECT MIN(veces_utilizado) FROM usuario);

-- Agregue 10 años a los tres primeros usuarios registrados.

SET AUTOCOMMIT = 0;
START TRANSACTION;

	UPDATE usuario
    SET edad = edad + 10
    LIMIT 3;
    
COMMIT;

SELECT * FROM usuario;

-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email
START TRANSACTION;

ALTER TABLE operario
RENAME COLUMN correo_electronico TO email;

ALTER TABLE usuario
RENAME COLUMN correo_electronico TO email;

COMMIT;

-- Seleccione solo los operarios mayores de 20 años
SELECT nombre, apellido, edad AS 'mayores a 20 años'
FROM operario
WHERE edad > 20;
