USE Northwind
GO

--1. N�mero de clientes de cada pa�s.

SELECT Country AS Pa�s, COUNT(CustomerID) AS Clientes
FROM Customers 
GROUP BY Country 

--2. N�mero de clientes diferentes que compran cada producto. P>OD>O>C

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

--3. N�mero de pa�ses diferentes en los que se vende cada producto. P>OD>O

SELECT P.ProductName AS Producto, COUNT(DISTINCT O.ShipCountry) AS Pa�ses
	FROM Products AS P
	INNER JOIN [Order Details] AS OD
	ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O
	ON O.OrderID=OD.OrderID
	GROUP BY P.ProductName 
	ORDER BY Producto

--4. Empleados que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�, �Tourti�re� o �Boston Crab Meat�. E>O>OD>P

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellidos
	FROM Employees AS E 
	INNER JOIN Orders AS O
	ON E.EmployeeID=O.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalik��ri', 'Tourti�re', 'Boston Crab Meat') 

--5. Empleados que no han vendido nunca �Chartreuse verte� ni �Ravioli Angelo�.

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellidos
	FROM Employees AS E 
	INNER JOIN Orders AS O
	ON E.EmployeeID=O.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID
WHERE P.ProductName NOT IN ('Chartreuse verte', 'Ravioli Angelo')

--6. N�mero de unidades de cada categor�a de producto que ha vendido cada empleado. 

SELECT E.FirstName, E.LastName, C.CategoryName, SUM(OD.Quantity) AS Unidades
	FROM Employees AS E
	INNER JOIN Orders AS O ON O.EmployeeID=E.EmployeeID
	INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P ON OD.ProductID=P.ProductID
	INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
	GROUP BY E.FirstName, E.LastName, C.CategoryName
	ORDER BY E.FirstName, E.LastName, C.CategoryName


--7. Total de ventas (US$) de cada categor�a en el a�o 97. OD O P C

SELECT C.CategoryName AS Categor�a, YEAR(O.OrderDate) AS A�o, SUM(OD.Quantity*OD.UnitPrice) AS TotalVentas
	FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	INNER JOIN Products AS P ON P.ProductID=OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID=P.CategoryID
	WHERE YEAR(O.OrderDate)=1997
	GROUP BY C.CategoryName, YEAR(O.OrderDate)

--8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el
--nombre del producto, el pa�s y el n�mero de clientes distintos de ese pa�s que lo han comprado. P OD O C

SELECT P.ProductName AS Producto, O.ShipCountry AS Pa�s, COUNT(DISTINCT C.CustomerID) AS Clientes
FROM Products AS P 
INNER JOIN [Order Details] AS OD ON P.ProductID=OD.ProductID
INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
INNER JOIN Customers AS C ON C.CustomerID=O.CustomerID
GROUP BY P.ProductName, O.ShipCountry
HAVING COUNT(DISTINCT C.CustomerID)>1

--9. Total de ventas (US$) en cada pa�s cada a�o. 

SELECT O.ShipCountry AS Pa�s, YEAR(O.OrderDate) AS A�o, SUM(OD.Quantity*OD.UnitPrice) AS TotalVentas
	FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
GROUP BY O.ShipCountry, YEAR(O.OrderDate)
ORDER BY O.ShipCountry, YEAR(O.OrderDate)

--10. Producto superventas de cada a�o, indicando a�o, nombre del producto, categor�a y cifra total de ventas.

SELECT P.ProductName AS Producto, YEAR(O.OrderDate) AS A�o, SUM(OD.Quantity) AS Ventas
FROM Products AS P 
INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
GROUP BY P.ProductName, YEAR(O.OrderDate)
HAVING SUM(OD.Quantity) IN
	(
	SELECT MAX(Ventas) AS Ventas
	FROM (
	SELECT P.ProductName AS Producto, YEAR(O.OrderDate) AS A�o, SUM(OD.Quantity) AS Ventas
	FROM Products AS P 
	INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O ON O.OrderID=OD.OrderID
	GROUP BY P.ProductName, YEAR(O.OrderDate)
	) AS Sub
	GROUP BY Sub.A�o ) 

--11. Cifra de ventas de cada producto en el a�o 97 y su aumento o disminuci�n respecto al a�o anterior en US $ y en %. 



--12. Mejor cliente (el que m�s nos compra) de cada pa�s. C>O
GO
CREATE VIEW [ComprasClientePais]
AS
SELECT C.Country AS Pa�s, C.CompanyName AS Cliente, COUNT(O.OrderID) AS PedidosRealizados
	FROM Customers AS C
	JOIN Orders AS O ON O.CustomerID=C.CustomerID
GROUP BY C.Country, C.CompanyName
ORDER BY  C.Country, C.CompanyName, PedidosRealizados
GO

CREATE VIEW [TopCompraPais]
AS
SELECT Pa�s, MAX(PedidosRealizados) AS Pedidos
	FROM [ComprasClientePais]
	GROUP BY Pa�s
GO
 
SELECT TC.Pa�s, CP.Cliente, TC.Pedidos AS CantidadPedidos
	FROM [ComprasClientePais] AS CP
	JOIN [TopCompraPais] AS TC
	ON TC.Pa�s=CP.Pa�s
WHERE TC.Pedidos=CP.PedidosRealizados
GROUP BY TC.Pa�s, CP.Cliente, TC.Pedidos
ORDER BY TC.Pa�s, CP.Cliente

--13. N�mero de productos diferentes que nos compra cada cliente. P OD O C
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

--14. Clientes que nos compran m�s de cinco productos diferentes.

SELECT Cliente
	FROM [ClientesProductos]
	WHERE Productos>5

--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el a�o 97. 
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

--16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos a�os consecutivos, indicando el a�o en que se produjo el aumento.

