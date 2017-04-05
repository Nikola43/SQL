--Boletín 11.2
--Sobre la base de datos AirLeo.
USE AirLeo

--Ejercicio 1
--Escribe un procedimiento que cancele un pasaje y las tarjetas de embarque asociadas.

GO
aLtEr PrOcEdUrE cancelarPasaje @idPasaje int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE AL_Tarjetas       WHERE Numero_Pasaje = @idPasaje
	DELETE AL_Vuelos_Pasajes WHERE Numero_Pasaje = @idPasaje
	DELETE AL_Pasajes        WHERE Numero		 = @idPasaje
	COMMIT TRANSACTION
END
GO

BEGIN TRANSACTION
EXEC cancelarPasaje 8
COMMIT TRANSACTION
ROLLBACK TRANSACTION

--Recibirá como parámetros el ID del pasaje.

--Ejercicio 2
--Escribe un procedimiento almacenado que reciba como parámetro el ID de un pasajero y devuelva en un parámetro de salida el número de vuelos diferentes que ha tomado ese pasajero.

--Ejercicio 3
--Escribe un procedimiento almacenado que reciba como parámetro el ID de un pasajero y dos fechas y nos devuelva en otro parámetro (de salida) el número de horas que ese pasajero ha volado durante ese intervalo de fechas.

--Ejercicio 4
--Escribe un procedimiento que reciba como parámetro todos los datos de un pasajero y un número de vuelo y realice el siguiente proceso:

--En primer lugar, comprobará si existe el pasajero. Si no es así, lo dará de alta.

--A continuación comprobará si el vuelo tiene plazas disponibles (hay que consultar la capacidad del avión) y en caso afirmativo creará un nuevo pasaje para ese vuelo.

--Ejercicio 5
--Escribe un procedimiento almacenado que cancele un vuelo y reubique a sus pasajeros en otro. Se ocuparán los asientos libres en el vuelo sustituto. Se comprobará que ambos vuelos realicen el mismo recorrido. Se borrarán todos los pasajes y las tarjetas de embarque y se generarán nuevos pasajes. No se generarán nuevas tarjetas de embarque. El vuelo a cancelar y el sustituto se pasarán como parámetros. Si no se pasa el vuelo sustituto, se buscará el primer vuelo inmediatamente posterior al cancelado que realice el mismo recorrido.

--Ejercicio 6
--Escribe un procedimiento al que se pase como parámetros un código de un avión y un momento (dato fecha-hora) y nos escriba un mensaje que indique dónde se encontraba ese avión en ese momento. El mensaje puede ser "En vuelo entre los aeropuertos de NombreAeropuertoSalida y NombreaeropuertoLlegada” si el avión estaba volando en ese momento, o "En tierra en el aeropuerto NombreAeropuerto” si no está volando. Para saber en qué aeropuerto se encuentra el avión debemos consultar el último vuelo que realizó antes del momento indicado.
--Si se omite el segundo parámetro, se tomará el momento actual.

--Última modificación: viernes, 8 de abril de 2016, 13:53