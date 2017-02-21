USE Northwind
--Unidad 9.2
--PROBLEMA

--1. Número de clientes de cada país.
SELECT COUNT(CustomerID) AS [Numero de Clientes], Country
FROM Customers
GROUP BY Country
ORDER BY Country

--2. Número de clientes diferentes que compran cada producto.
SELECT COUNT( DISTINCT C.CustomerID) AS Cliente, OD.ProductID
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID

--3. Número de países diferentes en los que se vende cada producto.
SELECT COUNT(DISTINCT O.ShipCountry) AS [Número de países diferentes], P.ProductName
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--4. Empleados que han vendido alguna vez “Gudbrandsdalsost”, “Lakkalikööri”,
--“Tourtière” o “Boston Crab Meat”.
SELECT DISTINCT E.FirstName, E.LastName, P.ProductName
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalikööri', 'Tourtière', 'Boston Crab Meat' )


--5. Empleados que no han vendido nunca “Chartreuse verte” ni “Ravioli Angelo”.
SELECT DISTINCT E.FirstName, E.LastName, P.ProductName
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE P.ProductName NOT IN ('Chartreuse verte', 'Ravioli Angelo')

--6. Número de unidades de cada categoría de producto que ha vendido cada empleado.
SELECT SUM(OD.Quantity) AS [Numero de unidades], C.CategoryID, E.FirstName
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
GROUP BY E.FirstName, C.CategoryID
ORDER BY E.FirstName, C.CategoryID

--7. Total de ventas (US$) de cada categoría en el año 97.
SELECT SUM(OD.Quantity * OD.UnitPrice) AS [Total Ventas], C.CategoryName
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
WHERE YEAR(O.OrderDate) = '1997' 
GROUP BY C.CategoryName

--8. Productos que han comprado más de un cliente del mismo país, indicando el
--nombre del producto, el país y el número de clientes distintos de ese país que lo han comprado.
SELECT P.ProductName, C.Country, COUNT( DISTINCT C.CustomerID) AS NumeroClientes
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName, C.Country
HAVING COUNT( DISTINCT C.CustomerID) > 1

--9. Total de ventas (US$) en cada país cada año.
SELECT CAST(SUM((OD.UnitPrice * Quantity) - (OD.UnitPrice * Quantity * Discount) ) AS smallmoney) AS TotalVentas, S.CompanyName , YEAR(O.OrderDate) AÑO
FROM Suppliers AS S
INNER JOIN Products AS P
ON S.SupplierID = P.SupplierID
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), S.CompanyName

--10. Producto superventas de cada año, indicando año, nombre del producto, categoría y cifra total de ventas.
--11. Cifra de ventas de cada producto en el año 97 y su aumento o disminución respecto al año anterior en US $ y en %.

--12. Mejor cliente (el que más nos compra) de cada país.
SELECT DISTINCT C.CompanyName, C.Country ,MAX(OD.UnitPrice * OD.Quantity) AS Ventas
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName, Country
ORDER BY Ventas DESC
--13. Número de productos diferentes que nos compra cada cliente.
--14. Clientes que nos compran más de cinco productos diferentes.
--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el
--año 97.
--16. Empleados que hayan aumentado su cifra de ventas más de un 10% entre dos
--años consecutivos, indicando el año en que se produjo el aumento.