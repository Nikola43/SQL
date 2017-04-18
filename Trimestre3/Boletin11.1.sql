USE Northwind

/* 1. Deseamos incluir un producto en la tabla Products llamado "Cruzcampo lata” pero no estamos seguros si se ha insertado o no.
El precio son 4,40, el proveedor es el 16, la categoría 1 y la cantidad por unidad es "Pack 6 latas” "Discontinued” toma el valor 0 y
el resto de columnas se dejarán a NULL. Escribe un script que compruebe si existe un producto con ese nombre.
En caso afirmativo, actualizará el precio y en caso negativo insertarlo. */

GO
DECLARE @idProducto INT
SELECT @idProducto = (SELECT ProductID FROM Products WHERE ProductName = 'Cruzcampo lata')

IF @idProducto IS NOT NULL
    BEGIN
        PRINT 'Ese producto ya existe en la base de datos, procederemos a actualizar su precio'
        UPDATE Products
            SET UnitPrice = 4.40
        WHERE ProductName = 'Cruzcampo lata'
    END
ELSE
    BEGIN
        PRINT 'Ese producto no existe en la base de datos, procedemos a insertarlo'
        BEGIN TRANSACTION
            INSERT INTO Products
            VALUES ('Cruzcampo lata', 16, 1, 'Pack 6 latas', 4.3, 7,6,6,6)
        COMMIT TRANSACTION
    END

SELECT * FROM Products
    WHERE ProductName = 'Cruzcampo lata'

/* 2. Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID, el Nombre,
      el Precio unitario, el número total de unidades vendidas y el total de dinero facturado con ese producto.
      Si no existe, créala*/

    DECLARE @nombreTabla NVARCHAR(20)
    SET @nombreTabla = 'ProductSa';

    IF OBJECT_ID (@nombreTabla) IS NOT NULL
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' ya existe.'
        END
    ELSE
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' no existe, procederemos a crearla.'

            DECLARE @temp VarChar(1000)

            SET @temp = 'CREATE TABLE ' + @nombreTabla +' (
                -- Columnas
                ProductID INT NOT NULL CONSTRAINT FK_ProductID FOREIGN KEY REFERENCES Products(ProductID)
                ON DELETE CASCADE ON UPDATE CASCADE,
                ProductName nvarchar(40),
                UnitPrice money NULL,
                [Unidades vendidas] int NULL,
                [Total facturado] money NULL
            )'


            EXECUTE (@temp)

            
            
			/*
            -- Insertamos los datos
            INSERT INTO ProductSales
            SELECT P.ProductID, P.ProductName, P.UnitPrice, SUM(OD.Quantity) AS [Unidades vendidas], P.UnitPrice*SUM(OD.Quantity) AS [Total facturado]
            FROM Products AS P
            INNER JOIN [Order Details] AS OD
            ON P.ProductID = OD.ProductID
            GROUP BY P.ProductID,P.ProductName,P.UnitPrice
			

            -- Comprobamos si la tabla fue creada correctamente
            IF OBJECT_ID (@nombreTabla) IS NOT NULL
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' fue creada correctamente.'
                    SELECT * FROM ProductSales
                END
            ELSE
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' no pudo crearse correctamente.'
                END
			*/
        END



/* 3. Comprueba si existe una tabla llamada ShipShip. Esta tabla ha de tener de cada Transportista el ID,
      el Nombre de la compañía, el número total de envíos que ha efectuado y el número de países diferentes
      a los que ha llevado cosas. Si no existe, créala */

    DECLARE @nombreTabla NVARCHAR(20)
    SET @nombreTabla = 'ShipShip';

    IF OBJECT_ID (@nombreTabla) IS NOT NULL
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' ya existe.'
        END
    ELSE
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' no existe, procederemos a crearla.'

            CREATE TABLE ShipShip
            (
                ID_Transportista int,
                CompanyName VARCHAR(40),
                Numero_Total_Envios int,
                Numero_Paises_Provee int,
            )

            IF OBJECT_ID (@nombreTabla) IS NOT NULL
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' fue creada correctamente.'
                END
            ELSE
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' no pudo crearse correctamente.'
                    SELECT * FROM ProductSales
                END
        END


    SELECT S.ShipperID
    FROM Shippers AS S


/* 4. Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID,
      el Nombre completo, el número de ventas totales que ha realizado, el número de clientes diferentes a los
      que ha vendido y el total de dinero facturado. Si no existe, créala */

    DECLARE @nombreTabla NVARCHAR(20)
    SET @nombreTabla = 'EmployeeSales';

    -- Si la tabla existe
    IF OBJECT_ID (@nombreTabla) IS NOT NULL
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' ya existe.'
        END
    ELSE
        BEGIN
            PRINT 'La tabla: '+@nombreTabla+' no existe, procederemos a crearla.'

            -- Sino existe la creamos
            CREATE TABLE EmployeeSales
            (
                EmployeeID INT NOT NULL CONSTRAINT FK_Employee FOREIGN KEY REFERENCES Employees(EmployeeID)
                ON DELETE CASCADE ON UPDATE CASCADE,
                Nombre_Completo VARCHAR(30),
                Numero_Ventas_Totales INT,
                Numero_Clientes_Diferentes INT,
                Total_Dinero_Facturado MONEY
            )

            -- Insertamos datos
            INSERT INTO EmployeeSales
            SELECT E.EmployeeID, E.LastName+' '+E.FirstName, COUNT(O.EmployeeID) AS Numero_Ventas_Totales, COUNT(DISTINCT CustomerID) AS Numero_Clientes_Diferentes, SUM(OD.UnitPrice * OD.Quantity)
            FROM Employees AS E
            INNER JOIN Orders AS O
            ON E.EmployeeID = O.EmployeeID
            INNER JOIN [Order Details] AS OD
            ON O.OrderID = OD.OrderID
            GROUP BY E.EmployeeID, E.LastName, E.FirstName

            -- Comprobamos si todo fue bien
            IF OBJECT_ID (@nombreTabla) IS NOT NULL
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' fue creada correctamente.'
                END
            ELSE
                BEGIN
                    PRINT 'La tabla: '+@nombreTabla+' no pudo crearse correctamente.'
                    SELECT * FROM EmployeeSales
                END
        END

/* 5. Entre los años 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido.
      Queremos cambiar el precio unitario según la siguiente tabla:

        Incremento de ventas    Incremento de precio
      * Negativo         -      -10%
      * Entre 0 y 10%    -      No varía
      * Entre 10% y 50%  -      +5%
      * Mayor del 50%    -      10% con un máximo de 2,25
*/


BEGIN TRANSACTION

 UPDATE Products
 SET unitPrice =
 CASE
    -- Cuando diferencia de ventas sea negativa
    WHEN diferenciaVentasEntre9697.Diferencia < 0
		    THEN (UnitPrice-(UnitPrice*0.10))   -- Establecemos su precio en un -10% menos

    -- Cuando diferencia de ventas sea entre 0  y 10%
	  WHEN diferenciaVentasEntre9697.Diferencia >= 0 AND diferenciaVentasEntre9697.Diferencia <= (Ventas96.CantidadVendida * 0.10)
		    THEN (UnitPrice + 0)	     -- No varia

    -- Cuando diferencia de ventas sea entre 10% y 50%
	  WHEN diferenciaVentasEntre9697.Diferencia >= (Ventas96.CantidadVendida * 0.10) AND diferenciaVentasEntre9697.Diferencia < (Ventas96.CantidadVendida * 0.50)
	      THEN (UnitPrice*1.05)              -- Establecemos su precio en un 5% mas

     -- Cuando diferencia de ventas sea mayor del 50%
    WHEN diferenciaVentasEntre9697.Diferencia >= (Ventas96.CantidadVendida * 0.50)
        THEN
            CASE
                WHEN (UnitPrice*0.10)<2.25
                    THEN (UnitPrice+ (UnitPrice*0.10))
                ELSE
                    (UnitPrice+ 2.25)
            END
 END
 FROM Products

 --COMMIT
 --ROLLBACK

 GO
 -- Vista diferencia 9697
 ALTER VIEW diferenciaVentasEntre9697 AS
 SELECT  OD.ProductID, (V97.cantidadVendida - V96.cantidadVendida) AS Diferencia
 FROM [Order Details] AS OD
 INNER JOIN Ventas96 AS V96
   ON V96.ProductID= OD.ProductID
 INNER JOIN Ventas97 AS V97
   ON	V97.ProductID = OD.ProductID
 GROUP BY OD.ProductID, V96.CantidadVendida, V97.CantidadVendida
GO

-- Vista 96
CREATE VIEW Ventas96 AS
SELECT OD.ProductID, SUM(OD.Quantity) AS CantidadVendida
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY OD.ProductID
GO

-- Vista 97
CREATE VIEW Ventas97 AS
SELECT OD.ProductID, SUM(OD.Quantity) AS CantidadVendida
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY OD.ProductID
GO

SELECT * FROM Ventas97
SELECT * FROM Ventas96
SELECT * FROM diferenciaVentasEntre9697
