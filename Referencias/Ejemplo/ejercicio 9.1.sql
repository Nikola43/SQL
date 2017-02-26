go 
use Northwind
go

--1.Nombre de los proveedores y número de productos que nos vende cada uno
SELECT S.CompanyName, count (P.SupplierID) as [numero productos] FROM Suppliers as S 
inner join Products as P 
on S.SupplierID=P.SupplierID
--WHERE
GROUP BY S.CompanyName
--HAVING
--ORDER BY


--2.Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
SELECT distinct E.FirstName, E.LastName, E.HomePhone, T.TerritoryDescription as [Lugar Trabajo] FROM Employees as E 
inner join EmployeeTerritories as ET
on E.EmployeeID=ET.EmployeeID
inner join Territories as T
on ET.TerritoryID=T.TerritoryID

WHERE T.TerritoryDescription in ('New York','Seattle','Vermont','Columbia','Los Angeles','Redmond','Atlanta')
--GROUP BY
--HAVING
--ORDER BY


--3.Número de productos de cada categoría y nombre de la categoría.

SELECT C.CategoryName as nombre, count (P.CategoryID) as [Numero Productos]  FROM Categories as C
inner join Products as P
on C.CategoryID=P.CategoryID

--WHERE 
GROUP BY C.CategoryName
--HAVING
--ORDER BY


--4.Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.

SELECT distinct C.CompanyName as Nombre, P.ProductName as Producto FROM Customers as C
inner join Orders as O
on C.CustomerID=O.CustomerID
inner join [Order Details] as OD
on O.OrderID=OD.OrderID
inner join Products as P
on OD.ProductID=P.ProductID

WHERE P.ProductName in ('tofu','Queso Cabrales')
--GROUP BY 
--HAVING
--ORDER BY


--5.Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Peter Franken.

SELECT distinct E.EmployeeID as ID, E.FirstName as nombre, E.LastName as Apellido, E.HomePhone, C.CompanyName as [compañia vendida], C.ContactName as [Nombre Contacto] FROM Employees as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join Customers as C
on O.CustomerID=C.CustomerID

WHERE C.CompanyName like 'Bon app%' or C.ContactName like 'Peter Franken'
--GROUP BY 
--HAVING
--ORDER BY


--6.Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. *

--SUBCONSULTA EXCEPT
SELECT E.EmployeeID as ID, E.FirstName as Nombre, E.LastName as Apellido, MONTH(E.BirthDate) as MesCumple, DAY(E.BirthDate) as DiaCumple
FROM Employees as E

EXCEPT

SELECT E.EmployeeID as ID, E.FirstName as Nombre, E.LastName as Apellido, MONTH(E.BirthDate) as MesCumple, DAY(E.BirthDate) as DiaCumple
FROM Employees as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join Customers as C
on O.CustomerID=C.CustomerID
WHERE C.Country='Mexico' 
--GROUP BY
--HAVING
--ORDER BY

--SUBCONSULTA WHERE
SELECT E.EmployeeID as ID, E.FirstName as Nombre, E.LastName as Apellido, MONTH(E.BirthDate) as MesCumple, DAY(E.BirthDate) as DiaCumple
FROM Employees as E

WHERE E.EmployeeID NOT IN (

SELECT E.EmployeeID as ID
FROM Employees as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join Customers as C
on O.CustomerID=C.CustomerID
WHERE C.Country='Mexico' )


--7.Total de ventas en US$ de productos de cada categoría (nombre de la categoría).

SELECT C.CategoryName as [Nombre categoria], sum(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) as ventas FROM Categories as C
inner join Products as P
on C.CategoryID=P.CategoryID
inner join [Order Details] as OD
on P.ProductID=OD.ProductID

--WHERE 
GROUP BY C.CategoryName
--HAVING
ORDER BY ventas


--8.Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).

SELECT E.EmployeeID as id, E.FirstName as Nombre, E.LastName as Apellido, E.Address as Dirección, E.City as Ciudad, sum(OD.Quantity*OD.UnitPrice) as Ventas, YEAR(O.OrderDate) as año FROM Employees as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join [Order Details] as OD
on O.OrderID=OD.OrderID
--WHERE 
GROUP BY E.EmployeeID, E.FirstName, E.LastName,  E.Address, E.City, YEAR(O.OrderDate)
--HAVING
ORDER BY id, año


--9.Ventas de cada producto en el año 97. Nombre del producto y unidades.
SELECT P.ProductName, sum(OD.Quantity) as Unidades FROM Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID

WHERE  YEAR(O.OrderDate)=1997
GROUP BY P.ProductName
--HAVING
--ORDER BY


--10.Cuál es el producto del que hemos vendido más unidades en cada país. *




--11.Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
SELECT E.FirstName as Nombre, E.LastName as Apellido, Jefes.FirstName as [Nombre Jefe] FROM Employees as E
inner join Employees as Jefes
on Jefes.EmployeeID=E.ReportsTo

WHERE Jefes.FirstName='Andrew'
--GROUP BY 
--HAVING
--ORDER BY



--12.Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.

SELECT E.FirstName as Nombre, E.LastName as Apellido, E.EmployeeID as ID, Count(Sub.ReportsTo) as [Número Empleados]
 FROM Employees as E
left join Employees as Sub
on E.EmployeeID=Sub.ReportsTo
--WHERE 
GROUP BY E.FirstName, E.LastName, E.EmployeeID
--HAVING
--ORDER BY