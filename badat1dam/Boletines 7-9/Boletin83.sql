USE AdventureWorks2012
GO

--Consultas sencillas
--1.Nombre del producto, c�digo y precio, ordenado de mayor a menor precio

SELECT Name AS Nombre, ProductID AS C�digo, ListPrice AS Precio
FROM Production.Product
ORDER BY Precio DESC 

--2.N�mero de direcciones de cada Estado/Provincia

SELECT StateProvinceID AS EstadoProvincia, COUNT(AddressID) AS NumeroDirecciones
FROM Person.Address
GROUP BY StateProvinceID

--3.Nombre del producto, c�digo, n�mero, tama�o y peso de los productos que estaban a la venta durante todo el mes de septiembre de 2002. 
--No queremos que aparezcan aquellos cuyo peso sea superior a 2000. 

SELECT Name AS Nombre, ProductID AS Codigo, ProductNumber AS Numero, Size AS Tama�o, Weight AS Peso 
FROM Production.Product
WHERE Weight<2000 AND YEAR(SellStartDate)<=2002 AND MONTH(SellStartDate)<=9 --AND YEAR(SellEndDate)>=2002 AND MONTH(SellEndDate)>=10
--La �ltima condici�n hace que la consulta salga vac�a porque la mayor�a de "sellenddate" est�n en null

--4.Margen de beneficio de cada producto (Precio de venta menos el coste), y porcentaje que supone respecto del precio de venta.

SELECT Name AS Producto, (ListPrice-StandardCost) AS Beneficios, ((ListPrice*100)/StandardCost)-100 AS PorcentajeBeneficio
FROM Production.Product
WHERE StandardCost>0
--Esto es porque para calcular el margen de beneficios en % necesito dividir el precio de venta entre el precio
--de coste, y si �ste es 0 nos da error porque no se puede dividir entre 0

--Consultas de dificultad media
--5.N�mero de productos de cada categor�a

SELECT ProductSubcategoryID AS Categoria, COUNT(ProductID) AS Productos
FROM Production.Product
GROUP BY ProductSubcategoryID

--6.Igual a la anterior, pero considerando las categor�as generales (categor�as de categor�as).



--7.N�mero de unidades vendidas de cada producto cada a�o.



--8.Nombre completo, compa��a y total facturado a cada cliente



--9.N�mero de producto, nombre y precio de todos aquellos en cuya descripci�n aparezcan las palabras "race�, "competition� o "performance�



--Consultas avanzadas
--10.Facturaci�n total en cada pa�s



--11.Facturaci�n total en cada Estado



--12.Margen medio de beneficios y total facturado en cada pa�s

