USE ICOTR
-- Ejercicio 1
-- A
GO
CREATE Function VentasPorContenedor (@Establecimiento VarChar(30), @Contenedor Char(20), @FechaInicio DATE, @FechaFin DATE)
	Returns SmallMoney AS
	BEGIN
	DECLARE @Ventas SmallMoney, @IDEstablecimiento SmallInt
	SELECT @IDEstablecimiento = ID FROM ICEstablecimientos WHERE Denominacion = @Establecimiento
	SELECT @Ventas = SUM (Importe) FROM ICPedidos
		WHERE ID IN (SELECT IDPedido FROM ICHelados AS H
						JOIN ICPedidos AS P ON H.IDPedido = P.ID
						WHERE H.TipoContenedor = @Contenedor
					)
			AND CAST(Recibido AS DATE) BETWEEN @FechaInicio AND @FechaFin
			AND IDEstablecimiento = @IDEstablecimiento
	Return @Ventas
	END --Function VentasPorContenedor
GO
SET DATEFORMAT YMD
Print dbo.VentasPorContenedor ('La Fresca','Cucurucho','2014-01-01','2014-1-1')

--Ejercicio 2

GO -- Primero vamos a crear una función para buscar el pedido más cercano
CREATE FUNCTION PedidoMasCercano (@Nombre VarChar(20), @Apellidos VarChar(30), @Momento SmallDateTime) 
	RETURNS BigInt AS
	BEGIN
	DECLARE @IdPedido BigInt, @IDCliente Int
	SELECT @IDCliente = ID From ICClientes WHERE Nombre = @Nombre AND Apellidos = @Apellidos
	SELECT TOP 1 @IdPedido =  Id FROM ICPedidos
		ORDER BY ABS(DATEDIFF(minute,@Momento,Recibido))
	RETURN @IdPedido
	END --FUNCTION PedidoMasCercano
GO
-- Ahora el procedimiento
CREATE PROCEDURE ClonaPedido @Nombre VarChar(20), @Apellidos VarChar(30), @Momento SmallDateTime AS
	BEGIN 
	DECLARE @IdPedido BigInt, @IDNueva BigInt
	Declare @numero BigInt
	DECLARE @HeladosClonados TABLE (IDAntiguo BigInt, IDNuevo BigInt)
	SET @IdPedido = dbo.PedidoMasCercano(@Nombre, @Apellidos, @Momento)
	BEGIN TRANSACTION NuevoPedido -- Insertamos el pedido
		SELECT @IDNueva = MAX(ID)+1 FROM ICPedidos 
		INSERT INTO ICPedidos (ID,Recibido,IDCliente,IDEstablecimiento,Importe)
			SELECT @IdNueva, GetDate(), IDCliente, IDEstablecimiento, Importe FROM ICPedidos Where ID = @IdPedido
	COMMIT NuevoPedido
	-- Ahora los helados
	BEGIN TRANSACTION NuevosHelados
	set @numero= (SELECT top 1 ID from ICHelados order by ID desc)
	Insert into ICHelados (ID,IDPEDIDO,TIPOCONTENEDOR,SABOR)
		select @numero+ROW_NUMBER() over(order by id),@IDNueva,TipoContenedor,	Sabor	--Insertamos Los helados iguales a los del otro pedido
			from ICHelados
			where IDPedido=@Idpedido
	COMMIT TRANSACTION NuevosHelados
	-- Ahora los toppings 
	-- Relacionamos cada helado nuevo con el antiguo equivalente para duplicar sus toppings
	INSERT INTO @HeladosClonados (IDAntiguo, IDNuevo)
		SELECT ID, @numero+ROW_NUMBER() over(order by id) FROM ICHelados
			where IDPedido=@Idpedido
	Insert into ICHeladosToppings(IDHelado,IDTopping)
		SELECT H.IDNuevo,HT.IDTopping FROM @HeladosClonados AS H 
			JOIN ICHeladosToppings AS HT ON H.IDAntiguo = HT.IDHelado
	-- Ahora los complementos
	Insert into ICPedidosComplementos (IDPedido,IDComplemento,Cantidad)
			select @IDNueva,IDComplemento,Cantidad							--Insertamos complementos
			from ICPedidosComplementos									--Con los mismos datos
			where IDPedido=@IdPedido
	END -- PROCEDURE ClonaPedido
	-- Life can be Gorgeous!

--Ejercicio 3
GO
ALTER FUNCTION VentasAnualesContenedor (@Establecimiento VarChar(30), @Contenedor Char(20))
	RETURNS TABLE AS RETURN
	SELECT Year(Recibido) AS [Año], SUM (dbo.VentasPorContenedor (@Establecimiento,@Contenedor,Recibido,Recibido)) AS Ventas
		FROM ICPedidos 
		WHERE DATEDIFF (Year,Recibido,GetDATE()) < 4
		GROUP BY Year(Recibido)
GO
SELECT * FROM dbo.VentasAnualesContenedor ('La Fresca','Tulipa')
SELECT * FROM dbo.VentasAnualesContenedor ('Sabroso','Brick')
--Ejercicio 4
GO
-- Función que nos devuelve el topping más vendido de un establecimiento a una hora determinada
alter FUNCTION ToppingHorario (@nombreEstablecimiento varchar(30), @hora TinyInt) 
	RETURNS VarChar(18) AS 
	BEGIN
	DECLARE @ToppingPopular VarChar(18)
		SELECT TOP 1 @ToppingPopular=T.Topping FROM ICToppings AS T
			JOIN ICHeladosToppings AS HT ON T.ID = HT.IDTopping
			JOIN ICHelados AS H ON HT.IDHelado = H.ID
			JOIN ICPedidos AS P ON H.IDPedido = P.ID
			JOIN ICEstablecimientos AS E ON P.IDEstablecimiento = E.ID
		WHERE E.Denominacion = @nombreEstablecimiento AND DATEPART(Hour, Recibido) = @hora
		GROUP BY T.Topping
		ORDER BY COUNT(*) DESC
	RETURN @ToppingPopular
	END
GO
-- Función principal
create FUNCTION ToppingPorHoras (@nombreEstablecimiento varchar(30)) 
	RETURNS @ToppingsPopulares TABLE (Hora TinyInt, Topping VarChar(18)) AS 
	BEGIN
	DECLARE @Horas TABLE (Hora TinyInt)
	INSERT INTO @Horas VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23)
	INSERT INTO @ToppingsPopulares (Hora, Topping)
		SELECT Hora,dbo.ToppingHorario (@nombreEstablecimiento,Hora) FROM @Horas
	RETURN
	END
GO
select * from dbo.ToppingPorHoras('Sabroso') 
select * from dbo.masToppingPorHora('Sabroso') 