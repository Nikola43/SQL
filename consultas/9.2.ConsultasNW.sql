USE Northwind
--1. Número de clientes de cada país.
SELECT Country, COUNT(*) AS [Número de clientes] FROM Customers GROUP BY Country

--------------------------------------------------------------------------------------------------------

--2. Número de clientes diferentes que compran cada producto.
SELECT P.ProductName, COUNT(DISTINCT C.CustomerID) AS [Clientes que lo compran] FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--------------------------------------------------------------------------------------------------------

--3. Número de países diferentes en los que se vende cada producto.
SELECT P.ProductName, COUNT(DISTINCT C.Country) AS [Países que lo compran] FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--------------------------------------------------------------------------------------------------------

--4. Empleados que han vendido alguna vez “Gudbrandsdalsost”, “Lakkalikööri”, “Tourtière” o “Boston Crab Meat”.
SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalikööri', 'Tourtière', 'Boston Crab Meat')
--WHERE P.ProductName IN ('ProductoQueNoExiste')

--------------------------------------------------------------------------------------------------------

--5. Empleados que no han vendido nunca “Chartreuse verte” ni “Ravioli Angelo”.
SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
EXCEPT
SELECT DISTINCT(E.FirstName+' '+E.LastName) AS [Empleados] FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Chartreuse verte', 'Ravioli Angelo')

--------------------------------------------------------------------------------------------------------

--6. Número de unidades de cada categoría de producto que ha vendido cada empleado.
SELECT E.FirstName, E.LastName, C.CategoryName, SUM(OD.Quantity) AS [Productos vendidos]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
GROUP BY E.EmployeeID, E.FirstName, E.LastName, C.CategoryID, C.CategoryName
ORDER BY E.FirstName, E.LastName, C.CategoryID

--------------------------------------------------------------------------------------------------------

--7. Total de ventas (US$) de cada categoría en el año 97.
SELECT C.CategoryName, SUM(OD.UnitPrice*OD.Quantity) AS [Ventas(USD)] FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY C.CategoryName

--------------------------------------------------------------------------------------------------------

--8. Productos que han comprado más de un cliente del mismo país, indicando el nombre del producto,
--el país y el número de clientes distintos de ese país que lo han comprado.
SELECT P.ProductName, C.Country, COUNT(C.CustomerID) AS [Clientes que lo han comprado] FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY P.ProductName, C.Country
HAVING COUNT(C.CustomerID)>1
ORDER BY COUNT(C.CustomerID)

--------------------------------------------------------------------------------------------------------

--9. Total de ventas (US$) en cada país cada año.
SELECT YEAR(O.OrderDate) AS [Año], C.Country, SUM(OD.Quantity*OD.UnitPrice) AS [Ventas(USD)]
FROM [Order Details] AS OD
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY YEAR(O.OrderDate), C.Country
ORDER BY YEAR(O.OrderDate), C.Country

--------------------------------------------------------------------------------------------------------

--10. Producto superventas de cada año, indicando año, nombre del producto, categoría y cifra total de ventas.
GO
DROP VIEW Ano_Producto_Unidades
GO
CREATE VIEW Ano_Producto_Unidades AS
SELECT YEAR(O.OrderDate) AS [Año], P.ProductID, P.ProductName, SUM(OD.Quantity) AS [Unidades vendidas] FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate), P.ProductID, P.ProductName
GO
SELECT [Año], MAX([Unidades vendidas]) AS [Unidades vendidas del top]
FROM Ano_Producto_Unidades GROUP BY [Año]
GO
SELECT APU1.Año, APU2.ProductName, APU1.[Unidades vendidas del top]
FROM Ano_Producto_Unidades AS APU2
INNER JOIN (SELECT [Año], MAX([Unidades vendidas]) AS [Unidades vendidas del top]
FROM Ano_Producto_Unidades GROUP BY [Año]) AS APU1
ON APU1.[Unidades vendidas del top] = APU2.[Unidades vendidas]

--------------------------------------------------------------------------------------------------------

--11. Cifra de ventas de cada producto en el año 97
--y su aumento o disminución respecto al año anterior en US $ y en %.
GO
CREATE VIEW Ano_Producto_Ventas AS
SELECT
	YEAR(O.OrderDate) AS [Año],
	P.ProductName,
	SUM(OD.Quantity*OD.UnitPrice) AS [Ventas ($)]
FROM Products AS P
	INNER JOIN [Order Details] AS OD
		ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O
		ON OD.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate), P.ProductName
GO

SELECT
	APV1.ProductName,
	APV1.[Ventas ($)],
	APV1.[Ventas ($)] - APV2.[Ventas ($)] AS [Diferencia año anterior ($)],
	APV1.[Ventas ($)]/APV2.[Ventas ($)] AS [Diferencia año anterior (%)]
FROM
	Ano_Producto_Ventas AS APV1
INNER JOIN Ano_Producto_Ventas AS APV2
ON APV1.Año-1 = APV2.Año
WHERE APV1.Año = 1997
ORDER BY APV1.Año

--------------------------------------------------------------------------------------------------------

--12. Mejor cliente (el que más nos compra) de cada país.
GO
CREATE VIEW compania_pais_ventas AS
SELECT
		C.CompanyName,
		C.Country,
		SUM(OD.Quantity*OD.UnitPrice) AS [Ventas]
	FROM
		Customers AS C
		INNER JOIN Orders AS O
		ON C.CustomerID = O.CustomerID
		INNER JOIN [Order Details] AS OD
		ON O.OrderID = OD.OrderID
	GROUP BY
		C.CustomerID, C.CompanyName, C.Country
GO

SELECT
	CPV.Country,
	MAX(CPV.Ventas) AS MaxVentas,
	(SELECT compania_pais_ventas.CompanyName
	FROM compania_pais_ventas WHERE
	compania_pais_ventas.Country = CPV.Country AND
	compania_pais_ventas.Ventas = MAX(CPV.Ventas))
	AS Cliente
FROM
	compania_pais_ventas AS CPV
GROUP BY CPV.Country
ORDER BY CPV.Country

--------------------------------------------------------------------------------------------------------

--13. Número de productos diferentes que nos compra cada cliente.
/*SELECT CompanyName FROM Customers
EXCEPT --????????????????????????????????
*/
SELECT
	C.CompanyName, COUNT(P.ProductID) AS [Productos diferentes]
FROM
	Customers AS C
	INNER JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P
	ON OD.ProductID = P.ProductID
GROUP BY
	C.CompanyName

--------------------------------------------------------------------------------------------------------

--14. Clientes que nos compran más de cinco productos diferentes.
SELECT
	C.CompanyName
FROM
	Customers AS C
	INNER JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P
	ON OD.ProductID = P.ProductID
GROUP BY
	C.CompanyName
HAVING
	COUNT(P.ProductID)>5

--------------------------------------------------------------------------------------------------------

--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el año 97.
GO
DROP VIEW [Ventas por empleados]
GO
CREATE VIEW [Ventas por empleados] AS
SELECT
		E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Dinerito
	FROM
		Employees AS E
		INNER JOIN Orders AS O
		ON E.EmployeeID = O.EmployeeID
		INNER JOIN  [Order Details] AS OD
		ON O.OrderID = OD.OrderID
	WHERE YEAR(O.OrderDate) = 1997
	GROUP BY E.EmployeeID, E.FirstName, E.LastName

GO

SELECT * FROM [Ventas por empleados]
WHERE [Ventas por empleados].Dinerito > (SELECT AVG([Ventas por empleados].Dinerito) FROM [Ventas por empleados])

--------------------------------------------------------------------------------------------------------

--16. Empleados que hayan aumentado su cifra de ventas más de un 10% entre dos años consecutivos,
--indicando el año en que se produjo el aumento.
GO
DROP VIEW Empleados_Ventas
GO
CREATE VIEW Empleados_Ventas AS
SELECT
	E.FirstName,
	E.LastName,
	YEAR(O.OrderDate) AS [Año],
	SUM(OD.Quantity*OD.UnitPrice) AS Ventas
FROM
	Employees AS E
	INNER JOIN Orders AS O
	ON E.EmployeeID = O.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON O.OrderID = OD.OrderID 
GROUP BY
	E.FirstName,
	E.LastName,
	YEAR(O.OrderDate)
GO

SELECT * FROM Empleados_Ventas AS EV1
INNER JOIN Empleados_Ventas EV2
ON EV1.Año+1 = EV2.Año
ORDER BY EV1.FirstName, EV1.LastName, EV1.Año -------------------------------SIN TERMINAR