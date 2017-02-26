USE ejemplo
/* Insertar datos en una columna declarada como Identity */

-- CREAMOS TABLA 
CREATE TABLE AlumnosClase 
(
	ID_Alumno SmallInt Not NULL Identity(1,1),
	Nombre VarChar(30)
)

-- Creamos varios alumnos | El ID_Alumno se sumara en uno con cada alumno creado
INSERT INTO AlumnosClase (Nombre) VALUES ('Pepe')
INSERT INTO AlumnosClase (Nombre) VALUES ('Lola')
INSERT INTO AlumnosClase (Nombre) VALUES ('Fernando Pernambucano')

-- Establecemos Identity_Insert = ON | Para poder insertar el id explicitamente
SELECT ID_Alumno FROM AlumnosClase
SET Identity_Insert AlumnosClase ON

-- Creamos varios alumnos indicando el id que queremos 
INSERT INTO AlumnosClase (ID_Alumno, Nombre) VALUES (5, 'Ramon')
INSERT INTO AlumnosClase (ID_Alumno, Nombre) VALUES (6, 'Amanda')
INSERT INTO AlumnosClase (ID_Alumno, Nombre) VALUES (7, 'Paulo')

-- Establecemos Identity_Insert = OFF | Para volver a dejar Identity_Insert como estaba, asi los ID_Alumnos se sumara en uno con cada alumno añadido
SELECT ID_Alumno FROM AlumnosClase
SET Identity_Insert AlumnosClase OFF

-- Consultamos los alumnos creados
SELECT * FROM AlumnosClase


/* Explicacion: Cuando usamos una tabla para actualizar (o borrar) datos de otra hemos de 
	especificar cómo se relacionan las filas de ambas tablas.
	Para ello incluimos en el WHERE la condición de JOIN, la que en un SELECT pondríamos en ON
*/
CREATE DATABASE EJEMPLO

-- Creamos tabla criaturitas
CREATE TABLE Criaturitas
(
	ID_Criaturita tinyint NOT NULL CONSTRAINT PK_Criaturitas PRIMARY KEY,
	Nombre nvarchar(30) Not NULL,
	Nivel TinyInt NULL Default 0
)

-- Creamos tabla regalos
CREATE TABLE Regalos 
(
	ID_Regalo tinyint NOT NULL CONSTRAINT PK_Regalos PRIMARY KEY,
	Cantida tinyint NOT NULL,
	Tipo nvarchar NOT NULL,
	ID_Criaturita tinyint NOT NULL,
)
	--¿Tuviste problemas bro? todo a la puta?
	--DROP TABLE Regalos
	--DROP TABLE Criaturitas

-- Insertamos unos ejemplos de regalos
INSERT INTO regalos(ID_Regalo, Cantida, Tipo, ID_Criaturita) 
	VALUES ( 3, 5, 'C', 3)
GO

-- Insertamos unos ejemplos de criaturas
INSERT INTO Criaturitas ( ID_Criaturita, Nombre, Nivel)
	VALUES ( 1, 'Paulo', 0)

-- Consultamos las tablas
SELECT * FROM Criaturitas
SELECT * FROM Regalos

GO


-- Actualizando MAL -- Debe haber relacion entre las tablas
BEGIN TRANSACTION
UPDATE Criaturitas
	SET Nivel += 1 -- = SET Nivel = Nivel + 1
	FROM Regalos
	WHERE Regalos.Tipo IN ('S','C')


ROLLBACK
--Commit

-- Actualizando BIEN
BEGIN TRANSACTION
UPDATE Criaturitas
	SET Nivel += 1
	FROM Regalos
	WHERE Regalos.Tipo IN ('S','C')
		AND Criaturitas.ID_Criaturita = Regalos.ID_Criaturita
--ROLLBACK
Commit
