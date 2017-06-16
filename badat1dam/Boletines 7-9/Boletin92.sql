USE Northwind
GO

--1. Número de clientes de cada país.

SELECT Country AS País, COUNT(CustomerID) AS Clientes
FROM Customers 
GROUP BY Country 

--2. Número de clientes diferentes que compran cada producto. P>OD>O>C

SELECT P.ProductName AS Producto, COUNT(DISTINCT C.CustomerID) AS Clientes 
	FROM Products AS P 
	INNER JOIN [Order Details] AS OD
	ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O
	ON O.OrderID=OD.OrderID
	INNER JOIN Customers AS C
	ON C.CustomerID=O.CustomerID
	GROUP BY P.ProductName 
	ORDER BY Producto

--3. Número de países diferentes en los que se vende cada producto. P>OD>O

SELECT P.ProductName AS Producto, COUNT(DISTINCT O.ShipCountry) AS Países
	FROM Products AS P
	INNER JOIN [Order Details] AS OD
	ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O
	ON O.OrderID=OD.OrderID
	GROUP BY P.ProductName 
	ORDER BY Producto

--4. Empleados que han vendido alguna vez “Gudbrandsdalsost”, “Lakkalikööri”, “Tourtière” o “Boston Crab Meat”. E>O>OD>P

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellidos
	FROM Employees AS E 
	INNER JOIN Orders AS O
	ON E.EmployeeID=O.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalikööri', 'Tourtière', 'Boston Crab Meat') 

--5. Empleados que no han vendido nunca “Chartreuse verte” ni “Ravioli Angelo”.

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellidos
	FROM Employees AS E 
	INNER JOIN Orders AS O
	ON E.EmployeeID=O.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID
WHERE P.ProductName NOT IN ('Chartreuse verte', 'Ravioli Angelo')

--6. Número de unidades de cada categoría de producto que ha vendido cada empleado. 

SELECT E.FirstName, E.LastName, C.CategoryName, SUM(OD.Quantity) AS Unidades
	FROM Employees AS E
	INNER JOIN Orders AS O ON O.EmployeeID=E.EmployeeID
	INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P ON OD.ProductID=P.ProductID
	INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
	GROUP BY E.FirstName, E.LastName, C.CategoryName
	ORDER BY E.FirstName, E.LastName, C.CategoryName


--7. Total de ventas (US$) de cada categoría en el año 97. OD O P C

SELECT C.CategoryName AS Categoría, YEAR(O.OrderDate) AS Año, SUM(OD.Quantity*OD.UnitPrice) AS TotalVentas
	FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	INNER JOIN Products AS P ON P.ProductID=OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
	WHERE YEAR(O.OrderDate)=1997
	GROUP BY C.CategoryName, YEAR(O.OrderDate)

--8. Productos que han comprado más de un cliente del mismo país, indicando el
--nombre del producto, el país y el número de clientes distintos de ese país que lo han comprado. P OD O C

SELECT P.ProductName AS Producto, O.ShipCountry AS País, COUNT(DISTINCT C.CustomerID) AS Clientes
FROM Products AS P 
INNER JOIN [Order Details] AS OD ON P.ProductID=OD.ProductID
INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
INNER JOIN Customers AS C ON C.CustomerID=O.CustomerID
GROUP BY P.ProductName, O.ShipCountry
HAVING COUNT(DISTINCT C.CustomerID)>1

--9. Total de ventas (US$) en cada país cada año. 

SELECT O.ShipCountry AS País, YEAR(O.OrderDate) AS Año, SUM(OD.Quantity*OD.UnitPrice) AS TotalVentas
	FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
GROUP BY O.ShipCountry, YEAR(O.OrderDate)
ORDER BY O.ShipCountry, YEAR(O.OrderDate)

--10. Producto superventas de cada año, indicando año, nombre del producto, categoría y cifra total de ventas.

SELECT P.ProductName AS Producto, YEAR(O.OrderDate) AS Año, SUM(OD.Quantity) AS Ventas
FROM Products AS P 
INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
GROUP BY P.ProductName, YEAR(O.OrderDate)
HAVING SUM(OD.Quantity) IN
	(
	SELECT MAX(Ventas) AS Ventas
	FROM (
	SELECT P.ProductName AS Producto, YEAR(O.OrderDate) AS Año, SUM(OD.Quantity) AS Ventas
	FROM Products AS P 
	INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	GROUP BY P.ProductName, YEAR(O.OrderDate)
	) AS Sub
	GROUP BY Sub.Año ) 

--11. Cifra de ventas de cada producto en el año 97 y su aumento o disminución respecto al año anterior en US $ y en %. 



--12. Mejor cliente (el que más nos compra) de cada país. C>O
GO
CREATE VIEW [ComprasClientePais]
AS
SELECT C.Country AS País, C.CompanyName AS Cliente, COUNT(O.OrderID) AS PedidosRealizados
	FROM Customers AS C
	JOIN Orders AS O ON O.CustomerID=C.CustomerID
GROUP BY C.Country, C.CompanyName
ORDER BY  C.Country, C.CompanyName, PedidosRealizados
GO

CREATE VIEW [TopCompraPais]
AS
SELECT País, MAX(PedidosRealizados) AS Pedidos
	FROM [ComprasClientePais]
	GROUP BY País
GO
 
SELECT TC.País, CP.Cliente, TC.Pedidos AS CantidadPedidos
	FROM [ComprasClientePais] AS CP
	JOIN [TopCompraPais] AS TC
	ON TC.País=CP.País
WHERE TC.Pedidos=CP.PedidosRealizados
GROUP BY TC.País, CP.Cliente, TC.Pedidos
ORDER BY TC.País, CP.Cliente

--13. Número de productos diferentes que nos compra cada cliente. P OD O C
GO
CREATE VIEW [ClientesProductos]
AS
SELECT C.CompanyName AS Cliente, COUNT(DISTINCT P.ProductID) AS Productos
	FROM Products AS P
	INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	INNER JOIN Customers AS C ON C.CustomerID=O.CustomerID
GROUP BY C.Companyname
ORDER BY Cliente
GO

--14. Clientes que nos compran más de cinco productos diferentes.

SELECT Cliente
	FROM [ClientesProductos]
	WHERE Productos>5

--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el año 97. 
GO
CREATE VIEW[VentasVendedores97]
AS
	SELECT E.FirstName AS Nombre, E.LastName AS Apellidos, SUM(OD.UnitPrice*OD.Quantity) AS VentasEnUSD
		FROM Employees AS E
		INNER JOIN Orders AS O ON O.EmployeeID=E.EmployeeID
		INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
		WHERE YEAR(O.OrderDate)=1997
		GROUP BY E.FirstName, E.LastName
GO

GO

CREATE VIEW[MediaVentas97]
AS
	SELECT AVG(VentasEnUSD) AS Media
	FROM [VentasVendedores97]
GO

SELECT *
	FROM [VentasVendedores97]
	WHERE VentasEnUSD>=(SELECT Media FROM [MediaVentas97])

--16. Empleados que hayan aumentado su cifra de ventas más de un 10% entre dos años consecutivos, indicando el año en que se produjo el aumento.

