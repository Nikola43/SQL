-- NORTHWIND
--1. Nombre de los proveedores y n�mero de productos que nos vende cada uno

SELECT CompanyName AS NombreProveedor, COUNT(ProductID) AS NumeroProductos 
	FROM Products AS P INNER JOIN Suppliers AS S
	ON P.SupplierID = S.SupplierID 
	Group by CompanyName
	Order by CompanyName

--2. Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.

Select FirstName as Nombre, 
       LastName as Apellidos, 
	   City AS Ciudad, 
	   HomePhone AS Tel�fono 
	   FROM Employees 
		WHERE City IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')

--3. N�mero de productos de cada categor�a y nombre de la categor�a.

SELECT COUNT(P.ProductID) AS NumeroProductos, 
	   C.CategoryName AS Categoria 
	   FROM Products AS P inner JOIN Categories AS C
	   ON C.CategoryID = P.CategoryID 
	   group by (CategoryName)

--4. Nombre de la compa��a de todos los clientes que hayan comprado queso de cabrales o tofu.

SELECT DISTINCT C.CompanyName AS NombreCompa�ia, C.CustomerID as IDCliente
	FROM Customers AS C INNER JOIN Orders as O 
	ON O.CustomerID=C.CustomerID INNER JOIN [Order Details] AS OD 
	ON OD.OrderID=O.OrderID INNER JOIN Products as P 
	ON P.ProductID=OD.ProductID
	WHERE P.ProductName like 'Queso Cabrales' AND P.ProductName not like 'Tofu'

--5. Empleados (ID, nombre, apellidos y tel�fono) que han vendido algo a Bon app' o Peter Franken.

SELECT DISTINCT E.EmployeeID AS ID, E.FirstName as Nombre, E.LastName AS Apellidos, E.HomePhone AS Telefono, C.CompanyName AS NombreCompa�ia 
	FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID=O.EmployeeID INNER JOIN Customers AS C ON C.CustomerID=O.CustomerID
	WHERE C.CompanyName like 'bon%' OR C.CompanyName like 'Meter Franken' 

--6. Empleados (ID, nombre, apellidos, mes y d�a de su cumplea�os) que no han vendido nunca nada a ning�n cliente de Francia. *

SELECT E.EmployeeID AS ID, E.FirstName as Nombre, E.LastName AS Apellidos, MONTH(E.BirthDate) AS MesNacimiento, DAY(E.BirthDate) AS Dia
	FROM Employees AS E INNER JOIN Orders AS O 
	ON O.EmployeeID = E.EmployeeID INNER JOIN Customers AS C 
	ON C.CustomerID=O.CustomerID
		WHERE C.Country Not Like 'France' 
		Group By E.EmployeeID, E.FirstName, E.LastName, E.BirthDate --sin subconsultas

--7. Total de ventas en US$ de productos de cada categor�a (nombre de la categor�a). 

SELECT DISTINCT C.CategoryName AS NombreCategoria,
				sum(OD.Quantity*OD.UnitPrice) AS TotalDolares --calculo del total de ventas por categoria
	FROM Categories AS C INNER JOIN Products as P 
	ON P.CategoryID = C.CategoryID INNER JOIN [Order Details] AS OD ON OD.ProductID=P.ProductID
	Group By C.CategoryName

--8. Total de ventas en US$ de cada empleado cada a�o (nombre, apellidos, direcci�n). (Employees con Orders y Orders con OD)

SELECT DISTINCT E.FirstName AS Nombre, E.LastName AS Apellido, E.Address AS Direccion,
				sum(UnitPrice*Quantity) AS TotalVentas
	FROM Employees AS E Inner Join Orders AS O 
	ON O.EmployeeID=E.EmployeeID INNER JOIN [Order Details] AS OD ON OD.OrderID=O.OrderID
	Group By E.FirstName, E.LastName, E.Address

--9. Ventas de cada producto en el a�o 97. Nombre del producto y unidades. 

SELECT DISTINCT ProductName AS Producto,
	            count(Quantity) AS UnidadesVendidas
	FROM Orders AS O INNER JOIN [Order Details] AS OD 
	ON O.OrderID=OD.OrderID INNER JOIN Products as P
	ON P.ProductID=OD.ProductID
	WHERE (YEAR(OrderDate)=1997)
	GROUP BY P.ProductName
	Order By P.ProductName

--10. Cu�l es el producto del que hemos vendido m�s unidades en cada pa�s. *

SELECT MAX(Quantity) AS UnidadesVendidas,
	   O.ShipCountry AS Pais,
	   P.ProductName AS Producto 
	   FROM [Order Details] AS OD INNER JOIN Orders AS O ON O.OrderID=OD.OrderID INNER JOIN Products AS P On P.ProductID=OD.ProductID
	   WHERE Quantity IN (SELECT SUM(Quantity) FROM [Order Details]
								 GROUP BY Quantity)
	   Group By P.ProductName,O.ShipCountry, Quantity
	   ORDER BY P.ProductName
	
--11. Empleados (nombre y apellidos) que trabajan a las �rdenes de Andrew Fuller.

SELECT ReportsTo, FirstName FROM Employees --comprobamos cu�l es el valor del ReportsTo que le corresponde a Andrew

SELECT E2.FirstName AS Nombre,
	   E2.LastName AS Apellido,
	   E1.FirstName AS NombreJefe
	FROM Employees AS E1 INNER JOIN Employees AS E2 ON E1.EmployeeID=E2.ReportsTo
	WHERE E1.ReportsTo is NULL 

--12. N�mero de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.

 SELECT COUNT(E1.ReportsTo) AS Subordinados, 
        E2.FirstName AS Empleados, 
		E2.LastName AS ApellidoEmpleado, 
		E2.EmployeeID AS ID
	FROM Employees AS E1 INNER JOIN Employees AS E2
	ON E2.EmployeeID = E1.ReportsTo
	GROUP BY E2.FirstName, E2.LastName, E2.EmployeeID