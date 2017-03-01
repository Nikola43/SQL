USE Northwind

-- 1.Nombre de la compañía y dirección completa (dirección, cuidad, país) de todos los clientes que no sean de los Estados Unidos.
SELECT CompanyName, Address, City, Country FROM Customers WHERE Country != 'USA'

-- 2.La consulta anterior ordenada por país y ciudad.
SELECT CompanyName, Address, City, Country FROM Customers WHERE Country != 'USA' ORDER BY Country, City DESC

-- 3.Nombre, Apellidos, Ciudad y Edad de todos los empleados, ordenados por antigüedad en la empresa.
SELECT FirstName, LastName, City, Year(CURRENT_TIMESTAMP-BirthDate)-1900 AS Edad FROM Employees ORDER BY HireDate

-- 4.Nombre y precio de cada producto, ordenado de mayor a menor precio.
SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice DESC

-- 5.Nombre de la compañía y dirección completa de cada proveedor de algún país de América del Norte.
SELECT CompanyName, Address, City, Region, Country FROM Suppliers WHERE Country IN ('Canada', 'USA')

-- 6.Nombre del producto, número de unidades en stock y valor total del stock, de los productos que no sean de la categoría 4.
SELECT ProductName, UnitsInStock, UnitPrice*UnitsInStock AS ValorTotalDelStock FROM Products WHERE CategoryID !='4'

-- 7.Clientes (Nombre de la Compañía, dirección completa, persona de contacto) que no residan en un país de América del Norte y que la persona de contacto no sea el propietario de la compañía
SELECT * FROM Customers
SELECT CompanyName, Address, City, Region, Country, ContactName FROM Customers WHERE (Country NOT IN ('Canada', 'USA')) AND (ContactTitle NOT LIKE 'Owner%') --Owner% para no mostrar Owner/Marketing Assistant

-- 8.ID del cliente y número de pedidos realizados por cada cliente, ordenado de mayor a menor número de pedidos.
SELECT CustomerID AS [Cliente], COUNT(*) AS [Pedidos realizados] FROM Orders GROUP BY CustomerID

-- 9.Número de pedidos enviados a cada ciudad, incluyendo el nombre de la ciudad.
SELECT ShipCity, COUNT(*) AS [Número de pedidos] FROM Orders GROUP BY ShipCity

-- 10.Número de productos de cada categoría. 
SELECT CategoryID, COUNT(*) AS [Número de productos] FROM Products GROUP BY CategoryID