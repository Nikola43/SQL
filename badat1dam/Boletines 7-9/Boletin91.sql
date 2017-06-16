USE Northwind
GO
 
--1. Nombre de los proveedores y número de productos que nos vende cada uno

SELECT S.CompanyName AS Proveedor, COUNT(P.ProductID) AS Productos
FROM Suppliers AS S 
INNER JOIN Products AS P
ON S.SupplierID=P.SupplierID
GROUP BY S.CompanyName 

--2. Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.(Tdesc)

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellidos, E.HomePhone AS Telefono
FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET
ON E.EmployeeID=ET.EmployeeID
INNER JOIN Territories AS T
ON T.TerritoryID=ET.TerritoryID
WHERE T.TerritoryDescription in ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')

--3. Número de productos de cada categoría y nombre de la categoría.

SELECT C.CategoryName AS Categoría, COUNT(P.ProductID) AS Productos
FROM Products AS P 
INNER JOIN Categories AS C
ON P.CategoryID=C.CategoryID
GROUP BY C.CategoryName 

--4. Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.

SELECT DISTINCT C.CompanyName AS Compañía
FROM Customers AS C 
INNER JOIN Orders AS O
ON O.CustomerID=C.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID=O.OrderID
INNER JOIN Products AS P
ON OD.ProductID=P.ProductID
WHERE P.ProductName in ('tofu', 'queso de cabrales') 

--5. Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.

SELECT DISTINCT E.EmployeeID AS ID, E.FirstName AS Nombre, E.LastName AS Apellidos, E.HomePhone AS Teléfono
FROM Employees AS E
INNER JOIN Orders AS O
ON O.EmployeeID=E.EmployeeID
INNER JOIN Customers AS C
ON O.CustomerID=C.CustomerID
WHERE C.CompanyName='Bon app%' OR ContactName='Peter Franken'

--Meter Franken no existe, está registrado como "Peter Franken" como nombre de contacto en una compañía, no como nombre de la compañía

--6. Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. * 

SELECT DISTINCT E.EmployeeID AS ID, E.FirstName AS Nombre, E.LastName AS Apellidos, MONTH(E.BirthDate) AS MesCumple, DAY(E.BirthDate) AS DiaCumple
FROM Employees AS E
INNER JOIN Orders AS O
ON O.EmployeeID=E.EmployeeID
INNER JOIN Customers AS C
ON O.CustomerID=C.CustomerID
WHERE C.Country!='France'  

--7. Total de ventas en US$ de productos de cada categoría (nombre de la categoría). 

SELECT C.CategoryName AS Categoría, SUM(OD.UnitPrice*OD.Quantity) AS TotalVentas
FROM Categories AS C
INNER JOIN Products AS P
ON P.CategoryID=C.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
GROUP BY C.CategoryName

--8. Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección). 

SELECT E.FirstName AS Nombre, E.LastName AS Apellidos, E.Address AS Dirección, YEAR(O.OrderDate) AS Año, SUM(OD.UnitPrice*OD.Quantity) AS TotalVentas
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID=O.OrderID
GROUP BY E.FirstName, E.LastName, E.Address, YEAR(O.OrderDate)
ORDER BY Apellidos, Nombre, Año   

--9. Ventas de cada producto en el año 97. Nombre del producto y unidades.

SELECT P.ProductName AS Producto, SUM(Quantity) AS UdVendidas
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
GROUP BY P.ProductName

--10. Cuál es el producto del que hemos vendido más unidades en cada país. *

-- Hacemos una subconsulta para obtener las unidades vendidas de cada producto en cada país y seleccionamos el valor máximo. 
SELECT O.ShipCountry AS País, P.ProductName AS Producto, SUM(OD.Quantity) AS UdVendidas
FROM Products AS P 
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O
ON O.OrderID=OD.OrderID
GROUP BY ShipCountry, ProductName 
ORDER BY O.ShipCountry, P.ProductName

-- Ahora la añadimos a la consulta para ver cuál es el producto más vendido de cada país
SELECT Sub.País, MAX(Sub.Producto) AS Producto, MAX(Sub.UdVendidas) AS UnidadesVendidas FROM
	(SELECT O.ShipCountry AS País, P.ProductName AS Producto, SUM(OD.Quantity) AS UdVendidas
	FROM Products AS P 
	INNER JOIN [Order Details] AS OD
	ON OD.ProductID=P.ProductID
	INNER JOIN Orders AS O
	ON O.OrderID=OD.OrderID
	GROUP BY ShipCountry, ProductName 
	)AS Sub
GROUP BY Sub.País

--11. Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.

SELECT E2.FirstName AS Nombre, E2.LastName AS Apellidos
FROM Employees AS E
INNER JOIN Employees AS E2
ON E.EmployeeID=E2.ReportsTo  
WHERE E.LastName='Fuller' AND E.FirstName='Andrew'

--12. Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.

SELECT E.FirstName AS Nombre, E.LastName AS Apellidos, E.EmployeeID, COUNT(E2.ReportsTo) AS Subordinados
FROM Employees AS E
LEFT JOIN Employees AS E2
ON E.EmployeeID=E2.ReportsTo  
GROUP BY E.FirstName, E.LastName, E.EmployeeID
--no sé cómo hacer para que me salgan los que no tienen ninguno
