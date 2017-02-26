USE Northwind

--Boletin 9.1
--Escribe las siguientes consultas sobre la base de datos NorthWind.
--Pon el enunciado como comentario junta a cada una
--1.	Nombre de los proveedores y número de productos que nos vende cada uno
--2.	Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
--3.	Número de productos de cada categoría y nombre de la categoría.
--4.	Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
--5.	Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.
--6.	Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. *
--7.	Total de ventas en US$ de productos de cada categoría (nombre de la categoría).
--8.	Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
--9.	Ventas de cada producto en el año 97. Nombre del producto y unidades.
--10.	Cuál es el producto del que hemos vendido más unidades en cada país. *
--11.	Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
--12.	Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.
--* Se necesitan subconsultas

--1.	Nombre de los proveedores y número de productos que nos vende cada uno
SELECT ContactName, COUNT(P.ProductID) AS NumeroProductos
FROM Suppliers AS S
JOIN Products AS P ON S.SupplierID = P.SupplierID
GROUP BY ContactName


--2. Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia,
--   Los Angeles, Redmond o Atlanta.
SELECT FirstName, lastName, HomePhone
FROM Employees AS E
join EmployeeTerritories as et on e.EmployeeID = et.EmployeeID
join Territories as t on et.TerritoryID = t.TerritoryID
WHERE t.TerritoryDescription in ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')
GROUP BY FirstName, LastName, HomePhone

 --3.	Número de productos de cada categoría y nombre de la categoría.
 SELECT COUNT(ProductID) AS NumeroProductos, C.CategoryName
 FROM Products AS P
 JOIN Categories AS C on P.CategoryID = C.CategoryID
 GROUP BY C.CategoryName

 --4.	Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
 SELECT DISTINCT C.CompanyName
 FROM Customers AS C 
 JOIN Orders AS O on C.CustomerID = O.CustomerID
 JOIN [Order Details] AS OD on O.OrderID = OD.OrderID
 JOIN Products AS P on OD.ProductID = P.ProductID
 Where P.ProductName in ('Queso Cabrales', 'Tofu')

 --5.Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.
 SELECT Empl.EmployeeID, Empl.LastName, Empl.FirstName, Empl.HomePhone
 FROM Employees AS Empl
 JOIN Orders as O on Empl.EmployeeID = O.EmployeeID
 JOIN Customers as c on O.CustomerID = C.CustomerID
 WHERE C.CompanyName IN ('Bon app''', 'Meter Franken')

