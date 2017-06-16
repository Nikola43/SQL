USE Northwind
GO

--Consultas sobre una sola Tabla

--1. Nombre del país y número de clientes de cada país, ordenados alfabéticamente por el nombre del país.

SELECT Country AS Pais, COUNT(CustomerID) AS NumeroClientes
FROM Customers
GROUP BY Country
ORDER BY Country 

--2. ID de producto y número de unidades vendidas de cada producto. 

SELECT ProductID, COUNT(ProductID) AS UdVendidas
FROM [Order Details]
GROUP BY ProductID

--3. ID del cliente y número de pedidos que nos ha hecho.

SELECT CustomerID, COUNT(OrderID) AS PedidosRealizados
FROM Orders
GROUP BY CustomerID

--4. ID del cliente, año y número de pedidos que nos ha hecho cada año.

SELECT CustomerID, YEAR(OrderDate) AS Año, COUNT(OrderID) AS PedidosRealizados
FROM Orders
GROUP BY CustomerID, YEAR(OrderDate)
ORDER BY CustomerID

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. 
--Si hay varios precios unitarios para el mismo producto tomaremos el mayor.

SELECT ProductID, MAX(UnitPrice) AS PrecioUnitario, SUM(UnitPrice*Quantity) AS TotalFacturado
FROM [Order Details]
GROUP BY ProductID
ORDER BY TotalFacturado DESC  

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor.

SELECT SupplierID, SUM(UnitPrice*UnitsInStock) AS ImporteStock
FROM Products
GROUP BY SupplierID

--7. Número de pedidos registrados mes a mes de cada año.

SELECT YEAR(OrderDate) AS Año, MONTH(OrderDate) AS Mes, COUNT(OrderID) PedidosRegistrados
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Año, Mes

--8. Año y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), 
--en días para cada año.

SELECT YEAR(OrderDate) AS Año, AVG(DATEDIFF(DAY, OrderDate, ShippedDate)) AS TiempoMedioEnvio
FROM Orders 
GROUP BY YEAR(OrderDate)

--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor.

SELECT ShipVia AS IDDistribuidor, COUNT(OrderID) AS NumeroPedidos
FROM Orders 
GROUP BY ShipVia

--10. ID de cada proveedor y número de productos distintos que nos suministra.

SELECT SupplierID, COUNT(ProductID) AS NumeroProductos
FROM Products
GROUP BY SupplierID