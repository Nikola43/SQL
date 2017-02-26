USE ICOTR

--EJERCICIO 1
							--Repartidores y su importe total en 2014 y  su tiempo medio de reparto
SELECT  R.Nombre , R.Apellidos , R.ID , SUM(P.Importe) AS [Importe total repartido] ,AVG(DATEDIFF(second,P.Recibido,P.Enviado)) AS [Diferencia Media de tiempoReparto en segundos]    
	 FROM ICRepartidores AS R INNER JOIN ICPedidos AS P ON R.ID = P.IDRepartidor		
	 WHERE YEAR(P.Enviado) = '2014'
	 GROUP BY R.Nombre , R.Apellidos , R.ID 
	 


--EJERCICIO 2
CREATE VIEW VTProductosVendidos AS
SELECT TOP 3 C.ID, C.Complemento , SUM(PC.Cantidad) AS [Productos Vendidos]   --PRODUCTOS menos vendidos ENTRE LAS FECHAS Y sus ventas
		FROM ICComplementos AS C INNER JOIN ICPedidosComplementos AS PC ON C.ID = PC.IDComplemento
				INNER JOIN ICPedidos AS P ON PC.IDPedido = P.ID
	WHERE P.Enviado BETWEEN DATEFROMPARTS(2013,3,17)  AND DATEFROMPARTS(2014,9,8)
	GROUP BY C.ID ,C.Complemento 
	ORDER BY [Productos Vendidos]

BEGIN TRANSACTION
SELECT distinct * FROM ICPedidosComplementos

UPDATE ICPedidosComplementos    --Actualizamos el ID del complemento en PedidosComplementos a 111 que es productoDescatolagado
	SET IDComplemento = '111'
	WHERE IDComplemento IN (Select ID FROM VTProductosVendidos)
	
ROLLBACK

DELETE FROM ICComplementos    --borramos los complementos que menos vendemos
		WHERE ID IN (Select ID FROM VTProductosVendidos)

--EJERCICIO 3

BEGIN TRANSACTION
INSERT INTO [dbo].[ICPedidos]  --Con esto creamos el pedido 
           ([ID]
           ,[Recibido]
           ,[Enviado]
           ,[IDCliente]
           ,[IDEstablecimiento]
           ,[IDRepartidor]
           ,[Importe])
	SELECT '98989' , GETDATE() , NULL , C.ID ,E.ID , NULL, '9.8'       
		FROM ICClientes AS C , ICEstablecimientos AS E
		WHERE C.Nombre ='Ramon' AND C.Apellidos = 'Tañero' AND E.Denominacion = 'Atracon'
GO

INSERT INTO [dbo].[ICHelados]  --Introducimos el Helado de caramelo
           ([ID]
           ,[IDPedido]
           ,[TipoContenedor]
           ,[Sabor])
	SELECT  '58997',P.ID , 'tarrina ceramica' , 'caramelo'
			FROM ICPedidos AS P 
		WHERE P.ID ='98989'


INSERT INTO [dbo].[ICHelados]  --Introducimos el Helado de alcachofa
           ([ID]
           ,[IDPedido]
           ,[TipoContenedor]
           ,[Sabor])
	SELECT  '58998',P.ID , 'tarrina ceramica' , 'alcachofa'
			FROM ICPedidos AS P 
		WHERE P.ID ='98989'


INSERT INTO [dbo].[ICHeladosToppings]					--Introducimos el toping de nata al helado de caramelo
           ([IDHelado]
           ,[IDTopping])
   SELECT H.ID , T.ID
		FROM ICHelados AS H ,ICToppings AS T
		WHERE H.ID = '58997' AND T.Topping = 'nata'
GO
INSERT INTO [dbo].[ICHeladosToppings]					--Introducimos el toping de gominolas yu lacasitos al de alcachofa
           ([IDHelado]
           ,[IDTopping])
   SELECT H.ID , T.ID
		FROM ICHelados AS H ,ICToppings AS T
		WHERE H.ID = '58998' AND (T.Topping = 'lacasitos' OR T.Topping = 'gominolas')
GO


SELECT * FROM ICPedidos
SELECT * FROM ICEstablecimientos
	
ROLLBACK
COMMIT TRANSACTION

--EJERCICIO 4



CREATE VIEW VTEstablecimientosEmpleados AS    --Esta tabla contiene los establecimientos con los diferentes empleados
		SELECT Distinct COUNT(R.ID) AS [numero de empleados], E.ID
				FROM ICEstablecimientos AS E JOIN ICRepartidores AS R ON E.ID = R.IDEstablecimiento
		GROUP BY E.ID

CREATE VIEW VTEstablecimientosDatos AS  --esta tabla muestra nombre , direccion , numerodePedidos , total facturado y  el numero de repartidores de los establecimientos
		SELECT  E.Denominacion , E.Direccion ,COUNT(P.ID) AS [Numero de Pedidos] , SUM(P.Importe) AS [total facturado] , VTEE.[numero de empleados]
				FROM ICEstablecimientos AS E JOIN ICPedidos AS P ON E.ID = P.IDEstablecimiento 
						INNER JOIN VTEstablecimientosEmpleados AS VTEE ON E.ID = VTEE.ID
			WHERE YEAR(P.Enviado)=2014
			GROUP BY E.Denominacion , E.Direccion , VTEE.[numero de empleados]	


--EJERCICIO 5

CREATE VIEW VTHeladosTotales AS                      --Esta tabla muestar el total de helados vendidos de cada sabor
		SELECT H.Sabor , COUNT(H.ID) AS [Numero De Helados Vendidos]  
			FROM ICHelados AS H 
		GROUP BY H.Sabor


CREATE VIEW VTHeladosPopu AS  --Esta tabla muestra la popularidad de cada helado en %     --Nosalen los %
		SELECT H.Sabor , (VTHT.[Numero De Helados Vendidos] / SUM(VTHT.[Numero De Helados Vendidos])*100) AS porcentajePopularidad
			FROM ICHelados AS H INNER JOIN VTHeladosTotales AS VTHT ON H.Sabor = VTHT.Sabor
		GROUP BY H.Sabor ,VTHT.[Numero De Helados Vendidos]
