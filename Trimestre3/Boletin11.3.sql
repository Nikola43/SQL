USE TransLeo
set dateformat ymd
GO
--EJ 1. La empresa de logística (transportes y algo más) TransLeo tiene una base de datos con la
--información de los envíos que realiza. Hay una tabla llamada TL_PaquetesNormales en la que se
--guardan los datos de los paquetes que pueden meterse en una caja normal. Las cajas normales
--son paralelepípedos de base rectangular. Las columnas alto, ancho y largo, de tipo entero,
--contienen las dimensiones de cada paquete en centímetros. 

--La estructura de la tabla TL_PaquetesNormales es: 

--Columna                 tipo           Comentario                          nulos
--codigo 		          int            Es la clave                         No
--alto				      int                                                No
--ancho 			      int                                                No
--largo 			      int                                                No
--codigoFregoneta 	      int            FK del vehiculo que lo entrega      Sí
--fechaEntrega 		      smalldatetime                                      Sí

--1. Crea un función fn_VolumenPaquete que reciba el código de un paquete y nos devuelva
--su volumen. El volumen se expresa en litros (dm3) y será de tipo decimal(6,2).
GO
CREATE FUNCTION dbo.fn_VolumenPaquete(@codigoPaquete int)
RETURNS decimal(6,2)
	BEGIN
		DECLARE @volumen decimal(6,2)
		SELECT @volumen = (Alto * Ancho * CAST( Largo AS decimal(6,2)))/1000
		FROM TL_PaquetesNormales 
		WHERE @codigoPaquete = Codigo
		RETURN @volumen
	END
GO

PRINT dbo.fn_VolumenPaquete(600)

--2. Los paquetes normales han de envolverse. Se calcula que la cantidad de papel necesaria
--para envolver el paquete es 1,8 veces su superficie. Crea una función fn_PapelEnvolver
--que reciba un código de paquete y nos devuelva la cantidad de papel necesaria para
--envolverlo, en metros cuadrados.
GO
CREATE FUNCTION dbo.fn_PapelEnvolver(@codigoPaquete int)
RETURNS decimal(6,2)
	BEGIN
		DECLARE @volumen decimal(6,2)
		SELECT @volumen = (Alto * CAST( Largo AS decimal(6,2)) * 1.8)/100
		FROM TL_PaquetesNormales 
		WHERE @codigoPaquete = Codigo
		RETURN @volumen
	END
GO

PRINT dbo.fn_PapelEnvolver(600)

--3. Crea una función fn_OcupacionFregoneta a la que se pase el código de un vehículo y una
--fecha y nos indique cuál es el volumen total que ocupan los paquetes que ese vehículo
--entregó en el día en cuestión. Usa las funciones de fecha y hora para comparar sólo el
--día, independientemente de la hora.
GO
ALTER FUNCTION dbo.fn_OcupacionFregoneta(@codigoFregoneta int, @fechaEntrega Date)
RETURNS decimal(6,2)
	BEGIN
		DECLARE @volumenTotalFregoneta decimal(6,2)
		SELECT @volumenTotalFregoneta = SUM(Alto * Ancho * CAST( Largo AS decimal(6,2)))/1000
		FROM TL_PaquetesNormales 
		WHERE @codigoFregoneta = codigoFregoneta AND YEAR(@fechaEntrega) = YEAR(fechaEntrega) AND MONTH(@fechaEntrega) = MONTH(fechaEntrega) AND DAY(@fechaEntrega) = DAY(fechaEntrega)
		RETURN @volumenTotalFregoneta
	END
GO

PRINT dbo.fn_OcupacionFregoneta(6,'2015-04-01')

--4. Crea una función fn_CuantoPapel a la que se pase una fecha y nos diga la cantidad total
--de papel de envolver que se gastó para los paquetes entregados ese día. Trata la fecha
--igual que en el anterior.
GO
CREATE FUNCTION fn_CuantoPapel(@fechaEntrega Date)
RETURNS decimal(6,2)
	BEGIN
		DECLARE @papelTotal decimal(6,2)
		SELECT @papelTotal = SUM(Alto * CAST( Largo AS decimal(6,2)) * 1.8)/100
		FROM TL_PaquetesNormales 
		WHERE YEAR(@fechaEntrega) = YEAR(fechaEntrega) AND MONTH(@fechaEntrega) = MONTH(fechaEntrega) AND DAY(@fechaEntrega) = DAY(fechaEntrega)
		RETURN @papelTotal
	END
GO

PRINT dbo.fn_CuantoPapel('2015-04-01')

--5. Modifica la función anterior para que en lugar de aceptar una fecha, acepte un rango de
--fechas (inicio y fin). Si el inicio y fin son iguales, calculará la cantidad gastada ese día. Si
--el fin es anterior al inicio devolverá 0.
GO
CREATE FUNCTION fn_CuantoPapel5(@inicio Date, @fin Date)
RETURNS decimal(6,2)
	BEGIN
		DECLARE @papelTotal decimal(6,2)
		SELECT @papelTotal = SUM(Alto * CAST( Largo AS decimal(6,2)) * 1.8)/100
		FROM TL_PaquetesNormales 
		WHERE YEAR(@fechaEntrega) = YEAR(fechaEntrega) AND MONTH(@fechaEntrega) = MONTH(fechaEntrega) AND DAY(@fechaEntrega) = DAY(fechaEntrega)
		RETURN @papelTotal
	END
GO

--6. Crea una función fn_Entregas a la que se pase un rango de fechas y nos devuelva una
--tabla con los códigos de los paquetes entregados y los vehículos que los entregaron entre
--esas fechas.

-------------------------------------------------------------------------------------------------

--EJ2
--1. Diseña una función fn_distancia recorrida a la que se pase un código de avión y un rango
--de fechas y nos devuelva la distancia total recorrida por ese avión en ese rango de
--fechas.

--2. Diseña una función fn_horasVuelo a la que se pase un código de avión y un rango de
--fechas y nos devuelva las horas totales que ha volado ese avión en ese rango de fechas.

--3. Diseña una función a la que se pase un código de avión y un rango de fechas y nos
--devuelva una tabla con los nombres y fechas de todos los aeropuertos en que ha estado
--el avión en ese intervalo
GO
CREATE FUNCTION dbo.devolverMatriculaTren(@codigoAvion Int, )

GO

--4. Diseña una función fn_ViajesCliente que nos devuelva nombre y apellidos, kilómetros
--recorridos y número de vuelos efectuados por cada cliente en un rango de fechas,
--ordenado de mayor a menor distancia recorrida.


