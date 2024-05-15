/*
CREANDO Y USANDO LA BASE DE DATOS "los_olimpicos"
*/
CREATE DATABASE IF NOT EXISTS los_olimpicos;
USE los_olimpicos;



/*
CREANDO LAS TABLAS DE LA BASE DE DATOS
*/
-- Creando la tabla "evento_complejo_poli"
CREATE TABLE IF NOT EXISTS evento_complejo_poli(
	id_evento_complejo INT UNSIGNED NOT NULL UNIQUE,
    id_evento INT UNSIGNED NOT NULL,
    id_complejo INT UNSIGNED NOT NULL,
    id_evento_equipo INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS eventos(
	id_evento INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    duracion TIME NOT NULL,
    num_participantes INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS evento_comisario(
	id_evento_comisario INT UNSIGNED NOT NULL UNIQUE,
    id_evento INT UNSIGNED NOT NULL,
    id_comisario INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS comisario(
	id_comisario INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    tipo ENUM('juez', 'observador') NOT NULL
);

CREATE TABLE IF NOT EXISTS evento_complejo_deportivo(
	id_evento_complejo_deportivo INT UNSIGNED NOT NULL UNIQUE,
    id_evento INT UNSIGNED NOT NULL,
    id_complejo_deportivo INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS complejo_deportivo(
	id_complejo_deportivo INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_deporte INT UNSIGNED NOT NULL UNIQUE,
    id_info_complejo INT UNSIGNED NOT NULL,
    id_sede INT UNSIGNED NOT NULL,
    id_evento_equipo INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS evento_equipo(
	id_evento_equipo INT UNSIGNED NOT NULL UNIQUE,
    id_evento INT UNSIGNED NOT NULL,
    id_equipamiento INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS equipamiento(
	id_equipamiento INT UNSIGNED NOT NULL UNIQUE,
    nombre_equipos VARCHAR(100) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE IF NOT EXISTS sede(
	id_sede INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_complejo INT UNSIGNED NOT NULL,
    presupuesto FLOAT NOT NULL,
    id_complejo_deportivo INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS complejo_polideportivo(
	id_complejo_polideportivo INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_deporte INT UNSIGNED NOT NULL,
    id_info_complejo INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS info_complejo(
	id_complejo INT UNSIGNED NOT NULL UNIQUE,
    locacion VARCHAR(100) NOT NULL,
    area_complejo FLOAT NOT NULL,
    id_jefe INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS jefes(
	id_jefe INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    titulo VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS deportes(
	id_deporte INT UNSIGNED NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    num_jugadores INT UNSIGNED NOT NULL
);



/*
AGREGANDO LAS LLAVES PRIMARIAS Y FORÁNEAS A LAS 
TABLAS PREVIAMENTE CREADAS
*/
-- Agregando llave primaria y llave foránea de la tabla "evento_complejo_poli"
ALTER TABLE evento_complejo_poli
ADD CONSTRAINT pk_id_evento_complejo PRIMARY KEY(id_evento_complejo),
ADD CONSTRAINT fk_id_evento_complejo_id_evento FOREIGN KEY(id_evento) REFERENCES eventos(id_evento),
ADD CONSTRAINT fk_id_evento_complejo_id_complejo FOREIGN KEY(id_complejo) REFERENCES complejo_polideportivo(id_complejo_polideportivo),
ADD CONSTRAINT fk_id_evento_complejo_id_evento_equipo FOREIGN KEY(id_evento_equipo) REFERENCES evento_equipo(id_evento_equipo);

-- Agregando llave primaria de la tabla "eventos"
ALTER TABLE eventos
ADD CONSTRAINT pk_eventos PRIMARY KEY(id_evento);

-- Agregando llave primaria y llave foránea de la tabla "evento_comisario"
ALTER TABLE evento_comisario
ADD CONSTRAINT pk_evento_comisario PRIMARY KEY(id_evento_comisario),
ADD CONSTRAINT fk_evento_comisario_id_evento FOREIGN KEY(id_evento) REFERENCES eventos(id_evento),
ADD CONSTRAINT fk_evento_comisario_id_comisario FOREIGN KEY(id_comisario) REFERENCES comisario(id_comisario);

-- Agregando llave primaria de la tabla "comisario"
ALTER TABLE comisario
ADD CONSTRAINT pk_comisario PRIMARY KEY(id_comisario);

-- Agregando llave primaria y llave foránea de la tabla "evento_complejo_polideportivo"
ALTER TABLE evento_complejo_deportivo
ADD CONSTRAINT pk_evento_complejo_deportivo PRIMARY KEY(id_evento_complejo_deportivo),
ADD CONSTRAINT fk_evento_complejo_deportivo_id_evento FOREIGN KEY(id_evento) REFERENCES eventos(id_evento),
ADD CONSTRAINT fk_evento_complejo_deportivo_id_complejo_deportivo FOREIGN KEY(id_complejo_deportivo) REFERENCES complejo_deportivo(id_complejo_deportivo);

-- Agregando llave primaria y llave foránea de la tabla "complejo_deportivo"
ALTER TABLE complejo_deportivo
ADD CONSTRAINT pk_complejo_deportivo PRIMARY KEY(id_complejo_deportivo),
ADD CONSTRAINT fk_complejo_deportivo_id_deporte FOREIGN KEY(id_deporte) REFERENCES deportes(id_deporte),
ADD CONSTRAINT fk_complejo_deportivo_id_info_complejo FOREIGN KEY(id_info_complejo) REFERENCES info_complejo(id_complejo),
ADD CONSTRAINT fk_complejo_deportivo_id_sede FOREIGN KEY(id_sede) REFERENCES sede(id_sede),
ADD CONSTRAINT fk_complejo_deportivo_id_evento_equipo FOREIGN KEY(id_evento_equipo) REFERENCES evento_equipo(id_evento_equipo);

-- Agregando llave primaria y llave foránea de la tabla "evento_equipo"
ALTER TABLE evento_equipo
ADD CONSTRAINT pk_evento_equipo PRIMARY KEY(id_evento_equipo),
ADD CONSTRAINT fk_evento_equipo_id_evento FOREIGN KEY(id_evento) REFERENCES eventos(id_evento),
ADD CONSTRAINT fk_evento_equipo_id_equipamiento FOREIGN KEY(id_equipamiento) REFERENCES equipamiento(id_equipamiento);

-- Agregando llave primaria de la tabla "equipamiento"
ALTER TABLE equipamiento
ADD CONSTRAINT pk_equipamiento PRIMARY KEY(id_equipamiento);

-- Agregando llave primaria y llave foránea de la tabla "sede"
ALTER TABLE sede
ADD CONSTRAINT pk_sede PRIMARY KEY(id_sede),
ADD CONSTRAINT fk_sede_id_complejo FOREIGN KEY(id_complejo) REFERENCES complejo_deportivo(id_complejo_deportivo),
ADD CONSTRAINT fk_sede_id_complejo_deportivo FOREIGN KEY(id_complejo_deportivo) REFERENCES complejo_deportivo(id_complejo_deportivo);

-- Agregando llave primaria y llave foránea de la tabla "complejo_polideportivo"
ALTER TABLE complejo_polideportivo
ADD CONSTRAINT pk_complejo_polideportivo PRIMARY KEY(id_complejo_polideportivo),
ADD CONSTRAINT fk_complejo_polideportivo_id_deporte FOREIGN KEY(id_deporte) REFERENCES deportes(id_deporte),
ADD CONSTRAINT fk_complejo_polideportivo_id_info_complejo FOREIGN KEY(id_info_complejo) REFERENCES info_complejo(id_complejo);

-- Agregando llave primaria y llave foránea de la tabla "info_complejo"
ALTER TABLE info_complejo
ADD CONSTRAINT pk_info_complejo PRIMARY KEY(id_complejo),
ADD CONSTRAINT fk_info_complejo_id_jefe FOREIGN KEY(id_jefe) REFERENCES jefes(id_jefe);

-- Agregando llave primaria de la tabla "jefes"
ALTER TABLE jefes
ADD CONSTRAINT pk_jefes PRIMARY KEY(id_jefe);

-- Agregando llave primaria de la tabla "deportes"
ALTER TABLE deportes
ADD CONSTRAINT pk_deportes PRIMARY KEY(id_deporte);



/*
INSERTANDO LOS DATOS A LAS TABLAS
*/
-- Insertando valores a la tabla "jefes"
INSERT INTO jefes VALUES
(1,'Jose Hernandez','jh@gmail.com','Especialista en Natacion'),
(2,'Camila Perez','cp@gmail.com','Especialista en Voleibol'),
(3,'Ana Rojas','ar@gmail.com','Especialista en Futbool'),
(4,'Carlos Duarte','cd@gmail.com','Especialista en Tennis'),
(5,'Horacio Hernandez','hh@gmail.com','Especialista en Tennis');


-- Insertando valores a la tabla "equipamiento"
INSERT INTO equipamiento VALUES
(1, 'Arcos',5),
(2, 'Pértigas',15),
(3, 'Barras Paralelas',10),
(4, 'Flotadores',35),
(5, 'Raquetas',5),
(6, 'Balones',17);


-- Insertando valores a la tabla "comisario"
INSERT INTO comisario VALUES
(1, 'Diego Rojas','dr@hotmail.com','555-555-12345','juez'),
(2, 'Dracula Rosas','drR@hotmail.com','555-555-67895','juez'),
(3, 'Tomas suarez','ts@hotmail.com','555-555-35485','juez'),
(4, 'Lorena Martinez','lm@hotmail.com','444-555-12345','observador'),
(5, 'Rosa Martinez','Rm@hotmail.com','444-457-12345','observador'),
(6, 'Laura Bermudez','lBer@hotmail.com','444-856-12345','observador');


-- Insertando valores a la tabla "info_complejo"
INSERT INTO info_complejo VALUES
(1, 'Bucaramanga', 5, 2),
(2, 'Giron', 14.2, 1),
(3, 'Floridablanca', 54, 5),
(4, 'Zapatoca', 65, 3),
(5, 'Lebrija', 48, 4),
(6, 'Sangil', 5, 2),
(7, 'Socorro', 14.2, 1),
(8, 'Soacha', 54, 5),
(9, 'Bogota', 65, 3),
(10, 'Chia', 48, 4);


-- Insertando valores a la tabla "deportes"
INSERT INTO deportes VALUES
(1, 'futbol', 11),
(2, 'basketball', 8),
(3, 'tenis', 2),
(4, 'waterpolo', 8),
(5, 'voleyball', 6);


-- Insertando valores a la tabla "complejo_polideportivo"
INSERT INTO complejo_polideportivo VALUES
(1,'Complejo Deportivo Bucaramanga', 4,2),
(2,'Complejo Deportivo Sangil',2,6),
(3,'Complejo Deportivo Soacha', 4,8),
(4,'Complejo Deportivo Bucaramanga', 5,2),
(5,'Complejo Deportivo Sangil',3,6),
(6,'Complejo Deportivo Soacha', 1,8),
(7,'Complejo Deportivo Sangil',1,6),
(8,'Complejo Deportivo Soacha', 5,8);


-- Insertando valores a la tabla "complejo_deportivo"
INSERT INTO complejo_deportivo VALUES
(1,'Complejo Deportivo Giron', 1,2,2,3),
(2,'Complejo Deportivo Floridablanca',3,3,3,2),
(3,'Complejo Deportivo Zapatoca', 2,4,1,1);


-- Insertando valores a la tabla "eventos"
INSERT INTO eventos VALUES
(1, 'Torneo de Tennis','2023-05-12 10:00:00', '01:30:00', 25),
(2, 'Torneo de Microfutbol','2023-11-20 10:00:00', '03:15:00', 75),
(3, 'Torneo de Voleibol','2023-06-02 09:00:00', '05:30:00', 25),
(4, 'Torneo de Natacion','2023-12-12 16:00:00', '02:45:00', 5),
(5, 'Torneo de Futbol','2024-01-04 10:00:00', '01:45:00', 85),
(6, 'Torneo de Futbol ninos','2024-01-04 14:00:00', '01:45:00', 85);


-- Insertando valores a la tabla "evento_complejo_poli"
INSERT INTO evento_complejo_poli VALUES
(1,1,4,1),
(2,3,3,3),
(3,4,7,1),
(4,1,8,2);


-- Insertando valores a la tabla "evento_complejo_deportivo"
INSERT INTO evento_complejo_deportivo VALUES
(1,2,1),
(2,2,2),
(4,5,3),
(5,2,3),
(6,6,3);


-- Insertando valores a la tabla "evento_comisario"
INSERT INTO evento_comisario VALUES
(1,1,1),
(2,3,5),
(3,4,3);


-- Insertando valores a la tabla "evento_equipo"
INSERT INTO evento_equipo VALUES
(1,3,6),
(2,1,5),
(3,4,4);


-- Insertando valores a la tabla "sede"
INSERT INTO sede VALUES
(1,'sede1',1,12.300, 2),
(2,'sede2',5,150000.03, 4),
(3,'sede3',4,34561.215, 6);