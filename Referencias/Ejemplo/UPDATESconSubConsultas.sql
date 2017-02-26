USE Northwind

GO
CREATE VIEW V_VentasProductos AS
SELECT P.ProductID, SUM(OD.Quantity) AS CantidadVendida
FROM Products AS P
JOIN [Order Details] AS OD ON P.ProductID=OD.ProductID
GROUP BY P.ProductID
GO

/*
  ACTUALIZAMOS EL PRECIO UNITARIO DE LOS PRODUCTOS DE LA CATEGORIA "BEVERAGES"
*/
UPDATE Products 
SET UnitPrice = 1
WHERE ProductID IN 
(
	SELECT ProductID FROM Products AS P 
	JOIN Categories AS C ON P.CategoryID = C.CategoryID
    WHERE C.CategoryName = 'Beverages'
)

-- Consultamos los cambios en la tabla Productos
SELECT P.ProductID, P.UnitPrice FROM Products AS P 
JOIN Categories AS C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'



/*
	ACTUALIZAMOS EL PRECIO UNITARIO DE LOS PRODUCTOS DE LA CATEGORIA BEVERAGES, SUBIENDO EL PRECIO DEPENDIENDO DE LAS VENTAS
*/
BEGIN TRANSACTION 
UPDATE Products 
SET UnitPrice = UnitPrice + CantidadVendida / 100
FROM V_VentasProductos
WHERE Products.ProductID = V_VentasProductos.ProductID AND CategoryID IN 
(
	SELECT C.CategoryID FROM  Categories AS C
	WHERE C.CategoryName = 'Beverages'
)

-- Consultamos los cambios en productos
SELECT P.ProductID, P.UnitPrice FROM Products AS P 
	JOIN Categories AS C ON P.CategoryID = C.CategoryID
	WHERE C.CategoryName = 'Beverages'

/*
	ACTUALIZAMOS EL PRECIO UNITARIO DE LOS PRODUCTOS DE LA CATEGORIA BEVERAGES
*/
UPDATE Products 
SET UnitPrice = 1
WHERE CategoryID IN 
(
    SELECT CategoryID FROM Categories 
	WHERE CategoryName = 'Beverages'
)

UPDATE Products 
	SET UnitPrice = 1
	FROM Categories AS C
	WHERE C.CategoryName = 'Beverages' AND Products.CategoryID = C.CategoryID 
		

SELECT P.ProductID, P.UnitPrice FROM Products AS P 
	JOIN Categories AS C ON P.CategoryID = C.CategoryID
	WHERE C.CategoryName = 'Beverages'


ROLLBACK TRANSACTION
--COMMIT TRANSACTION