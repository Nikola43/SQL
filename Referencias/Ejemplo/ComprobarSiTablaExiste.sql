-- Comprobando si en la tabla sysobjects existe alguna tabla con el nombre que buscamos
SELECT id 
FROM sysobjects
WHERE name = 'Products'


-- Comprobar si existe una tabla
-- Buscando si tiene un objetID, si tiene un id asignado es que existe la tabla
BEGIN TRANSACTION
IF OBJECT_ID('ProductSales') IS NULL
	BEGIN
		Print 'La tabla ProductSales no existe, procederemos a crearla' 
		CREATE TABLE ProductSales
		(
			ID int NOT NULL CONSTRAINT PKProduct PRIMARY KEY,
			Name	   varchar(20) NOT NULL,
			UnitPrice  tinyint	   NOT NULL,
			TotalSales int		   NOT NULL,
			TotalMoney int         NOT NULL,
		) 
	END
ELSE
	BEGIN
		Print 'La tabla ProductSales si existe'
	END
ROLLBACK TRANSACTION