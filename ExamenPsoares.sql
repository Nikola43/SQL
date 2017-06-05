USE LeoFest
GO

--Ejercicio 1
--Escribe un procedimiento almacenado que de de baja a una banda, actualizando su fecha de disoluci�n y la fecha de abandono de todos sus componentes actuales. 
--La fecha de disoluci�n y el ID de la banda se pasar�n como par�metros. Si no se especifica fecha, se tomar� la actual.
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
-- Escribe una funci�n que reciba como par�metro un a�o y nos devuelva una tabla indicando cuantas canciones (temas) de cada estilo se han cantado en los distintos festivales
-- celebrados a lo largo de ese a�o, el mismo dato para el a�o inmediatamente anterior y una cuarta columna en la que aparezca un s�mbolo "+� si ha aumentado el n�mero de canciones 
-- de ese estilo respecto al a�o anterior, un "-� si ha disminuido y un "=� si no var�a.
-- El resultado tendr� cuatro columnas: Estilo, n�mero de interpretaciones de ese estilo en el a�o anterior, n�mero de interpretaciones de ese estilo 
-- en el a�o que nos piden y s�mbolo que indique aumento o disminuci�n.
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
--Escribe un procedimiento TemaEjecutado y anote en la tabla LFTemasBandasEdiciones que una banda ha interpretado ese tema en una edici�n concreta de un festival.
--Los datos de entrada son: Titulo, IDAutor, Estilo (nombre del estilo), Duracion, El Id de un festival, el ordinal de la edici�n, el ID de una banda y una fecha/hora.
--Si el tema es nuevo y no est� dado de alta en la base de datos, se insertar� en la tabla correspondiente. Si el estilo no existe, tambi�n se dar� de alta.

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

-- Comprobamos que la banda interpret� ese tema
SELECT * FROM LFTemasBandasEdiciones WHERE IDTema = ( SELECT ID FROM LFTemas WHERE Titulo = 'Cantando bajo el servidor' )




--Ejercicio 4
--Escribe un procedimiento almacenado que actualice la columna cach� de la tabla LFBandas de acuerdo a las siguientes reglas:

--Se computar�n 105 � por cada miembro activo de la banda
--Se a�adir�n 170 � por cada actuaci�n en los tres a�os anteriores
--Esa cantidad se incrementar� un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y se decrementar� un 50% si toca Reggaeton o Hip-Hop
--Nota: Valora la posibilidad de dise�ar funciones para comprobar las condiciones.
--Que el Fliying Spaguetti Monster gu�e tus pasos
--�ltima modificaci�n: martes, 16 de mayo de 2017, 08:31


