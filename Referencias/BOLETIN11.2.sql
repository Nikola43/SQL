		--BOLETIN 11.2--
GO
USE AirLeo

/*Ejercicio 1
Escribe un procedimiento que cancele un pasaje y las tarjetas de embarque asociadas.
Recibir� como par�metros el ID del pasaje.*/
begin transaction
GO
CREATE PROCEDURE CancelarPasaje -- Creamos procedimiento
	@ID_pasaje int -- variable de entrada como parametro
AS
    -- Eliminamos los vuelos asociado
	DELETE FROM AL_Vuelos_Pasajes
	WHERE Numero_Pasaje = @ID_pasaje
	PRINT 'Vuelo borrado'

	-- Borramos el pasaje asociado
	DELETE FROM AL_Pasajes
	WHERE Numero = @ID_pasaje
	PRINT 'Pasaje borrado'

	-- Por ultimo borramos la tarjeta de embarque
	DELETE FROM AL_Tarjetas
	WHERE Numero_Pasaje = @ID_pasaje
	PRINT 'Tarjeta de embarque borrada'
GO
rollback transaction

-- Prueba de funcionamiento
-- Cancelamos el pasaje 
EXECUTE CancelarPasaje 18

select *from AL_Vuelos
select *from AL_Vuelos_Pasajes
select *from AL_Pasajes
select *from AL_Tarjetas
WHERE Numero_Pasaje = 6


/*Ejercicio 2
Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y devuelva en un par�metro de salida el n�mero de vuelos diferentes
que ha tomado ese pasajero.*/

begin transaction
GO
CREATE PROCEDURE ContarNumeroDeVuelosPorPasajero  -- Creamos procedimiento
	@ID_pasajero char(9),						  -- Variable de entrada donde se pasa el id del pasajero
	@NumeroVuelos int OUTPUT                      -- Variable de salida que guarda el numero de vuelos
AS
    BEGIN
	    -- Hacemos un select del dato que queremos almacenar en la variable de salida
		select @NumeroVuelos = COUNT(DISTINCT VP.Codigo_Vuelo)
		from AL_Pasajes AS P
		JOIN AL_Vuelos_Pasajes AS VP ON P.Numero = VP.Numero_Pasaje
		WHERE P.ID_Pasajero = @ID_pasajero -- buscamos el id pasado por parametro de entrada
	END
GO


-- Creamos variable para almacenar el numero de vuelos
DECLARE @NumeroVuelos int

-- Variable para pasarle el id que queremos buscar
DECLARE @ID_Pasajero char(9)

-- Buscamos un id de cualquier pasajero y lo almacenamos en la variable ID_pasajero
SET @ID_Pasajero = (SELECT ID FROM AL_Pasajeros WHERE Nombre = 'Adela')

-- Ejecutamos el procedimiento pasandole la variable de entrada y la de salida donde se almacenara
EXECUTE ContarNumeroDeVuelosPorPasajero @ID_pasajero, @NumeroVuelos OUTPUT

-- Imprimimos el numero de vuelos xDD
PRINT @NumeroVuelos

-- Si todo se fue a la puta, revertimos los cambios
rollback transaction







/*Ejercicio 3
Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y dos fechas y nos devuelva en otro par�metro (de salida) el n�mero 
de horas que ese pasajero ha volado durante ese intervalo de fechas.*/
BEGIN TRANSACTION
GO
CREATE PROCEDURE CalcularHorasDeVueloEntreFechas
    -- Parametro de entrada
	@ID_Pasajero char(9),
	@fecha1 smalldatetime,
	@fecha2 smalldatetime,

	--Parametros de salida
	@numeroHorasVuelo int OUTPUT
AS
	BEGIN
		SELECT @numeroHorasVuelo = SUM(DATEDIFF(SECOND, V.Salida, V.Llegada))
		FROM AL_Vuelos AS V
		JOIN AL_Vuelos_Pasajes AS VP ON V.Codigo = VP.Codigo_Vuelo
		JOIN AL_Pasajes AS P ON VP.Numero_Pasaje = P.Numero
		WHERE P.ID_Pasajero = @ID_Pasajero AND V.Salida BETWEEN @fecha1 AND @fecha2 AND V.Llegada BETWEEN @fecha1 AND @fecha2
		GROUP BY ID_Pasajero
	END
GO


-- Creamos variable para almacenar la salida del procedimiento
DECLARE @segundosDeVuelo int

-- Creamos variables donde le meteremos las fechas que iran como parametro
DECLARE @fecha1 smalldatetime
DECLARE @fecha2 smalldatetime

-- Variable para pasarle el id que queremos buscar
DECLARE @ID_Pasajero char(9)

-- Buscamos un id de cualquier pasajero y lo almacenamos en la variable ID_pasajero
SET @ID_Pasajero = (SELECT ID FROM AL_Pasajeros WHERE Nombre = 'Adela')

-- Almacenamos las fechas que le pasaremos como parametro
SET @fecha1 = '20-4-2012'
SET @fecha2 = '20-5-2013'

-- Ejecutamos el procedimiento pasandole la variable de entrada y la de salida donde se almacenara
EXECUTE CalcularHorasDeVueloEntreFechas @ID_Pasajero, @fecha1, @fecha2, @segundosDeVuelo OUTPUT

-- Imprimimos el numero de horas de vuelos
PRINT ((@segundosDeVuelo / 60.00) / 60.00)

ROLLBACK TRANSACTION

/*Ejercicio 4
Escribe un procedimiento que reciba como par�metro todos los datos de un pasajero y un n�mero de vuelo y realice el siguiente proceso:

En primer lugar, comprobar� si existe el pasajero. Si no es as�, lo dar� de alta.

A continuaci�n comprobar� si el vuelo tiene plazas disponibles (hay que consultar la capacidad del avi�n) y en caso afirmativo crear� un nuevo pasaje 
para ese vuelo.*/

SELECT Codigo_Vuelo, Fila_Asiento, Letra_Asiento FROM AL_Tarjetas
WHERE Codigo_Vuelo = 2

SELECT Matricula ,filas, Asientos_x_Fila FROM AL_Aviones
SELECT * FROM AL_Tarjetas

DECLARE @filaActual int
DECLARE @filaMAX int

-- Maximo de filas
SELECT @filaMAX = filas FROM AL_Aviones WHERE Matricula = 'ESP2345'
PRINT @filaMAX

SET @filaActual = (SELECT Fila_Asiento FROM AL_Tarjetas WHERE Matricula = 'ESP2345')

WHILE (@filaActual < @filaMAX)
    BEGIN
		IF NOT EXISTS (SELECT Fila_Asiento FROM AL_Tarjetas)
		BEGIN
			PRINT 'Existe'
		END
    END






BEGIN TRANSACTION
GO
CREATE PROCEDURE CrearNuevoPasaje
	-- Datos del nuevo pasajero
	@ID	char(9),
	@Nombre varchar(20),
	@Apellidos varchar(50),
	@Direccion varchar(60),
	@Fecha_Nacimiento date,
	@Nacionalidad varchar(50),

	-- Vuelo
	@numeroVuelo int

AS
	BEGIN
		SELECT * FROM AL_Pasajeros

		IF NOT exists (SELECT Nombre FROM AL_Pasajeros WHERE Nombre = 'Pepito' AND Apellidos = 'Rodriguez')
			BEGIN 
				PRINT 'El usuario Pasajero no existe. Procederemos a crearlo'
				INSERT INTO AL_Pasajeros(ID, Nombre, Apellidos, Direccion, Fecha_Nacimiento, Nacionalidad)
				VALUES (@ID, @Nombre, @Apellidos, @Direccion, @Fecha_Nacimiento, @Nacionalidad)
			END
		ELSE
			BEGIN -- inicio else
				PRINT 'El Pasajero ya existe. Le asignaremos un asiento en el vuelo'
			END  -- en else
	END
GO
ROLLBACK TRANSACTION




/*Ejercicio 5
Escribe un procedimiento almacenado que cancele un vuelo y reubique a sus pasajeros en otro. Se ocupar�n los asientos libres en el vuelo sustituto.
Se comprobar� que ambos vuelos realicen el mismo recorrido. Se borrar�n todos los pasajes y las tarjetas de embarque y se generar�n nuevos pasajes.
No se generar�n nuevas tarjetas de embarque. El vuelo a cancelar y el sustituto se pasar�n como par�metros. Si no se pasa el vuelo sustituto, 
se buscar� el primer vuelo inmediatamente posterior al cancelado que realice el mismo recorrido.*/

/*Ejercicio 6
Escribe un procedimiento al que se pase como par�metros un c�digo de un avi�n y un momento (dato fecha-hora) y nos escriba un mensaje que indique 
d�nde se encontraba ese avi�n en ese momento. El mensaje puede ser "En vuelo entre los aeropuertos de NombreAeropuertoSalida y NombreaeropuertoLlegada� 
si el avi�n estaba volando en ese momento, o "En tierra en el aeropuerto NombreAeropuerto� si no est� volando. Para saber en qu� aeropuerto se encuentra 
el avi�n debemos consultar el �ltimo vuelo que realiz� antes del momento indicado.
Si se omite el segundo par�metro, se tomar� el momento actual.*/