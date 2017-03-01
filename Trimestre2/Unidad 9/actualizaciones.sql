--BoletínActualizaciones NorthWind



--CONSULTAS
--Vista que nos devuelva los nombres de todos los clientes que nos han comprado algún  producto de la categoría "Dairy Products”, así como las fechas de la primera y la última compra.
--Además de todo lo anterior, queremos saber también el nombre del distribuidor con el que hicimos el envío. Si hay varios pedidos para el mismo cliente, tomar el distribuidor con el que hicimos el primero de ellos.
--Vista que nos devuelva nombre, ID y número de unidades vendidas de cada producto en el año 1997.
--Modifica la vista anterior para incluir también los productos de los que no hayamos vendido nada, especificando "0” en las unidades

-- ACTUALIZACIONES
-- * 1. Inserta un nuevo cliente.
-------------------------------------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION

	INSERT INTO Customers(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
	VALUES ('MANPE', 'BEATS A MEDIDA', 'Antonio', 'Director', 'C/ aguila', 'Jaen', NULL, '41004', 'España', '91.33.25.75', '91.21.25.76') 

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Véndele (hoy) tres unidades de "Pavlova”, diez de "Inlagd Sill” y 25 de "Filo Mix”. El distribuidor será Speedy Express y el vendedor Laura Callahan.
BEGIN TRANSACTION

	INSERT INTO Orders( CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, 
	ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
	VALUES('MANPE', 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 22.4, 'urdega', 'C/ Shit', 'Bem', NULL, 53362, 'Brazil')  

	INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
	VALUES (12078, 16, 13.90, 3,  0)

	INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
	VALUES (12078, 36, 19,    10, 0)

	INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
	VALUES (12078, 52, 7,     25, 0)

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------------

--  3. Ante la bajada de ventas producida por la crisis, hemos de adaptar nuestros precios según las siguientes reglas:
--3.1 Los productos de la categoría de bebidas (Beverages) que cuesten más de $10 reducen su precio en un dólar.
GO
CREATE VIEW BeveragesCategory AS
SELECT P.CategoryID 
FROM Products as P
join Categories as C
on P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages' AND P.UnitPrice > 10
GROUP BY P.CategoryID
GO

BEGIN TRANSACTION

	UPDATE Products
	SET UnitPrice = UnitPrice -1
	WHERE UnitPrice > 10 AND CategoryID IN ( SELECT * FROM BeveragesCategory)

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
----------------------------------------------------------------------------------------------------------------------

	
-- * 3.2 Los productos de la categoría Lácteos que cuesten más de $5 reducen su precio en un 10%.
BEGIN TRANSACTION 
	SELECT * 
	FROM Products as P
	join Categories as C
	on P.CategoryID = C.CategoryID
	WHERE C.CategoryName = 'Dairy Products' AND P.UnitPrice > 5

	UPDATE Products
	SET UnitPrice = UnitPrice * 0.90
	FROM Categories as C
	WHERE UnitPrice > 5 AND C.CategoryName = 'Dairy Products' AND Products.CategoryID = C.CategoryID
COMMIT TRANSACTION
ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------


-- * 3.3 Los productos de los que se hayan vendido menos de 200 unidades en el último año, reducen su precio en un 5%
-- Vista para consultar los productID de los productos que se han vendido menos de 200 unidades
GO
CREATE VIEW ProductosPocoVendidos AS
SELECT P.ProductID FROM Products AS P
JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductID
HAVING SUM(OD.Quantity) < 200
GO

-- Vista para consultar los cambios del update
GO
CREATE VIEW ProductosVendidos AS
SELECT P.ProductID, P.UnitPrice, SUM(OD.Quantity) AS Numero_Unidades_Vendidas
FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
JOIN Orders AS O 
ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductID, P.UnitPrice
HAVING SUM(OD.Quantity) < 200
GO

BEGIN TRANSACTION 

	UPDATE Products
	SET UnitPrice = UnitPrice * 0.95
	WHERE ProductID IN
	(
		SELECT * FROM ProductosPocoVendidos
	)

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
------------------------------------------------------------------------------------------------------------------------------
-- 4. Inserta un nuevo vendedor llamado Michael Trump. Asígnale los territorios de Louisville, Phoenix, Santa Cruz y Atlanta.

-- Vista para consultar el EmployeeID de Michale Trump
GO
CREATE VIEW MichaelTrumpID AS
SELECT EmployeeID FROM Employees
WHERE FirstName = 'Michael' AND LastName = 'Trump'
GO

-- Vista para consultar los id de los territorios
GO
CREATE VIEW MichaelTrumpTerritories AS
SELECT TerritoryID
FROM Territories
WHERE TerritoryDescription IN ('Louisville', 'Phoenix', 'Santa Cruz', 'Atlanta')
GO

-- Añadimos un nuevo vendedor
BEGIN TRANSACTION

	INSERT INTO Employees (LastName, FirstName)
	VALUES ('Trump', 'Michael')

	-- Asignamos los territorios al vendedor creado anteriormente
	INSERT INTO EmployeeTerritories(EmployeeID, TerritoryID)
	SELECT * FROM MichaelTrumpID CROSS JOIN  MichaelTrumpTerritories

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------------------

--5. Haz que las ventas del año 97 de Robert King que haya hecho a clientes de los estados de California y Texas se le asignen al nuevo empleado.

-- Vista para consultar el EmployeeID del empleado RobertKing
GO
CREATE VIEW RobertKingID AS
SELECT EmployeeID FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King'
GO

-- Vista para consultar los pedidos gestionados por Robert King para california y texas
GO
CREATE VIEW RobertKingClientesID AS
SELECT CustomerID 
FROM Orders
WHERE EmployeeID IN(SELECT * FROM RobertKingID) AND ShipRegion IN ('CA', 'TX') AND YEAR(OrderDate) = 1997
GO

-- Consultamos los pedidos gestionados por el vendedor RobertKing en el año 1997
SELECT * FROM Orders
WHERE EmployeeID IN (SELECT * FROM RobertKingID) AND YEAR(OrderDate) = 1997

-- Consultamos los pedidos gestionados por el vendedor RobertKing para clientes de california y texas (NINGUNO) en el año 1997
SELECT * FROM Orders
WHERE EmployeeID IN (SELECT * FROM RobertKingID) AND CustomerID IN(SELECT * FROM RobertKingClientesID) AND YEAR(OrderDate) = 1997

-- Actualizo los pedidos del año 1997 como ejemplo ya que en ese año no hizo ninguno a california o texas
BEGIN TRANSACTION
	UPDATE Orders
	SET EmployeeID = 
	(
		SELECT * FROM MichaelTrumpID
	)
	WHERE EmployeeID IN(SELECT * FROM RobertKingID) AND YEAR(OrderDate) = 1997
--WHERE EmployeeID IN(SELECT * FROM RobertKingID) AND YEAR(OrderDate) = 1997 AND CustomerID IN(SELECT * FROM RobertKingClientesID) AND YEAR(OrderDate) = 1997  ¿NO ACTUALIZA NADA?
COMMIT TRANSACTION
--ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------------------

--6. Inserta un nuevo producto con los siguientes datos:
--	ProductID: 90
--	ProductName: Miel El Zangano Zumbón
--	SupplierID: 12
--	CategoryID: 3
--	QuantityPerUnit: 10 x 300g
--	UnitPrice: 2,40
--	UnitsInStock: 38
--	UnitsOnOrder: 0
--	ReorderLevel: 0
--	Discontinued: 0

BEGIN TRANSACTION 
	SELECT ProductID FROM Products    -- Selecionamos ProductID
	SET Identity_Insert Products ON   -- Establecemos Identity_Insert como ON Para poder meter un ProductID "A mano"

	-- Da error al insertar explicitamente un product id, por ser primary key, por que se van sumando en uno automaticamente al crear un nuevo producto,
	-- por eso debemos establecer previamente Identity_Insert = ON
	INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
	VALUES (90, 'Miel El Zangano Zumbón', 12, 3, 10 * 300, 2.40, 38, 0, 0, 0)
	SET Identity_Insert Products OFF  -- Volvemos a dejar Identity_Insert como estaba (OFF)
COMMIT TRANSACTION
--ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------------------

--  7. Inserta un nuevo producto con los siguientes datos:
--	ProductID: 91
--	ProductName: Licor de bellotas
--	SupplierID: 1
--	CategoryID: 1
--	QuantityPerUnit: 6 x 75 cl
--	UnitPrice: 7,35
--	UnitsInStock: 14
--	UnitsOnOrder: 0
--	ReorderLevel: 0
--	Discontinued: 0

BEGIN TRANSACTION 

	SELECT ProductID FROM Products    -- Selecionamos ProductID
	SET Identity_Insert Products ON   -- Establecemos Identity_Insert como ON Para poder meter un ProductID "A mano"

	INSERT INTO Products ( ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
	VALUES (91, 'Licor de bellotas', 1, 1, 6 * 75, 7.35, 14, 0, 0, 0)
	SET Identity_Insert Products OFF  -- Volvemos a dejar Identity_Insert como estaba (OFF)

COMMIT TRANSACTION
--ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------------------

--8. Todos los que han comprado "Outback Lager" han comprado cinco años después la misma cantidad de Licor de Bellota al mismo vendedor
GO
CREATE VIEW clientesHanCompradoOutbackLaggerVIEW AS
SELECT C.CustomerID, O.EmployeeID FROM Customers AS C
join Orders AS O ON C.CustomerID = O.CustomerID
join Employees AS E ON O.EmployeeID = E.EmployeeID
join [Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE OD.ProductID IN 
(
	SELECT ProductID FROM Products
	WHERE ProductName = 'Outback Lager' 
)
GO

GO
CREATE VIEW OrdersUnidadesVendidasVendedorView AS
SELECT OD.OrderID, SUM(Quantity) AS Unidades_Vendidas, E.EmployeeID AS VendedorID, YEAR(O.OrderDate) AS OrderYear
FROM [Order Details] AS OD
join Orders AS O ON OD.OrderID = O.OrderID
join Products AS P ON OD.ProductID = P.ProductID
join Employees AS E ON O.EmployeeID = E.EmployeeID
WHERE ProductName IN ('Outback Lager') 
GROUP BY OD.OrderID, E.EmployeeID, O.OrderDate
GO

BEGIN TRANSACTION

	INSERT INTO Orders( CustomerID, EmployeeID, OrderDate)
	SELECT CustomerID
	FROM clientesHanCompradoOutbackLaggerVIEW

	SELECT *
	FROM clientesHanCompradoOutbackLaggerVIEW AS C
	JOIN OrdersUnidadesVendidasVendedorView AS O ON C.EmployeeID = O.VendedorID



	SELECT VendedorID
	FROM OrdersUnidadesVendidasVendedorView

	SELECT OrderYear
	FROM OrdersUnidadesVendidasVendedorView

	--join OrdersUnidadesVendidasVendedorView AS O ON C.EmployeeID = O.VendedorID
	--GROUP BY C.CustomerID, O.VendedorID, O.OrderYear




ROLLBACK TRANSACTION
---------------------------------------------------------------------------------------------------------------------------

--9. El pasado 20 de enero, Margaret Peacock consiguió vender una caja de Miel El Zangano Zumbón a 
--todos los clientes que le habían comprado algo anteriormente. Los datos de envío (dirección, transportista, etc)
--son los mismos de alguna de sus ventas anteriores a ese cliente).