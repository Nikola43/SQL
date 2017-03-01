USE Northwind
--1. N�mero de clientes de cada pa�s.
SELECT Country, COUNT(*) AS [N�mero de clientes] FROM Customers GROUP BY Country

--------------------------------------------------------------------------------------------------------

--2. N�mero de clientes diferentes que compran cada producto.
SELECT P.ProductName, COUNT(DISTINCT C.CustomerID) AS [Clientes que lo compran] FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--------------------------------------------------------------------------------------------------------

--3. N�mero de pa�ses diferentes en los que se vende cada producto.
SELECT P.ProductName, COUNT(DISTINCT C.Country) AS [Pa�ses que lo compran] FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--------------------------------------------------------------------------------------------------------

--4. Empleados que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�, �Tourti�re� o �Boston Crab Meat�.
SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalik��ri', 'Tourti�re', 'Boston Crab Meat')
--WHERE P.ProductName IN ('ProductoQueNoExiste')

--------------------------------------------------------------------------------------------------------

--5. Empleados que no han vendido nunca �Chartreuse verte� ni �Ravioli Angelo�.
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

--6. N�mero de unidades de cada categor�a de producto que ha vendido cada empleado.
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

--7. Total de ventas (US$) de cada categor�a en el a�o 97.
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

--8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el nombre del producto,
--el pa�s y el n�mero de clientes distintos de ese pa�s que lo han comprado.
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

--9. Total de ventas (US$) en cada pa�s cada a�o.
SELECT YEAR(O.OrderDate) AS [A�o], C.Country, SUM(OD.Quantity*OD.UnitPrice) AS [Ventas(USD)]
FROM [Order Details] AS OD
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY YEAR(O.OrderDate), C.Country
ORDER BY YEAR(O.OrderDate), C.Country

--------------------------------------------------------------------------------------------------------

--10. Producto superventas de cada a�o, indicando a�o, nombre del producto, categor�a y cifra total de ventas.
GO
DROP VIEW Ano_Producto_Unidades
GO
CREATE VIEW Ano_Producto_Unidades AS
SELECT YEAR(O.OrderDate) AS [A�o], P.ProductID, P.ProductName, SUM(OD.Quantity) AS [Unidades vendidas] FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate), P.ProductID, P.ProductName
GO
SELECT [A�o], MAX([Unidades vendidas]) AS [Unidades vendidas del top]
FROM Ano_Producto_Unidades GROUP BY [A�o]
GO
SELECT APU1.A�o, APU2.ProductName, APU1.[Unidades vendidas del top]
FROM Ano_Producto_Unidades AS APU2
INNER JOIN (SELECT [A�o], MAX([Unidades vendidas]) AS [Unidades vendidas del top]
FROM Ano_Producto_Unidades GROUP BY [A�o]) AS APU1
ON APU1.[Unidades vendidas del top] = APU2.[Unidades vendidas]

--------------------------------------------------------------------------------------------------------

--11. Cifra de ventas de cada producto en el a�o 97
--y su aumento o disminuci�n respecto al a�o anterior en US $ y en %.
GO
CREATE VIEW Ano_Producto_Ventas AS
SELECT
	YEAR(O.OrderDate) AS [A�o],
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
	APV1.[Ventas ($)] - APV2.[Ventas ($)] AS [Diferencia a�o anterior ($)],
	APV1.[Ventas ($)]/APV2.[Ventas ($)] AS [Diferencia a�o anterior (%)]
FROM
	Ano_Producto_Ventas AS APV1
INNER JOIN Ano_Producto_Ventas AS APV2
ON APV1.A�o-1 = APV2.A�o
WHERE APV1.A�o = 1997
ORDER BY APV1.A�o

--------------------------------------------------------------------------------------------------------

--12. Mejor cliente (el que m�s nos compra) de cada pa�s.
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

--13. N�mero de productos diferentes que nos compra cada cliente.
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

--14. Clientes que nos compran m�s de cinco productos diferentes.
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

--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el a�o 97.
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

--16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos a�os consecutivos,
--indicando el a�o en que se produjo el aumento.
GO
DROP VIEW Empleados_Ventas
GO
CREATE VIEW Empleados_Ventas AS
SELECT
	E.FirstName,
	E.LastName,
	YEAR(O.OrderDate) AS [A�o],
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
ON EV1.A�o+1 = EV2.A�o
ORDER BY EV1.FirstName, EV1.LastName, EV1.A�o -------------------------------SIN TERMINAR