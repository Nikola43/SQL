--ACTUALIZACIONES
--Usa la base de datos NorthWind
USE Northwind
GO

--Inserta un nuevo cliente.

INSERT INTO Customers
VALUES('ALBOW', 'Hnos Catetas', 'Alberto Catetas', 'Owner', 'Falsa 123', 'México D.F.', NULL, '05023', 'Mexico', NULL, NULL)

--Véndele (hoy) tres unidades de "Pavlova”, diez de "Inlagd Sill” y 25 de "Filo Mix”. El distribuidor será Speedy Express y el vendedor 
--Laura Callahan. Pedido 11080

INSERT INTO Orders
VALUES
	(--añadir la id porque no sé si es autonumérica o no
	'ALBOW',
	(SELECT EmployeeID FROM Employees WHERE LastName='Callahan' AND FirstName='Laura'),
	CURRENT_TIMESTAMP,
	NULL,
	NULL,
	(SELECT ShipperID FROM Shippers WHERE CompanyName='Speedy Express'),
	NULL,
	'Pedido random añadido lol',
	(SELECT Address FROM Customers WHERE CompanyName='Hnos Catetas'),
	(SELECT City FROM Customers WHERE CompanyName='Hnos Catetas'),
	(SELECT Region FROM Customers WHERE CompanyName='Hnos Catetas'),
	(SELECT PostalCode FROM Customers WHERE CompanyName='Hnos Catetas'),
	(SELECT Country FROM Customers WHERE CompanyName='Hnos Catetas')
	)

INSERT INTO [Order Details]
VALUES (11080,			-- Metemos la Pavlova
		(SELECT ProductID FROM Products WHERE ProductName='Pavlova'),
		(SELECT UnitPrice FROM Products WHERE ProductName='Pavlova'),
		3,
		0
		),
		(11080,			-- Ahora las 10 unidades de Inglagd Sill
		(SELECT ProductID FROM Products WHERE ProductName='Inlagd Sill'),
		(SELECT UnitPrice FROM Products WHERE ProductName='Inlagd Sill'),
		10,
		0
		),
		(11080,			-- Por último las 25 unidades de Filo Mix
		(SELECT ProductID FROM Products WHERE ProductName='Filo Mix'),
		(SELECT UnitPrice FROM Products WHERE ProductName='Filo Mix'),
		25,
		0
		)

--Ante la bajada de ventas producida por la crisis, hemos de adaptar nuestros precios según las siguientes reglas:
--Los productos de la categoría de bebidas (Beverages) que cuesten más de $10 reducen su precio en un dólar.
--Los productos de la categoría Lácteos que cuesten más de $5 reducen su precio en un 10%.
--Los productos de los que se hayan vendido menos de 200 unidades en el último año, reducen su precio en un 5%

UPDATE Products
SET UnitPrice=UnitPrice-1
WHERE (CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName='Beverages')) AND UnitPrice>10

UPDATE Products
SET UnitPrice=UnitPrice*0.9
WHERE (CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName='Dairy Products')) AND UnitPrice>5

UPDATE Products
SET UnitPrice=UnitPrice*0.95
WHERE ProductID in (SELECT P.ProductID
	FROM Products AS P
	INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	WHERE YEAR(O.OrderDate)=1998
	GROUP BY P.ProductID
	HAVING SUM(OD.Quantity)<200)

-- consulta para calcular ud vendidas en el último año (98)
SELECT P.ProductID, SUM(OD.Quantity) AS UdVendidas
	FROM Products AS P
	INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	WHERE YEAR(O.OrderDate)=1998 
	GROUP BY P.ProductID
	ORDER BY P.ProductID

--Inserta un nuevo vendedor llamado Michael Trump. Asígnale los territorios de Louisville, Phoenix, Santa Cruz y Atlanta. id(10)

--Insertamos el vendedor, pondremos solo los datos más importantes, el resto se quedará en null (bicos of lles)
INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy)
VALUES
('Trump', 'Michael', 'Sales Representative', 'Mrs.')

INSERT INTO EmployeeTerritories
VALUES
	((SELECT EmployeeID FROM Employees WHERE LastName='Trump' AND FirstName='Michael'), (SELECT TerritoryID FROM Territories WHERE TerritoryDescription='Louisville')),
	((SELECT EmployeeID FROM Employees WHERE LastName='Trump' AND FirstName='Michael'), (SELECT TerritoryID FROM Territories WHERE TerritoryDescription='Phoenix')),
	((SELECT EmployeeID FROM Employees WHERE LastName='Trump' AND FirstName='Michael'), (SELECT TerritoryID FROM Territories WHERE TerritoryDescription='Santa Cruz')),
	((SELECT EmployeeID FROM Employees WHERE LastName='Trump' AND FirstName='Michael'), (SELECT TerritoryID FROM Territories WHERE TerritoryDescription='Atlanta'))

--Haz que las ventas del año 97 de Robert King que haya hecho a clientes de los estados de California y Texas se le asignen al nuevo empleado.
UPDATE Orders
SET EmployeeID=(SELECT EmployeeID FROM Employees WHERE LastName='Trump' AND FirstName='Michael')
WHERE OrderID IN (SELECT OrderID
	FROM Employees AS E
	INNER JOIN Orders AS O ON O.EmployeeID=E.EmployeeID
	INNER JOIN Customers AS C ON O.CustomerID=C.CustomerID
	WHERE E.LastName='King' AND E.FirstName='Robert' AND YEAR(O.OrderDate)=1997 AND C.Region in ('CA', 'TX'))

-- Consulta para saber las ventas del año 97 de robert king que haya hecho a clientes de california y texas
SELECT OrderID
	FROM Employees AS E
	INNER JOIN Orders AS O ON O.EmployeeID=E.EmployeeID
	INNER JOIN Customers AS C ON O.CustomerID=C.CustomerID
	WHERE E.LastName='King' AND E.FirstName='Robert' AND YEAR(O.OrderDate)=1997 AND C.Region in ('CA', 'TX')

--Inserta un nuevo producto con los siguientes datos:
--ProductID: 90
--ProductName: Nesquick Power Max
--SupplierID: 12
--CategoryID: 3
--QuantityPerUnit: 10 x 300g
--UnitPrice: 2,40
--UnitsInStock: 38
--UnitsOnOrder: 0
--ReorderLevel: 0
--Discontinued: 0

-- Necesitamos desactivar la restriccion de la primary key para añadir un ID a mano
⁠⁠⁠SET IDENTITY_INSERT Products ON

INSERT INTO Products
VALUES
(90, 'Nesquick Power Max', 12, 3, '10 x 300g', 2.40, 38, 0, 0, 0)

--Inserta un nuevo producto con los siguientes datos:
--ProductID: 91
--ProductName: Mecca Cola
--SupplierID: 1
--CategoryID: 1
--QuantityPerUnit: 6 x 75 cl
--UnitPrice: 7,35
--UnitsInStock: 14
--UnitsOnOrder: 0
--ReorderLevel: 0
--Discontinued: 0

INSERT INTO Products
VALUES
(91, 'Mecca Cola', 1, 1, '6 x 75 cl', 7.35, 14, 0, 0, 0)

--Quitamos el Set identity_insert que hemos activado para meter los ProductID
⁠⁠⁠Set identity_insert Products OFF

--Todos los que han comprado "Outback Lager" han comprado cinco años después la misma cantidad de Mecca Cola al mismo vendedor

--Consulta para obtener los clientes que han comprado Outback Lager
SELECT DISTINCT C.CustomerID
	FROM Customers AS C
	INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
	INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P ON P.ProductID=OD.ProductID
	WHERE P.ProductName='Outback Lager'

--BEGIN TRANSACTION

INSERT INTO Orders
VALUES
((SELECT DISTINCT C.CustomerID
FROM Customers AS C
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
WHERE P.ProductName='Outback Lager'),
(SELECT DISTINCT O.EmployeeID
FROM Customers AS C
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
WHERE P.ProductName='Outback Lager'),
(SELECT DISTINCT DATEADD(YEAR, 5, O.OrderDate)
FROM Customers AS C
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
INNER JOIN Products AS P ON P.ProductID=OD.ProductID
WHERE P.ProductName='Outback Lager'),
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
)

INSERT INTO [Order Details]
VALUES
	(--FALTA EL ID NEGRO
	(SELECT DISTINCT C.CustomerID
	FROM Customers AS C
	INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
	INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P ON P.ProductID=OD.ProductID
	WHERE P.ProductName='Outback Lager'),
	(SELECT UnitPrice FROM Products WHERE ProductName='Mecca Cola'),
	(SELECT DISTINCT OD.Quantity
	FROM Customers AS C
	INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
	INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P ON P.ProductID=OD.ProductID
	WHERE P.ProductName='Outback Lager'),
	0
	)

	--NI PUTÍSIMA IDEA LOCO, PREGUNTAR A ALGUIEN

--ROLLBACK TRANSACTION

--El pasado 20 de enero, Margaret Peacock consiguió vender una caja de Nesquick Power Max a todos los clientes que le habían comprado algo 
--anteriormente. Los datos de envío (dirección, transportista, etc) son los mismos de alguna de sus ventas anteriores a ese cliente).



--CONSULTAS

--Vista que nos devuelva los nombres de todos los clientes que nos han comprado algún  producto de la categoría "Dairy Products”, así como las fechas de la primera y la última compra.



--Además de todo lo anterior, queremos saber también el nombre del distribuidor con el que hicimos el envío. Si hay varios pedidos para el mismo cliente, tomar el distribuidor con el que hicimos el 
--primero de ellos.



--Vista que nos devuelva nombre, ID y número de unidades vendidas de cada producto en el año 1997.



--Modifica la vista anterior para incluir también los productos de los que no hayamos vendido nada, especificando "0” en las unidades

