/*
2. Escribe un procedimiento almacenado que reciba como parámetro el ID de un pasajero y
devuelva en un parámetro de salida el número de vuelos diferentes que ha tomado ese pasajero.
*/

ALTER PROCEDURE DARNUMEROVUELOS @IDPasajero char(9), @Salida INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SELECT @Salida = COUNT(DISTINCT ALVP.Codigo_Vuelo) FROM AL_Pasajes
	INNER JOIN AL_Vuelos_Pasajes AS ALVP ON AL_Pasajes.Numero = ALVP.Numero_Pasaje
	WHERE ID_Pasajero = @IDPasajero
END
GO
-- Pruebas 
DECLARE @numerovuelos int 
EXECUTE DARNUMEROVUELOS 'A007',@numerovuelos OUTPUT
PRINT 'Ha tomado: '+cast(@numerovuelos as varchar)+' vuelos diferentes'
GO
-- Versión function
CREATE Function CuantosVUELOS (@IDPasajero char(9))
RETURNS INT 
AS
BEGIN
	DECLARE @Salida INT
	SELECT @Salida = COUNT(DISTINCT ALVP.Codigo_Vuelo) FROM AL_Pasajes
	INNER JOIN AL_Vuelos_Pasajes AS ALVP ON AL_Pasajes.Numero = ALVP.Numero_Pasaje
	WHERE ID_Pasajero = @IDPasajero
	RETURN @Salida
END
GO
-- Pruebas 
PRINT 'Ha tomado: '+cast(dbo.CuantosVuelos ('A007') as varchar)+' vuelos diferentes'
-- Otra
SELECT Nombre, Apellidos, Nacionalidad, dbo.CuantosVuelos (ID) AS [Numero de vuelos] FROM AL_Pasajeros
	WHERE dbo.CuantosVuelos (ID) > 5