--Boletín 11.2
--Sobre la base de datos AirLeo.
set dateformat ymd
USE AirLeo

--Ejercicio 1
--Escribe un procedimiento que cancele un pasaje y las tarjetas de embarque asociadas.

GO
ALTER PROCEDURE cancelarPasaje @idPasaje int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE AL_Tarjetas       WHERE Numero_Pasaje = @idPasaje
	DELETE AL_Vuelos_Pasajes WHERE Numero_Pasaje = @idPasaje
	DELETE AL_Pasajes        WHERE Numero	    	 = @idPasaje
	COMMIT TRANSACTION
END
GO

BEGIN TRANSACTION
EXEC cancelarPasaje 8
COMMIT TRANSACTION
ROLLBACK TRANSACTION

--Recibirá como parámetros el ID del pasaje.

--Ejercicio 2
--Escribe un procedimiento almacenado que reciba como parámetro el ID de un pasajero
-- y devuelva en un parámetro de salida el número de vuelos diferentes que ha tomado ese pasajero.

GO
CREATE PROCEDURE getNumeroVuelosDiferentesPasajero
	@idPasajero char(9),
	@numeroVuelos INT OUTPUT
AS
BEGIN
	SELECT @numeroVuelos = COUNT(V.Codigo) 
	FROM AL_Vuelos AS V
	INNER JOIN AL_Tarjetas AS T
	ON V.Codigo = T.Codigo_Vuelo
	INNER JOIN AL_Pasajes AS P
	ON T.Numero_Pasaje = P.Numero
	INNER JOIN AL_Pasajeros AS PA
	ON P.ID_Pasajero = PA.ID
	WHERE @idPasajero = PA.ID
	RETURN
END

DECLARE @numeroVuelosPorPasajero int
EXEC getNumeroVuelosDiferentesPasajero 'A007', @numeroVuelosPorPasajero OUTPUT
PRINT @numeroVuelosPorPasajero
GO

--Ejercicio 3
--Escribe un procedimiento almacenado que reciba como parámetro el ID de un pasajero y dos fechas y
--nos devuelva en otro parámetro (de salida) el número de horas que ese pasajero ha volado durante
-- ese intervalo de fechas.

--Contamos los vuelo completados (fecha salida y fecha llegada dentro del rango)
GO
ALTER PROCEDURE getNumeroHorasDeVueloPorPasajero
	@idPasajero   char(9),
	@inicio       SMALLDATETIME,
	@fin          SMALLDATETIME,
	@numeroHoras  INT OUTPUT
AS
BEGIN
	SELECT @numeroHoras = SUM(DATEDIFF(HOUR,V.Salida, V.Llegada)) 
	FROM AL_Vuelos AS V
	INNER JOIN AL_Tarjetas AS T
	ON V.Codigo = T.Codigo_Vuelo
	INNER JOIN AL_Pasajes AS P
	ON T.Numero_Pasaje = P.Numero
	INNER JOIN AL_Pasajeros AS PA
	ON P.ID_Pasajero = PA.ID
	WHERE @idPasajero = PA.ID AND V.Salida BETWEEN @inicio AND @fin AND V.Llegada BETWEEN @inicio AND @fin
	RETURN
END
GO

-- Ejecutamos el procedure
GO
DECLARE @fechaInicio SMALLDATETIME
DECLARE @fechaFin SMALLDATETIME

SET @fechaInicio = '2005-02-02 00:00:00'
SET @fechaFin = '2008-02-02 00:00:00'

DECLARE @numeroHorasPasajero int
EXEC getNumeroHorasDeVueloPorPasajero 'A007', @fechaInicio, @fechaFin, @numeroHorasPasajero OUTPUT
PRINT @numeroHorasPasajero
GO

--Ejercicio 4
--Escribe un procedimiento que reciba como parámetro todos los datos de un pasajero y un número de vuelo y realice el siguiente proceso:
--En primer lugar, comprobará si existe el pasajero. Si no es así, lo dará de alta.
--A continuación comprobará si el vuelo tiene plazas disponibles (hay que consultar la capacidad del avión) y en caso afirmativo creará un nuevo pasaje para ese vuelo.

CREATE PROCEDURE ComprobarPlazasYCrearPasaje
		@IDPasajero char(9),
		@Nombre varchar(20), 
		@Apellidos varchar(50),
		@Direccion varchar(60),
		@Fecha_Nacimiento date ,
		@Nacionalidad varchar(30),
		@NumeroVuelo int
AS
BEGIN 	
	DECLARE @NumeroTotalDePasajes int --Declaramos variable para guardar el numero de pasajes que tiene el vuelo que hemos indicado(@numerovuelo)
	DECLARE @NumeroDelPasaje int --Declaramos la variable numero del pasaje(código) que se autorellenará al ser IDENTITY
	DECLARE @CapacidadAvion int --Declaramos variable para guardar la capacidad del avión

	IF NOT EXISTS(SELECT * FROM AL_Pasajeros WHERE ID=@IDPasajero) --Comprobamos que el cliente no existe
		BEGIN
			INSERT AL_Pasajeros (ID,Nombre,Apellidos,Direccion,Fecha_Nacimiento,Nacionalidad)  --Insertamos el nuevo cliente
			VALUES(@IDPasajero,@Nombre,@Apellidos,@Direccion,@Fecha_Nacimiento,@Nacionalidad)
		END
	ELSE 
		BEGIN
			PRINT 'El cliente ya existe '
		END

	-- Comprobamos la capacidad del avion
	SELECT @CapacidadAvion = Filas*Asientos_x_Fila FROM AL_Aviones AS A
	INNER JOIN AL_Vuelos AS V ON A.Matricula = V.Matricula_Avion
	WHERE @NumeroVuelo = V.Codigo 

	-- Comprobamos numero total de pasajes
	SELECT @NumeroTotalDePasajes = COUNT(Numero_Pasaje) FROM AL_Vuelos_Pasajes AS VP
	WHERE @NumeroVuelo = VP.Codigo_Vuelo	
	
	BEGIN TRANSACTION 
	IF ( @CapacidadAvion > @NumeroTotalDePasajes ) --Comprobamos si hay plazas disponibles en el vuelo que hemos indicado(@numerovuelo) 
		BEGIN 
		BEGIN TRANSACTION
			INSERT AL_Pasajes(ID_Pasajero)
			VALUES(@IDPasajero)
			
			SET @NumeroDelPasaje = @@IDENTITY  --Rellanamos la variable numero del pasaje con IDENTITY

			INSERT AL_Vuelos_Pasajes(Codigo_Vuelo,Numero_Pasaje,Embarcado) --Insertamos un nuevo pasaje con las variables creadas
			VALUES(@NumeroVuelo,@NumeroDelPasaje,'N')
		COMMIT TRANSACTION 
		
		END
	ELSE
		BEGIN
			RAISERROR('El avión está completamente lleno',4,1) --Mostramos un mensaje si no hay plazas disponibles en el vuelo que hemos insertado(@numerovuelo)
		END
-- END IF
COMMIT TRANSACTION 
END

GO
SET DATEFORMAT YMD
DECLARE @IDPasajero char(9) = 'J334'
DECLARE @Nombre varchar(20) = 'Nzdeh'
DECLARE	@Apellidos varchar(50) = 'Yeghyzarian'
DECLARE	@Direccion varchar(60) = 'Make Armenia Great Again'
DECLARE	@Fecha_Nacimiento date = '1997-09-05'
DECLARE	@Nacionalidad varchar(30) = 'Armenia'
DECLARE	@NumeroVuelo int = '3'

EXECUTE ComprobarPlazasYCrearPasaje @IDPasajero,@Nombre,@Apellidos,@Direccion,@Fecha_Nacimiento,@Nacionalidad,@NumeroVuelo

SELECT * FROM AL_Pasajeros
SELECT * FROM AL_Pasajes
SELECT * FROM AL_Vuelos



--Ejercicio 5
--Escribe un procedimiento almacenado que cancele un vuelo y reubique a sus pasajeros en otro. 
--Se ocuparán los asientos libres en el vuelo sustituto. 
--Se comprobará que ambos vuelos realicen el mismo recorrido. 
--Se borrarán todos los pasajes y las tarjetas de embarque y se generarán nuevos pasajes. 
--No se generarán nuevas tarjetas de embarque. El vuelo a cancelar y el sustituto se pasarán como parámetros. 
--Si no se pasa el vuelo sustituto, se buscará el primer vuelo inmediatamente posterior al cancelado que realice
--el mismo recorrido.
GO
ALTER PROCEDURE cancelarYReubicarPasajeros 
	@codigoVuelo int
AS
BEGIN 
	DECLARE @asientosLibresVueloSustituto int
	DECLARE @aeroPuertoSalida char(3)
	DECLARE @aeroPuertoLlegada char(3)
	DECLARE @CapacidadAvion int 

	-- Ver aueropuerto de salida y llegada
	SELECT @aeroPuertoSalida = Aeropuerto_Salida, @aeroPuertoLlegada = Aeropuerto_Llegada 
	FROM AL_Vuelos
	WHERE @codigoVuelo = Codigo

	-- Comprobar que vuelos hacen el mismo recorrido
	SELECT * FROM AL_Vuelos
	WHERE Aeropuerto_Salida = @aeroPuertoSalida AND Aeropuerto_Llegada = @aeroPuertoLlegada

	-- Comprobamos asientos libres en el vuelo
	SELECT @asientosLibresVueloSustituto = Filas*Asientos_x_Fila 
	FROM AL_Aviones AS A
	INNER JOIN AL_Vuelos AS V ON A.Matricula = V.Matricula_Avion
	WHERE @codigoVuelo = V.Codigo 

	-- Comprobamos capacidad del avion
	SELECT @CapacidadAvion = Filas*Asientos_x_Fila FROM AL_Aviones AS A
	INNER JOIN AL_Vuelos AS V ON A.Matricula = V.Matricula_Avion
	WHERE @codigoVuelo = V.Codigo 

	

	RETURN
END
GO

GO
EXEC cancelarYReubicarPasajeros 3
GO

SELECT * FROM AL_Vuelos

--Ejercicio 6
--Escribe un procedimiento al que se pase como parámetros un código de un avión y un momento (dato fecha-hora)
--y nos escriba un mensaje que indique dónde se encontraba ese avión en ese momento. 
--El mensaje puede ser "En vuelo entre los aeropuertos de NombreAeropuertoSalida y NombreaeropuertoLlegada” 
--si el avión estaba volando en ese momento, o "En tierra en el aeropuerto NombreAeropuerto” si no está volando. 
--Para saber en qué aeropuerto se encuentra el avión debemos consultar el último vuelo que realizó antes 
--del momento indicado. Si se omite el segundo parámetro, se tomará el momento actual.