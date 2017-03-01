USE Northwind
--1.Nombre de los proveedores y número de productos que nos vende cada uno
SELECT S.CompanyName, COUNT(ProductID) AS [Número de productos que nos vende]
FROM Products AS P
INNER JOIN Suppliers AS S
ON P.SupplierID = S.SupplierID
GROUP BY S.CompanyName

--2.Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
SELECT E.FirstName+E.LastName AS [Nombre completo], E.HomePhone AS [Teléfono] FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET
ON E.EmployeeID = ET.EmployeeID
INNER JOIN Territories AS T
ON ET.TerritoryID = T.TerritoryID
WHERE T.TerritoryDescription IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')

--3.Número de productos de cada categoría y nombre de la categoría.
SELECT C.CategoryName, COUNT(P.ProductID) AS [Número de productos] FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName

--4.Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
SELECT DISTINCT C.CompanyName FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Queso Cabrales','Tofu')

--5.Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.

SELECT DISTINCT(E.FirstName+' '+E.LastName) AS [Nombre Completo], E.LastName, E.HomePhone, C.CompanyName FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE C.CompanyName IN ('Bon app''', 'Meter Franken')

--6.Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. *
SELECT E.EmployeeID, E.FirstName, E.LastName, MONTH(BirthDate) AS [Mes Cumple], DAY(BirthDate) AS [Día Cumple] 
FROM Employees AS E
EXCEPT
SELECT E.EmployeeID, E.FirstName, E.LastName, MONTH(BirthDate) AS [Mes Cumple], DAY(BirthDate) AS [Día Cumple]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE C.Country = 'France'

--7.Total de ventas en US$ de productos de cada categoría (nombre de la categoría).
SELECT C.CategoryName, CAST(ROUND(SUM(OD.UnitPrice*OD.Quantity - OD.UnitPrice*OD.Quantity*OD.Discount),2)AS varchar)+' $' AS Ventas
FROM [Order Details] AS OD
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryID, C.CategoryName


--8.Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
SELECT E.FirstName, E.LastName, E.Address, ROUND(SUM(OD.UnitPrice*OD.Quantity - OD.UnitPrice*OD.Quantity*OD.Discount), 2) AS [Ventas en USD]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.FirstName, E.LastName, E.Address

--9.Ventas de cada producto en el año 97. Nombre del producto y unidades.
SELECT P.ProductName, CAST(SUM(OD.UnitPrice*OD.Quantity)AS varchar)+' €' AS Ventas
FROM Products as P
INNER JOIN [Order Details] AS OD
ON OD.ProductID = P.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductName
ORDER BY P.ProductName

--10.Cuál es el producto del que hemos vendido más unidades en cada país. *
--SUB-SUB-CONSULTA

--11.Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
--12.Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.