USE ICOTR
GO
SET DATEFORMAT YMD
GO 

--Consultas
--Escribe el código SQL necesario para realizar las siguientes operaciones sobre la base de datos ICOTR.
--Cuando la consulta sea muy compleja usa vistas para realizar partes de la misma
--Consultas con agregados

--1.Número de veces que se ha pedido cada topping
SELECT COUNT(T.ID) AS [Veces que se ha pedido]
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
GROUP BY T.ID

--2.Número de veces que se ha pedido cada topping cada año
SELECT COUNT(T.ID) AS [Veces que se ha pedido], T.Topping, YEAR(P.Recibido) AS AÑO
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
GROUP BY YEAR(P.Recibido), T.Topping
ORDER BY YEAR(P.Recibido), T.Topping

--3.Número de veces que se ha pedido cada topping en cada establecimiento
SELECT COUNT(T.ID) AS [Veces que se ha pedido], P.IDEstablecimiento
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
GROUP BY P.IDEstablecimiento


-- REVISAR --
--4.Número de pedidos que incluyen cada topping. OJO: Un pedido puede incluir el mismo topping más de una vez
SELECT COUNT(DISTINCT P.ID) AS [Veces que se ha pedido], T.Topping
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
GROUP BY T.Topping

--5.Número de helados repartidos por cada repartidor en el año 2014.
SELECT COUNT(H.ID) AS [Helados vendidos], P.IDRepartidor
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
WHERE YEAR(P.Recibido) = 2014 
GROUP BY P.IDRepartidor

--6.Número de pedidos y cantidad facturada por cada repartidor en el año 2014.
SELECT COUNT(P.ID) AS [Numero Pedidos], SUM(P.Importe) AS [Cantidad Facturada], P.IDRepartidor
FROM ICPedidos AS P
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
INNER JOIN ICHeladosToppings AS HT
ON H.ID = HT.IDHelado
INNER JOIN ICToppings AS T
ON HT.IDTopping = T.ID
WHERE YEAR(P.Recibido) = 2014 
GROUP BY P.IDRepartidor

--7.Pedidos (ID, Nombre y apellidos del cliente, nombre del establecimiento e importe) que incluyan el sabor menos vendido de cada ciudad. La ciudad se tomará del establecimiento.
SELECT TOP 10 P.ID, C.Nombre, C.Apellidos, E.Denominacion, P.Importe, COUNT(H.Sabor) AS [Veces vendidas], E.Ciudad
FROM ICEstablecimientos AS E
INNER JOIN ICPedidos AS P
ON E.ID = P.IDEstablecimiento
INNER JOIN ICClientes AS C
ON P.IDCliente = C.ID
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
GROUP BY P.ID, C.Nombre, C.Apellidos, E.Denominacion, P.Importe, E.Ciudad
ORDER BY COUNT(H.Sabor) ASC

-- REVISAR --
--8.Sabor más vendido en cada establecimiento. Incluir cuantos pedidos incluyen ese sabor. Ten en cuenta que en un pedido hay varios helados y varios pueden tener el mismo sabor.
SELECT DISTINCT H.Sabor, COUNT(H.Sabor) AS [Veces vendidas]
FROM ICEstablecimientos AS E
INNER JOIN ICPedidos AS P
ON E.ID = P.IDEstablecimiento
INNER JOIN ICClientes AS C
ON P.IDCliente = C.ID
INNER JOIN ICHelados AS H
ON P.ID = H.IDPedido
GROUP BY H.Sabor, E.Denominacion
ORDER BY COUNT(H.Sabor)

--(falta Fecha)
--9.Cifra total de ventas de cada establecimiento en cada estación del año. 
--El invierno va del 21 de diciembre al 21 de marzo, la primavera hasta en 21 de junio, el verano termina el 21 de septiembre.
SELECT SUM(P.Importe), E.Denominacion
FROM ICEstablecimientos AS E
INNER JOIN ICPedidos AS P
ON E.ID = P.IDEstablecimiento
GROUP BY E.Denominacion

--(falta porcentaje)
--10.Porcentaje de helados que usan cada tipo de contenedor
SELECT COUNT(H.ID), H.TipoContenedor
FROM ICHelados AS H
GROUP BY H.TipoContenedor
ORDER BY H.TipoContenedor

--11.Añade a la tabla clientes una columna de tipo DECIMAL (3,2) llamada TipoDescuento.
-- No admitirá valores nulos y su valor por defecto es 0.00. El valor de esta columna indicará el tipo de descuento
-- que hacemos a los clientes en sus pedidos en tanto por uno.

BEGIN TRANSACTION
ALTER TABLE ICClientes
ADD TipoDescuento DECIMAL (3,2) NOT NULL DEFAULT 0.00

COMMIT TRANSACTION
--ROLLBACK TRANSACTION

SELECT * FROM ICClientes

--12.Añade una restricción para que el valor de esa columna tenga que estar entre 0 y 0.3
BEGIN TRANSACTION
ALTER TABLE ICClientes ADD Constraint CK_ValorDescuento CHECK ( TipoDescuento BETWEEN 0 AND 0.3)

COMMIT TRANSACTION
--ROLLBACK TRANSACTION

--13.Rellena la columna sumando 0.02 a todos los clientes que hayan hecho más de tres pedidos durante los meses de octubre a febrero.
GO
ALTER FUNCTION dbo.calcularNumeroPedidos(@ID_Cliente Int, @inicioRango DATE, @finRango DATE)
    RETURNS int
    BEGIN
        DECLARE @resultado int
        SET @resultado = 
		(
			SELECT COUNT(P.ID) 
			FROM ICClientes AS C
			INNER JOIN ICPedidos AS P
			ON C.ID = P.IDCliente
			WHERE Recibido BETWEEN @inicioRango AND @finRango AND @ID_Cliente = C.ID
		)
        RETURN @resultado
    END
GO


BEGIN TRANSACTION

UPDATE ICClientes 
SET TipoDescuento = 0.02
FROM ICClientes AS C
INNER JOIN ICPedidos AS P
ON C.ID = P.IDCliente
WHERE ( dbo.calcularNumeroPedidos(C.ID, DATEFROMPARTS(YEAR(Recibido), 01, 10), DATEFROMPARTS(YEAR(Recibido), 02, 28))) > 3

COMMIT TRANSACTION
--ROLLBACK TRANSACTION

SELECT * FROM  ICClientes
