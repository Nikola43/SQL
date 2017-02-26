

USE Northwind

--Having
SELECT * FROM [Order Details]

SELECT OrderID, COUNT(OrderID) AS Cantidad
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(*) > 2


-- Sub consultas
SELECT ProductID, ProductName, CategoryID,
		(SELECT CategoryID from Categories
		WHERE CategoryID = Products.CategoryID) as Categoria,
		(SELECT CompanyName from Suppliers
		WHERE SupplierID = Products.CategoryID) as ProveedorA,
		(SELECT SUM(UnitPrice) from [Order Details]
		WHERE ProductID = Products.ProductID) as precio
from Products
ORDER BY ProductID



