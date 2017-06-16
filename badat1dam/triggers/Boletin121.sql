--Tabla para pruebas

USE Ejemplos
GO

CREATE TABLE Palabras (
ID SmallInt Not Null Identity Constraint PK_Palabras Primary Key
,Palabra VarChar(30) Null
)

--Nota: No olvides probar cada trigger con diferentes valores.

--Iniciación:
--Sin usar datos modificados
--1.- Queremos que cada vez que se actualice la tabla Palabras aparezca un mensaje diciendo si se han añadido, borrado o actualizado filas.
--Pista: Crea tres triggers diferentes

-- Creamos el primer trigger para cuando se realice un update
GO
CREATE TRIGGER avisoUpdate ON Palabras
AFTER UPDATE 
AS
PRINT('Tabla actualizada correctamente')

--Creamos otro para cuando se realice un delete
GO
CREATE TRIGGER avisoDelete ON Palabras
AFTER DELETE
AS
PRINT('Tabla actualizada correctamente')

--Creamos otro para cuando se realice un delete
GO
CREATE TRIGGER avisoInsert ON Palabras
AFTER INSERT 
AS
PRINT('Tabla actualizada correctamente')

-- TEST

INSERT INTO Palabras (Palabra)
VALUES
('illo')

UPDATE Palabras
SET Palabra='pixita'
WHERE Palabra='illo'

DELETE FROM Palabras
WHERE Palabra='pixita'

--2.- Haz un trigger que cada vez que se aumente o disminuya el número de filas de la tabla Palabras nos diga cuántas filas hay.

GO
ALTER TRIGGER aumentaPalabras ON Palabras
AFTER INSERT AS
DECLARE @filas int
SET @filas = (select count(*) from Palabras)
PRINT('Han aumentado las filas, cantidad filas: '+CAST(@filas AS varchar))

--tests
INSERT INTO Palabras
(Palabra)
Values
('Crack'), ('Máquina'), ('Fiera'), ('Leyenda'), ('Mastodonte'), ('Triceratops'), ('Figura'), ('Mostro'), ('Campeón'), ('Cachalote')

INSERT INTO Palabras
(Palabra)
Values
('Jefe'), ('Artista'), ('Genio'), ('Maestro')

--Medio:
--Se usan inserted y deleted. Si es complicado procesar varias filas, supón que se modifica sólo una.
--3.-  Cada vez que se inserte una fila queremos que se muestre un mensaje indicando "Insertada la palabra ________”

GO
ALTER TRIGGER insertadaPalabra ON Palabras
AFTER INSERT AS
DECLARE @palabra varchar(30)
SET @palabra=(SELECT Palabra FROM inserted)
PRINT('Insertada la palabra '+@palabra)

INSERT INTO Palabras (Palabra) VALUES ('Papaya')

--4.- Cada vez que se inserten filas que nos diga "XX filas insertadas”

GO
ALTER TRIGGER filasInsertadas ON Palabras
AFTER INSERT AS
DECLARE @insertadas int
SET @insertadas=(SELECT COUNT(*) FROM inserted)
PRINT(@insertadas)

INSERT INTO Palabras (Palabra) VALUES ('Socio'),('Compae'), ('Pinfloi'),
('Maikelnai'), ('Fenómeno'), ('Tunante'), ('Héroe'), ('Tigre'), ('Tanque')

select * from palabras
--5.- que no permita introducir palabras repetidas (sin usar UNIQUE).

GO
ALTER TRIGGER palabraRepetidaNope ON Palabras
AFTER INSERT AS
	DECLARE @palabra AS varchar(30)
	DECLARE @id AS smallint
	SET @palabra=(SELECT Palabra FROM inserted)
	SET @id=(SELECT ID from inserted)
	IF EXISTS (SELECT Palabra FROM Palabras WHERE Palabra=@palabra AND ID!=@id)
		BEGIN
			rollback
			RAISERROR('Palabra repetía shur', 16, 1);
		END
GO

insert into palabras (Palabra) values ('Bocachancla')

select * from palabras

--Avanzado:
--Se incluye la posibilidad de que se modifiquen varias filas y de que haya que consultar otras tablas.
--6.- Queremos evitar que se introduzcan palabras que terminen en "azo”

GO
ALTER TRIGGER noAzo ON Palabras
AFTER INSERT AS
	IF EXISTS (SELECT Palabra FROM inserted WHERE Palabra LIKE '%azo')
		BEGIN
			rollback
			RAISERROR('Aquí no se admiten palabras que terminen en azo', 16, 1);
		END
GO
 