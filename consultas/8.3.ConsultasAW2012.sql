USE AdventureWorks2012
--Consultas sencillas-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1.Nombre del producto, código y precio, ordenado de mayor a menor precio
SELECT Name, ProductID, ListPrice FROM Production.Product ORDER BY ListPrice DESC

--2.Número de direcciones de cada Estado/Provincia
SELECT S.Name, COUNT(DISTINCT A.AddressLine1) AS [Número de direcciones]
FROM Person.Address AS A INNER JOIN Person.StateProvince AS S ON A.StateProvinceID = S.StateProvinceID
GROUP BY S.Name

--SELECT StateProvinceID, COUNT(DISTINCT AddressLine1) AS [Número de direcciones] FROM Person.Address GROUP BY StateProvinceID

--3.Nombre del producto, código, número, tamaño y peso de los productos que estaban a la venta durante todo el mes de septiembre de 2002.
--No queremos que aparezcan aquellos cuyo peso sea superior a 2000.
SELECT Name, ProductID, ProductNumber, Size, Weight FROM Production.Product
WHERE weight < 2000 AND (SellStartDate <= DATEFROMPARTS(2002,9,1)) AND (SellEndDate < DATEFROMPARTS(2002,10,1) OR SellEndDate IS NULL )
ORDER BY SellStartDate

--4.Margen de beneficio de cada producto (Precio de venta menos el coste), y porcentaje que supone respecto del precio de venta.
SELECT CAST((ListPrice - StandardCost) AS varchar)+'€' AS [Margen de beneficio], CAST(100*(ListPrice - StandardCost)/ListPrice AS varchar)+'%' AS [Porcentaje de beneficio] FROM Production.Product WHERE ListPrice != 0


--Consultas de dificultad media-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5.Número de productos de cada categoría
SELECT S.Name AS [Subcategoría], COUNT(P.ProductID) AS [Número de productos]
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS S
ON P.ProductSubcategoryID = S.ProductSubcategoryID
GROUP BY S.ProductSubcategoryID, S.Name --S.Name no cambia el GROUP BY porque depende de C.ProductCategoryID

--6.Igual a la anterior, pero considerando las categorías generales (categorías de categorías).
SELECT C.Name AS [Categoría], COUNT(P.ProductID) AS [Número de productos]
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS S
ON P.ProductSubcategoryID = S.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS C
ON S.ProductCategoryID = C.ProductCategoryID
GROUP BY C.ProductCategoryID, C.Name --C.Name no cambia el GROUP BY porque depende de C.ProductCategoryID

--7.Número de unidades vendidas de cada producto cada año.
SELECT P.Name, SUM(OrderQty) AS [Unidades vendidas]
FROM Sales.SalesOrderDetail AS OD
INNER JOIN Production.Product as P
ON OD.ProductID = P.ProductID
GROUP BY P.Name

--8.Nombre completo, compañía y total facturado a cada cliente


--9.Número de producto, nombre y precio de todos aquellos en cuya descripción aparezcan las palabras "race”, "competition” o "performance”



--Consultas avanzadas-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--10.Facturación total en cada país


--11.Facturación total en cada Estado


--12.Margen medio de beneficios y total facturado en cada país

 