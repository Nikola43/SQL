USE AdventureWorks2014 
GO

--1. Nombre, numero de producto, precio y color de los productos de color rojo o amarillo cuyo precio esté comprendido entre 50 y 500

SELECT Name, ProductNumber, ListPrice, Color
FROM Production.Product
WHERE Color IN ('Red', 'Yellow') AND  ListPrice BETWEEN 50 AND 500

--2. Nombre, número de producto, precio de coste,  precio de venta, margen de beneficios total y margen de beneficios en % del precio 
--de venta de los productos de categorías inferiores a 16

SELECT Name, ProductNumber, StandardCost AS PrecioCoste, ListPrice AS PrecioVenta, (ListPrice-StandardCost) AS Beneficios, 
((ListPrice*100)/StandardCost)-100 AS PorcentajeBeneficio, ProductSubcategoryID
FROM Production.Product
WHERE StandardCost>0 AND ProductSubcategoryID<16 
--Esto es porque para calcular el margen de beneficios en % necesito dividir el precio de venta entre el precio
--de coste, y si éste es 0 nos da error porque no se puede dividir entre 0

--3. Empleados cuyo nombre o apellidos contenga la letra "r". Los empleados son los que tienen el valor "EM" en la columna PersonType de 
--la tabla Person

SELECT FirstName, MiddleName, LastName, PersonType
FROM Person.Person
WHERE (PersonType='EM') AND (FirstName LIKE '%r%' OR LastName LIKE '%r%')

--4. LoginID, nationalIDNumber, edad y puesto de trabajo (jobTitle) de los empleados (tabla Employees) de sexo femenino que tengan más de 
--cinco años de antigüedad

SELECT LoginID, nationalIDNumber, DATEDIFF(YEAR, BirthDate, CAST(CURRENT_TIMESTAMP AS date)) AS Edad, jobTitle AS PuestoTrabajo,
DATEDIFF(YEAR, HireDate, CAST(CURRENT_TIMESTAMP AS date)) AS Antiguedad
FROM HumanResources.Employee
WHERE Gender='F' AND (DATEDIFF(YEAR, HireDate, CAST(CURRENT_TIMESTAMP AS date)))>5

--5. Ciudades correspondientes a los estados 11, 14, 35 o 70, sin repetir. Usar la tabla Person.Address

SELECT DISTINCT City, StateProvinceID
FROM Person.Address
WHERE StateProvinceID in (11, 14, 35, 70)