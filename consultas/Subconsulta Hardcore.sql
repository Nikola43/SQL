USE Northwind
--Clientes que han comprado productos de una categoría que contiene menos de 10 productos diferentes
SELECT DISTINCT C.ContactName FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE CategoryID IN (SELECT CategoryID FROM Products GROUP BY CategoryID HAVING COUNT(ProductID) <10)
ORDER BY C.ContactName

SELECT DISTINCT C.ContactName FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
INNER JOIN (SELECT CategoryID FROM Products GROUP BY CategoryID HAVING COUNT(ProductID) <10) AS SC
ON P.CategoryID = SC.CategoryID
ORDER BY C.ContactName

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Products