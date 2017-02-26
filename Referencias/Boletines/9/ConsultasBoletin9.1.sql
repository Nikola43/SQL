USE Northwind

--1  Nombre de los proveedores y número de productos que nos vende cada uno
SELECT s.CompanyName, COUNT(p.ProductID) AS CantidadProductos  FROM Products as p
JOIN Suppliers as s
ON p.SupplierID= s.SupplierID
	--WHERE
	GROUP BY s.CompanyName
	--HAVING
	--ORDER BY
	

--2  Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
SELECT E.FirstName, E.LastName, E.HomePhone FROM Employees as E
JOIN EmployeeTerritories as ET
ON E.EmployeeID=ET.EmployeeID
JOIN Territories as T
ON ET.TerritoryID=T.TerritoryID
	WHERE T.TerritoryDescription IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')
	--GROUP BY
	--HAVING
	--ORDER BY

--3  Número de productos de cada categoría y nombre de la categoría.
SELECT C.CategoryName, COUNT(P.ProductID) as NumeroProductos FROM Products as P
JOIN Categories as C
ON P.CategoryID=C.CategoryID 
	--WHERE
	GROUP BY C.CategoryName
	--HAVING
	--ORDER BY

--4  Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
--SELECT  FROM  
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY

--5  Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.
SELECT * FROM Customers
SELECT E.EmployeeID, E.FirstName, E.LastName, E.HomePhone, C.CompanyName FROM Employees as E
JOIN Orders as O
ON E.EmployeeID=O.EmployeeID
JOIN Customers as C
ON C.CustomerID=O.CustomerID
	WHERE C.CompanyName IN ('Bon app''', 'Meter Franken')
	--GROUP BY
	--HAVING
	--ORDER BY

--6  Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Mexico. *
SELECT EmployeeID, FirstName, LastName, MONTH(BirthDate) AS Month, DAY(BirthDate) AS Day FROM Employees
EXCEPT
SELECT DISTINCT E.EmployeeID, E.FirstName, E.LastName, MONTH(E.BirthDate) AS Month, DAY(E.BirthDate) AS Day FROM Employees as E
	JOIN Orders AS O
	ON E.EmployeeID=O.EmployeeID
	JOIN Customers AS C
	ON O.CustomerID=C.CustomerID
	WHERE C.Country='Mexico'
	--ORDER BY
	
	--LAS DOS VISTAS DEL EXCEPT TIENEN QUE SER IGUALES, LA SEGUNDA DEBE CONTENER EL CONTENIDO DE LA PRIMERA.

--7  Total de ventas en US$ de productos de cada categoría (nombre de la categoría).
SELECT SUM(P.UnitPrice) AS [Precio (US$)], C.CategoryName FROM PRODUCTS as P
INNER JOIN [Order Details] as O
ON O.ProductID=P.ProductID
JOIN Categories as C
ON P.CategoryID=C.CategoryID
	--WHERE 
	GROUP BY C.CategoryName
	--HAVING
	--ORDER BY

--8  Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
SELECT YEAR(O.OrderDate), SUM(OD.Quantity*OD.UnitPrice) as [Precio (US$)], E.FirstName, e.LastName FROM Employees as E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
JOIN [Order Details] AS OD
ON O.OrderID=OD.OrderID
--WHERE
--HAVING
GROUP BY YEAR(O.OrderDate), E.EmployeeID, E.FirstName, E.LastName, e.Address
ORDER BY E.FirstName, E.LastName

--9  Ventas de cada producto en el año 97. Nombre del producto y unidades.
SELECT YEAR(O.OrderDate) as Year, SUM(OD.Quantity*OD.UnitPrice) as [Precio (US$)], E.FirstName, e.LastName FROM Employees as E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
JOIN [Order Details] AS OD
ON O.OrderID=OD.OrderID
WHERE YEAR(O.OrderDate)=1997
--HAVING
GROUP BY YEAR(O.OrderDate), E.EmployeeID, E.FirstName, E.LastName, e.Address
ORDER BY E.FirstName, E.LastName


--10 Cuál es el producto del que hemos vendido más unidades en cada país. *

SELECT 


--11 Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
SELECT E1.FirstName, E1.LastName FROM Employees AS E1
JOIN Employees AS E2
ON E1.ReportsTo=E2.EmployeeID
WHERE E2.FirstName='Andrew' AND E2.LastName='Fuller'

--12 Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.
SELECT E1.EmployeeID, E1.FirstName, E1.LastName, COUNT(E2.EmployeeID) as cuantia FROM Employees AS E1
JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo
	--WHERE
	GROUP BY E1.EmployeeID, E1.FirstName, E1.LastName
	--HAVING
	--ORDER BY
