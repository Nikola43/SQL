USE Northwind
--1. Nombre del país y número de clientes de cada país, ordenados alfabéticamente por el nombre del país.
SELECT Country, COUNT(CustomerID) AS [Número de Clientes] FROM Customers GROUP BY Country ORDER BY Country

--2. ID de producto y número de unidades vendidas de cada producto.
SELECT ProductID, COUNT(ProductID) AS [Unidades Vendidas] FROM [Order Details] GROUP BY ProductID

--3. ID del cliente y número de pedidos que nos ha hecho.
SELECT CustomerID, COUNT(CustomerID) AS [Pedidos Realizados] FROM Orders GROUP BY CustomerID

--4. ID del cliente, año y número de pedidos que nos ha hecho cada año.
SELECT CustomerID, YEAR(OrderDate ) AS [Año], COUNT(YEAR(OrderDate)) AS [Número de Pedidos] FROM Orders GROUP BY CustomerID, YEAR(OrderDate)

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor.
SELECT ProductID, MAX(UnitPrice) AS [Precio unitario máximo], SUM(Quantity*UnitPrice) AS [Total Facturado] FROM [Order Details] GROUP BY ProductID

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor.
SELECT SupplierID, CAST(SUM(UnitPrice*UnitsInStock)AS varchar)+' €' AS [Valor Stock] FROM Products GROUP BY SupplierID

--7. Número de pedidos registrados mes a mes de cada año.
SELECT COUNT(MONTH(OrderDate)) AS [Número de Pedidos], YEAR(OrderDate) AS [Año], MONTH(OrderDate) AS Mes FROM Orders GROUP BY MONTH(OrderDate), YEAR(OrderDate) ORDER BY YEAR(OrderDate), MONTH(OrderDate)

--8. Año y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), en días para cada año.
SELECT YEAR(OrderDate) AS [Año], AVG(datediff(day, OrderDate, ShippedDate)) AS [Tiempo medio de envío] FROM Orders GROUP BY YEAR(OrderDate) ORDER BY YEAR(OrderDate)

--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor.
SELECT ShipVia AS [ID del Distribuidor], COUNT(ShipVia) AS [Número de Pedidos] FROM Orders GROUP BY ShipVia

--10. ID de cada proveedor y número de productos distintos que nos suministra.
SELECT SupplierID, COUNT(ProductID) AS [Número de productos distintos suministrados] FROM Products GROUP BY SupplierID