USE Northwind
GO
-- Si la tabla está creada, la borramos
IF EXISTS (SELECT OBJECT_ID(N'Empleados'))
	DROP TABLE Empleados
GO
-- Hacemos una copia de Employees a la que llamamos Empleados
SELECT * INTO Empleados FROM Employees 
GO
-- Añadimos una nueva columna
ALTER TABLE Empleados ADD Ventas BigInt
GO

--5. Empleados que no han vendido nunca “Chartreuse verte” ni “Ravioli Angelo”.
-- Vamos a usar esta consulta para borrar filas
SELECT (FirstName+' '+LastName) AS [Full Name], EmployeeID
FROM Employees
EXCEPT
SELECT (E.FirstName+' '+E.LastName) AS [Full Name], E.EmployeeID
FROM Employees AS E
	JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
	JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	JOIN Products AS P ON OD.ProductID = P.ProductID
WHERE P.ProductName IN ('Chartreuse verte','Ravioli Angelo')

-- Si vale 0, no hay ninguna transacción abierta
SELECT @@TRANCOUNT

BEGIN TRANSACTION TengoMiedo
DELETE Empleados WHERE EmployeeID NOT IN 
	(SELECT E.EmployeeID FROM Empleados AS E
		JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
		JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
		JOIN Products AS P ON OD.ProductID = P.ProductID
		WHERE P.ProductName IN ('Chartreuse verte','Ravioli Angelo')
	)
-- Comprobamos antes de confirmar	
SELECT * FROM Empleados
-- Si todo está bien, confirmamos 
COMMIT

-- Y si no, deshacemos
Rollback

-- ACTUALIZACIONES
--6. Número de unidades de productos que ha vendido cada empleado.
GO
-- En UPDATE no podemos usar GROUP BY, excepto en una subconsulta, por lo que necesitamso una vista
CREATE VIEW UnidadesEmpleado AS
SELECT O.EmployeeID, SUM(OD.Quantity) AS [Productos vendidos]
FROM Orders AS O 
	JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	JOIN Products AS P ON OD.ProductID = P.ProductID
GROUP BY O.EmployeeID

-- Ahora la actualización
BEGIN TRANSACTION TengoMiedo
UPDATE Empleados 
	SET Ventas = [Productos Vendidos]
	FROM UnidadesEmpleado 
	WHERE Empleados.EmployeeID=UnnidadesEmpleado.EmployeeID
	
Commit

