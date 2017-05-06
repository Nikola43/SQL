--Ejercicio 0
USE LeoMetroV2
SET Dateformat 'ymd'

--La dimisión de Esperanza Aguirre ha causado tal conmoción entre los directivos de LeoMetro que han decidido conceder una amnistía a todos 
--los pasajeros que tengan un saldo negativo en sus tarjetas.

--Crea un procedimiento que racargue la cantidad necesaria para dejar a 0 el saldo de las tarjetas que tengan un saldo negativo y hayan sido recargadas al menos una vez en los últimos dos meses.
--Ejercicio elaborado en colaboración con Sefran.

GO
BEGIN TRANSACTION

UPDATE LM_Tarjetas         -- Actualizamos LM_Tarjetas
SET Saldo += (-Saldo)  -- Cogemos el saldo negativo, lo convetimos en positivo y se lo sumamos al saldo de la tarjeta
FROM LM_Tarjetas AS T
INNER JOIN LM_Recargas AS R
ON T.ID = R.ID_Tarjeta
Where Saldo < 0 AND R.Momento_Recarga > DATEADD(MONTH, -2,  CURRENT_TIMESTAMP)    -- Cuando tengan el saldo negativo y haya sido recargada al menos una vez en los dos ultimos dos mese

ROLLBACK TRANSACTION
GO
--Ejercicio 1

SELECT * FROM LM_Recargas


--Crea un procedimiento RecargarTarjeta que reciba como parámetros el ID de una tarjeta y un importe y actualice el saldo de la tarjeta sumándole dicho importe, además de grabar la correspondiente recarga
GO
CREATE PROCEDURE RecargarTarjeta @id_Tarjeta int, @importe smallmoney
AS
BEGIN
	BEGIN TRANSACTION
	-- Insertamos el importe en la tarjeta
	UPDATE LM_Tarjetas
	SET Saldo += @importe
	FROM LM_Tarjetas 
	WHERE ID = @id_Tarjeta

	-- Insertamos en recargas
	INSERT INTO LM_Recargas(ID, ID_Tarjeta, Cantidad_Recarga, Momento_Recarga, SaldoResultante)
	SELECT NEWID(), ID, @importe, CURRENT_TIMESTAMP, Saldo
	FROM LM_Tarjetas
	WHERE ID = @id_Tarjeta
	COMMIT TRANSACTION
END
GO

BEGIN TRANSACTION
EXEC RecargarTarjeta 1, 1
COMMIT TRANSACTION
ROLLBACK TRANSACTION

SELECT * FROM LM_Tarjetas
WHERE ID = 9

SELECT * 
FROM LM_Recargas

SELECT 

--Ejercicio 2

--Crea un procedimiento almacenado llamado PasajeroSale que reciba como parámetros el ID de una tarjeta, el ID de una estación y una fecha/hora (opcional).
--El procedimiento se llamará cuando un pasajero pasa su tarjeta por uno de los tornos de salida del metro.
--Su misión es grabar la salida en la tabla LM_Viajes. 
--Para ello deberá localizar la entrada que corresponda, que será la última entrada correspondiente al mismo pasajero y hará un update de las columnas que corresponda.
--Si no existe la entrada, grabaremos una nueva fila en LM_Viajes dejando a NULL la estación y el momento de entrada.
--Si se omite el parámetro de la fecha/hora, se tomará la actual.
GO
ALTER PROCEDURE PasajeroSale @id_Tarjeta int, @id_Estacion smallint, @fecha smalldateTime = NULL
AS
BEGIN
	BEGIN TRANSACTION

	-- Creamos una variable para almacenar la ultima entrada 
	DECLARE @ultimaEntrada Smalldatetime

	-- Asignamos a la variable la ultima entrada
	SET @ultimaEntrada =
	(
		SELECT MAX(V.MomentoEntrada) AS MomentoEntrada
		FROM LM_Viajes AS V
		INNER JOIN LM_Tarjetas AS T
		ON V.IDTarjeta = T.ID
		INNER JOIN LM_Pasajeros AS P
		ON T.IDPasajero = P.ID
		WHERE T.ID = @id_Tarjeta AND V.IDEstacionEntrada = @id_Estacion AND T.IDPasajero = P.ID
	)

	IF @fecha IS NULL
		BEGIN
			-- Si no existe la entrada
			IF @ultimaEntrada IS NULL
				BEGIN
					BEGIN TRANSACTION

					INSERT INTO LM_Viajes(ID, IDTarjeta, IDEstacionEntrada, IDEstacionSalida, MomentoEntrada, MomentoSalida, Importe_Viaje)
					VALUES(200, @id_Tarjeta, NULL, NULL, NULL, CURRENT_TIMESTAMP, 2)

					COMMIT TRANSACTION
				END
		END
	ELSE
		BEGIN
		-- Si no existe la entrada
			IF @ultimaEntrada IS NULL
				BEGIN
					BEGIN TRANSACTION

					INSERT INTO LM_Viajes(ID, IDTarjeta, IDEstacionEntrada, IDEstacionSalida, MomentoEntrada, MomentoSalida, Importe_Viaje)
					VALUES(200, @id_Tarjeta, NULL, NULL, NULL, @fecha, 2)

					COMMIT TRANSACTION

				END
		END
	COMMIT TRANSACTION
END
GO

--Ejecucion
BEGIN TRANSACTION
EXEC PasajeroSale 7, 2
COMMIT TRANSACTION
ROLLBACK TRANSACTION

--Ejercicio 3
--A veces, un pasajero reclama que le hemos cobrado un viaje de forma indebida. Escribe un procedimiento que reciba como parámetro el ID de un pasajero 
--y la fecha y hora de la entrada en el metro y anule ese viaje, actualizando además el saldo de la tarjeta que utilizó.
GO
CREATE PROCEDURE anularViaje @id_Pasajero int, @fechaEntrada smalldateTime
AS
BEGIN
	DECLARE @importeViaje smallmoney

	-- Sacamos el importe del viaje para luego devolverlo
	SET @importeViaje = 
	(
		SELECT V.Importe_Viaje
		FROM LM_Viajes AS V
		INNER JOIN LM_Tarjetas AS T
		ON V.IDTarjeta = T.ID
		INNER JOIN LM_Pasajeros AS P
		ON T.IDPasajero = P.ID
		WHERE P.ID = @id_Pasajero AND V.MomentoEntrada = @fechaEntrada
	)

	-- Actualizamos tarjeta
	BEGIN TRANSACTION

	UPDATE LM_Tarjetas
	SET Saldo += @importeViaje
	FROM LM_Viajes AS V
	INNER JOIN LM_Tarjetas AS T
	ON V.IDTarjeta = T.ID
	INNER JOIN LM_Pasajeros AS P
	ON T.IDPasajero = P.ID
	WHERE T.IDPasajero = @id_Pasajero AND V.MomentoEntrada = @fechaEntrada

	COMMIT TRANSACTION

	-- Eliminar viaje
	BEGIN TRANSACTION

	DELETE V
	FROM LM_Viajes AS V
	INNER JOIN LM_Tarjetas AS T
	ON V.IDTarjeta = T.ID
	INNER JOIN LM_Pasajeros AS P
	ON T.IDPasajero = P.ID
	WHERE P.ID = @id_Pasajero AND V.MomentoEntrada = @fechaEntrada
	
	COMMIT TRANSACTION
END
GO

--Ejecucion
BEGIN TRANSACTION
EXEC anularViaje 1, '2017-02-24 16:50:00'
COMMIT TRANSACTION
ROLLBACK TRANSACTION



--Ejercicio 4
--La empresa de Metro realiza una campaña de promoción para pasajeros fieles.

--Crea un procedimiento almacenado que recargue saldo a los pasajeros que cumplan determinados requisitos. 
--Se recargarán N1 euros a los pasajeros que hayan consumido más de 30 euros en el mes anterior (considerar mes completo, del día 1 al fin) y 
--N2 euros a los que hayan utilizado más de 10 veces alguna estación de las zonas 3 o 4. 

--Los valores de N1 y N2 se pasarán como parámetros. Si se omiten, se tomará el valor 5.

--Ambos premios son excluyentes. Si algún pasajero cumple ambas condiciones se le aplicará la que suponga mayor bonificación de las dos.
GO
ALTER PROCEDURE RecargarSaldo @importeN1 smallmoney = 5, @importeN2 smallmoney = 5
AS
BEGIN
	DECLARE @inicioMes smallDateTime 
	DECLARE @finMes smallDateTime
	DECLARE @mesAnterior smallDateTime 

	-- Guardamos el mes anterior cogiendo la fecha actual menos un mes
	SET @mesAnterior = DATEADD(MONTH, -1,  CURRENT_TIMESTAMP)
	-- Creo una nueva fecha con el año y mes anterior pero dia 1
	SET @inicioMes = DATEFROMPARTS(YEAR(@mesAnterior), MONTH(@mesAnterior), 1)
	-- Creo una nueva fehcha con el año y mes anterior pero dia 30
	SET @finMes = DATEFROMPARTS(YEAR(@mesAnterior), MONTH(@mesAnterior), 30)

	-- Creamos una tabla temporal donde insertaremos los pasajero que hayan gastado mas de 30 euros en el rango de fechas indicado
	CREATE TABLE #pasajerosImportesGastados
	(  
		ID int,
		Importe_Viaje smallmoney
	)

	-- Insertamos los pasajero que hayan gastado mas de 30 euros en el rango de fechas indicado
	BEGIN TRANSACTION
	INSERT INTO #pasajerosImportesGastados
		SELECT P.ID, SUM(V.Importe_Viaje) AS Importe_Viaje
		FROM LM_Viajes AS V
		INNER JOIN LM_Tarjetas AS T
		ON V.IDTarjeta = T.ID
		INNER JOIN LM_Pasajeros AS P
		ON T.IDPasajero = P.ID
		WHERE V.MomentoEntrada BETWEEN @inicioMes AND @finMes
		GROUP BY P.ID
		HAVING SUM(V.Importe_Viaje) > 30
	COMMIT TRANSACTION

	-- Si se omite el parametro @importeN1
	IF @importeN1 != 5
		BEGIN
			BEGIN TRANSACTION

			-- Actualizamos el saldo con el valor pasado por parametro
			UPDATE LM_Tarjetas
			SET Saldo += @importeN1
			FROM LM_Tarjetas AS T
			INNER JOIN #pasajerosImportesGastados AS P
			ON T.IDPasajero = P.ID

			-- Insertamos en recargas
			INSERT INTO LM_Recargas(ID, ID_Tarjeta, Cantidad_Recarga, Momento_Recarga, SaldoResultante)
			SELECT NEWID(), T.ID, @importeN1, CURRENT_TIMESTAMP, T.Saldo
			FROM LM_Tarjetas AS T
			INNER JOIN #pasajerosImportesGastados AS P
			ON T.IDPasajero = P.ID
			WHERE T.IDPasajero = P.ID

			COMMIT TRANSACTION
		END
	ELSE
		BEGIN
			BEGIN TRANSACTION

			-- Actualizamos el saldo con el valor por defecto del parametro
			UPDATE LM_Tarjetas
			SET Saldo += 5
			FROM LM_Tarjetas AS T
			INNER JOIN #pasajerosImportesGastados AS P
			ON T.IDPasajero = P.ID

			-- Insertamos en recargas
			INSERT INTO LM_Recargas(ID, ID_Tarjeta, Cantidad_Recarga, Momento_Recarga, SaldoResultante)
			SELECT NEWID(), T.ID, 5, CURRENT_TIMESTAMP, T.Saldo
			FROM LM_Tarjetas AS T
			INNER JOIN #pasajerosImportesGastados AS P
			ON T.IDPasajero = P.ID
			WHERE T.IDPasajero = P.ID

			COMMIT TRANSACTION
		END
END
GO

--Ejecucion
BEGIN TRANSACTION
EXEC RecargarSaldo 50, 1
COMMIT TRANSACTION
ROLLBACK TRANSACTION

--Ejercicio 5

--Crea una función que nos devuelva verdadero si es posible que un pasajero haya subido a un tren en un determinado viaje. Se pasará como parámetro el código del viaje y la matrícula del tren.

--Ejercicio 6

--Crea un procedimiento SustituirTarjeta que Cree una nueva tarjeta y la asigne al mismo usuario y con el mismo saldo que otra tarjeta existente. El código de la tarjeta a sustituir se pasará como parámetro.

--Ejercicio 7

--Las estaciones de la zona 3 tienen ciertas deficiencias, lo que nos ha obligado a introducir una serie de modificaciones en los trenes  para cumplir las medidas de seguridad.

--A consecuencia de estas modificaciones, la capacidad de los trenes se ha visto reducida en 6 plazas para los trenes de tipo 1 y 4 plazas para los trenes de tipo 2.

--Realiza un procedimiento al que se pase un intervalo de tiempo y modifique la capacidad de todos los trenes que hayan circulado más de una vez por alguna estación de la zona 3 en ese intervalo.



--Última modificación: martes, 25 de abril de 2017, 09:24