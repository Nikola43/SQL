USE AdventureWorks2012
--1. Nombre, numero de producto, precio y color de los productos de color rojo o amarillo cuyo precio esté comprendido entre 50 y 500
SELECT Name AS Nombre, ProductNumber AS [Número de producto], ListPrice AS Precio, Color FROM Production.Product WHERE (Color IN ('Red', 'Yellow')) AND (ListPrice BETWEEN 50 AND 500)

--CORREGIR: margen de beneficios total

/*2. Nombre, número de producto, precio de coste,  precio de venta, margen de beneficios total
y margen de beneficios en % del precio de venta de los productos de categorías inferiores a 16*/
SELECT Name, ProductNumber, StandardCost, ListPrice, (ListPrice - StandardCost) AS [Margen de beneficios], CAST(((ListPrice - StandardCost)/StandardCost)*100 AS varchar)+'%' AS [Margen de beneficios]  FROM Production.Product WHERE ProductSubcategoryID < 16

--3. Empleados cuyo nombre o apellidos contenga la letra "r". Los empleados son los que tienen el valor "EM" en la columna PersonType de la tabla Person
SELECT FirstName, LastName FROM Person.Person WHERE ( FirstName LIKE ('%r%') OR LastName LIKE('%r%') ) AND (PersonType = 'EM')

--4. LoginID, nationalIDNumber, edad y puesto de trabajo (jobTitle) de los empleados (tabla Employees) de sexo femenino que tengan más de cinco años de antigüedad
SELECT LoginID, nationalIDNumber, YEAR(CURRENT_TIMESTAMP -  CAST(BirthDate AS smalldatetime))-1900 AS Edad, jobTitle AS [Puesto de Trabajo] FROM HumanResources.Employee WHERE (Gender = 'M') AND (YEAR(CURRENT_TIMESTAMP - CAST(HireDate AS smalldatetime)) -1900 )> 5

--5. Ciudades correspondientes a los estados 11, 14, 35 o 70, sin repetir. Usar la tabla Person.Address
SELECT City, StateProvinceID FROM Person.Address WHERE StateProvinceID IN (11, 14, 35, 70) GROUP BY City, StateProvinceID ORDER BY StateProvinceID