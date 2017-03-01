USE Northwind
--1. Nombre del pa�s y n�mero de clientes de cada pa�s, ordenados alfab�ticamente por el nombre del pa�s.
SELECT Country, COUNT(CustomerID) AS [N�mero de Clientes] FROM Customers GROUP BY Country ORDER BY Country

--2. ID de producto y n�mero de unidades vendidas de cada producto.
SELECT ProductID, COUNT(ProductID) AS [Unidades Vendidas] FROM [Order Details] GROUP BY ProductID

--3. ID del cliente y n�mero de pedidos que nos ha hecho.
SELECT CustomerID, COUNT(CustomerID) AS [Pedidos Realizados] FROM Orders GROUP BY CustomerID

--4. ID del cliente, a�o y n�mero de pedidos que nos ha hecho cada a�o.
SELECT CustomerID, YEAR(OrderDate ) AS [A�o], COUNT(YEAR(OrderDate)) AS [N�mero de Pedidos] FROM Orders GROUP BY CustomerID, YEAR(OrderDate)

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor.
SELECT ProductID, MAX(UnitPrice) AS [Precio unitario m�ximo], SUM(Quantity*UnitPrice) AS [Total Facturado] FROM [Order Details] GROUP BY ProductID

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor.
SELECT SupplierID, CAST(SUM(UnitPrice*UnitsInStock)AS varchar)+' �' AS [Valor Stock] FROM Products GROUP BY SupplierID

--7. N�mero de pedidos registrados mes a mes de cada a�o.
SELECT COUNT(MONTH(OrderDate)) AS [N�mero de Pedidos], YEAR(OrderDate) AS [A�o], MONTH(OrderDate) AS Mes FROM Orders GROUP BY MONTH(OrderDate), YEAR(OrderDate) ORDER BY YEAR(OrderDate), MONTH(OrderDate)

--8. A�o y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), en d�as para cada a�o.
SELECT YEAR(OrderDate) AS [A�o], AVG(datediff(day, OrderDate, ShippedDate)) AS [Tiempo medio de env�o] FROM Orders GROUP BY YEAR(OrderDate) ORDER BY YEAR(OrderDate)

--9. ID del distribuidor y n�mero de pedidos enviados a trav�s de ese distribuidor.
SELECT ShipVia AS [ID del Distribuidor], COUNT(ShipVia) AS [N�mero de Pedidos] FROM Orders GROUP BY ShipVia

--10. ID de cada proveedor y n�mero de productos distintos que nos suministra.
SELECT SupplierID, COUNT(ProductID) AS [N�mero de productos distintos suministrados] FROM Products GROUP BY SupplierID