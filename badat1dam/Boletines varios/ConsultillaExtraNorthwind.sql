-- Clientes que han comprado productos de una categoría que contiene menos de 10 productos diferentes C O OD P C
USE Northwind
GO

SELECT DISTINCT C.CompanyName
	FROM Customers AS C
	INNER JOIN Orders AS O
	ON O.CustomerID=C.CustomerID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID
WHERE P.CategoryID IN(SELECT C.CategoryID
	FROM Products AS P
	INNER JOIN Categories AS C
	ON C.CategoryID=P.CategoryID
	GROUP BY C.CategoryID
	HAVING COUNT(P.ProductID)<10)

-- Vamos a probarlo con un inner join a la subconsulta

SELECT DISTINCT C.CompanyName
	FROM Customers AS C
	INNER JOIN Orders AS O
	ON O.CustomerID=C.CustomerID
	INNER JOIN [Order Details] AS OD
	ON OD.OrderID=O.OrderID
	INNER JOIN Products AS P
	ON P.ProductID=OD.ProductID 
	INNER JOIN(SELECT C.CategoryID
	FROM Products AS P
	INNER JOIN Categories AS C
	ON C.CategoryID=P.CategoryID
	GROUP BY C.CategoryID
	HAVING COUNT(P.ProductID)<10) AS Sub
	ON Sub.CategoryID=P.CategoryID
						