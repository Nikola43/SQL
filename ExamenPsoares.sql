USE LeoFest
GO

--Ejercicio 1
--Escribe un procedimiento almacenado que de de baja a una banda, actualizando su fecha de disolución y la fecha de abandono de todos sus componentes actuales. 
--La fecha de disolución y el ID de la banda se pasarán como parámetros. Si no se especifica fecha, se tomará la actual.
GO
ALTER PROCEDURE darBajaBanda @nombreBanda varchar(50), @fechaDisolucion date = NULL
AS 
BEGIN

	BEGIN TRANSACTION

	-- Si no se pasa la fecha, se coge la actual
	IF @fechaDisolucion IS NULL
		BEGIN
			-- Actualizamos en la tabla musicos bandas la fecha de abandono del musico
			UPDATE LFMusicosBandas
			SET FechaAbandono = CURRENT_TIMESTAMP -- Fecha actual
			FROM LFMusicosBandas AS M
			INNER JOIN LFBandas AS B
			ON M.IDBanda = B.ID
			WHERE B.NombreBanda = @nombreBanda

			-- Actualizamos en Bandas la fecha de disolucion
			UPDATE LFBandas 
			SET FechaDisolucion = CURRENT_TIMESTAMP
			WHERE NombreBanda = @nombreBanda;
		END
	ELSE
		BEGIN 
			-- Actualizamos en la tabla musicos bandas la fecha de abandono del musico
			UPDATE LFMusicosBandas
			SET FechaAbandono = @fechaDisolucion -- Fecha pasada por parametro
			FROM LFMusicosBandas AS M
			INNER JOIN LFBandas AS B
			ON M.IDBanda = B.ID
			WHERE B.NombreBanda = @nombreBanda

			-- Actualizamos en Bandas la fecha de disolucion
			UPDATE LFBandas 
			SET FechaDisolucion = @fechaDisolucion
			WHERE NombreBanda = @nombreBanda;
		END
	COMMIT TRANSACTION
END
GO

BEGIN TRANSACTION

EXEC darBajaBanda 'Flower Power', '2012-01-02'

COMMIT TRANSACTION
--ROLLBACK TRANSACTION

-- Comprobamos que se ha actualizado el campo fecha de abandono
SELECT * FROM LFBandas
WHERE NombreBanda = 'Flower Power'

-- Comprobamos que todos los musicos de esa banda tiene la misma fecha de abandono
SELECT M.ID, MB.FechaAbandono
FROM LFBandas AS B
INNER JOIN LFMusicosBandas AS MB
ON B.ID = MB.IDBanda
INNER JOIN LFMusicos  AS M
ON MB.IDMusico = M.ID
WHERE B.NombreBanda = 'Flower Power'


--Ejercicio 2
-- Escribe una función que reciba como parámetro un año y nos devuelva una tabla indicando cuantas canciones (temas) de cada estilo se han cantado en los distintos festivales
-- celebrados a lo largo de ese año, el mismo dato para el año inmediatamente anterior y una cuarta columna en la que aparezca un símbolo "+” si ha aumentado el número de canciones 
-- de ese estilo respecto al año anterior, un "-” si ha disminuido y un "=” si no varía.
-- El resultado tendrá cuatro columnas: Estilo, número de interpretaciones de ese estilo en el año anterior, número de interpretaciones de ese estilo 
-- en el año que nos piden y símbolo que indique aumento o disminución.
-- Puedes hacer otras funciones auxiliares a las que llames, pero no declarar vistas.

GO
ALTER FUNCTION dbo.cancionesCantadasPorAnio( @anio int )
RETURNS TABLE AS
RETURN 
(
	SELECT Es.Estilo AS Estilo, COUNT(TBE.IDTema) AS NumeroVecesCantada
	FROM LFEstilos AS Es
	INNER JOIN LFTemas AS T
	ON Es.ID = T.IDEstilo
	INNER JOIN LFTemasBandasEdiciones AS TBE
	ON T.ID = TBE.IDTema 
	INNER JOIN LFEdiciones AS Ed
	ON TBE.Ordinal = Ed.Ordinal
	WHERE  YEAR(Ed.FechaHoraInicio) = @anio AND YEAR(Ed.FechaHoraFin) = @anio
	GROUP BY Estilo
)
GO

GO
ALTER FUNCTION cancionesCantadasFestivales( @anio int )
RETURNS TABLE AS
RETURN 
(
	SELECT CCAActual.Estilo, CCAActual.NumeroVecesCantada, CCAAnterior.NumeroVecesCantada AS NumeroVecesCantadaAnioAnterior, (CCAActual.NumeroVecesCantada - CCAAnterior.NumeroVecesCantada) AS Diferencia, CASE   
																																																		        WHEN CCAActual.NumeroVecesCantada > CCAAnterior.NumeroVecesCantada THEN '+' 
																																																				WHEN CCAActual.NumeroVecesCantada < CCAAnterior.NumeroVecesCantada THEN '-' 
																																																				WHEN CCAActual.NumeroVecesCantada < CCAAnterior.NumeroVecesCantada THEN '=' 
																																																			END  AS Resultado 
	FROM dbo.cancionesCantadasPorAnio(@anio) AS CCAActual
	INNER JOIN dbo.cancionesCantadasPorAnio(@anio - 1) AS CCAAnterior
	ON CCAActual.Estilo = CCAAnterior.Estilo
)
GO

SELECT * FROM cancionesCantadasFestivales(2017)





--Ejercicio 3
--Escribe un procedimiento TemaEjecutado y anote en la tabla LFTemasBandasEdiciones que una banda ha interpretado ese tema en una edición concreta de un festival.
--Los datos de entrada son: Titulo, IDAutor, Estilo (nombre del estilo), Duracion, El Id de un festival, el ordinal de la edición, el ID de una banda y una fecha/hora.
--Si el tema es nuevo y no está dado de alta en la base de datos, se insertará en la tabla correspondiente. Si el estilo no existe, también se dará de alta.

GO
ALTER PROCEDURE TemaEjecutado @titulo varchar(120), @ID_Autor int, @estilo varchar(30), @duracion time(7), @ID_Festival int, @ordinalEdicion tinyInt, @ID_Banda int
AS 
BEGIN
	BEGIN TRANSACTION

	-- Primero comprobamos si el estilo existe, si no existe ese estilo lo insertamos en la tablas de estilos
	IF NOT EXISTS (SELECT Estilo FROM LFEstilos WHERE Estilo = @estilo)
		BEGIN 
			-- Si no existe lo creamos
			INSERT INTO LFEstilos
			SELECT (MAX(ID) + 1), @estilo -- Insertamos el ultimo id + 1 (simulando identity) y el nombre del estilo
			FROM LFEstilos
		END

	-- Luego comprobamos si la cancion existe, si no existe la insertamos en la tabla de temas
	IF NOT EXISTS (SELECT Titulo FROM LFTemas WHERE Titulo = @titulo)
		BEGIN 
			-- Si no existe la cancion la creamos
			INSERT INTO LFTemas
			SELECT NEWID(), @titulo, @ID_Autor, (SELECT ID FROM LFEstilos WHERE Estilo = @estilo), @duracion
		END

	-- Por ultimo insertamos en LFTemasBandasEdiciones
	INSERT INTO LFTemasBandasEdiciones
	SELECT @ID_Banda, @ID_Festival, @ordinalEdicion, (SELECT ID FROM LFTemas WHERE Titulo = @titulo)

	COMMIT TRANSACTION

END
GO

-- EJECUCION 

BEGIN TRANSACTION

EXEC TemaEjecutado 'Cantando bajo el servidor', 6, 'EstiloPropio', '00:03:30.0000000', 1, 1, 1

COMMIT TRANSACTION
ROLLBACK TRANSACTION


-- Comprobamos que existe el tema
SELECT * FROM LFTemas WHERE Titulo = 'Cantando bajo el servidor'

-- Comprobamos que existe el estilo 
SELECT * FROM LFEstilos WHERE Estilo = 'EstiloPropio'

-- Comprobamos que la banda interpretó ese tema
SELECT * FROM LFTemasBandasEdiciones WHERE IDTema = ( SELECT ID FROM LFTemas WHERE Titulo = 'Cantando bajo el servidor' )




--Ejercicio 4
--Escribe un procedimiento almacenado que actualice la columna caché de la tabla LFBandas de acuerdo a las siguientes reglas:

--Se computarán 105 € por cada miembro activo de la banda
--Se añadirán 170 € por cada actuación en los tres años anteriores
--Esa cantidad se incrementará un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y se decrementará un 50% si toca Reggaeton o Hip-Hop
--Nota: Valora la posibilidad de diseñar funciones para comprobar las condiciones.
--Que el Fliying Spaguetti Monster guíe tus pasos
--Última modificación: martes, 16 de mayo de 2017, 08:31


