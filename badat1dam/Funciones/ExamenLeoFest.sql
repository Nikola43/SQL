---EXAMEN BASES DE DATOS LeoFest 16/05/2017---
--Jesús Prieto Monge
USE LeoFest
GO

/*Ejercicio 1: Escribe un procedimiento almacenado que de de baja a una banda, actualizando su fecha de disolución y la fecha de abandono de todos 
sus componentes actuales. La fecha de disolución y el ID de la banda se pasarán por parámetros. Si no se especifica fecha, se tomará la actual.
*/

CREATE PROCEDURE darDeBajaBanda
@IDBanda smallint,
@FechaDisolucion date
AS
	--Primero comprobamos si la fecha de disolución se ha especificado o no.
	IF @FechaDisolucion IS NULL
		BEGIN
			SET @FechaDisolucion = CAST(CURRENT_TIMESTAMP AS date)
		END

	--Ahora actualizamos la fecha de disolución
	UPDATE LFBandas
	SET FechaDisolucion=@FechaDisolucion
	WHERE ID=@IDBanda

	--Luego actualizamos la fecha de abandono de todos los integrantes del grupo
	UPDATE LFMusicosBandas
	SET FechaAbandono=@FechaDisolucion
	WHERE IDBanda=@IDBanda AND FechaAbandono IS NULL
GO

--Prueba
BEGIN TRANSACTION

EXECUTE darDeBajaBanda 7, NULL

ROLLBACK TRANSACTION

/*Ejercicio 2: Escribe una función que reciba como parámetro un año y nos devuelva una tabla indicando cuantas canciones (temas) de cada estilo se han 
cantado en los distintos festivales celebrados a lo largo de ese año, el mismo dato para el año inmediatamente anterior y una cuarta columna en la 
que aparezca un símbolo "+” si ha aumentado el número de canciones de ese estilo respecto al año anterior, un "-” si ha disminuido y un "=” si 
no varía. El resultado tendrá cuatro columnas: Estilo, número de interpretaciones de ese estilo en el año anterior, número de interpretaciones de 
ese estilo en el año que nos piden y símbolo que indique aumento o disminución. Puedes hacer otras funciones auxiliares a las que llames, pero 
no declarar vistas.*/

GO
CREATE FUNCTION temasDeCadaEstilo(@año int)
RETURNS TABLE AS
RETURN
	SELECT S.Estilo, 
	SUB.TemasAñoPedido AS TemasAñoAnterior,
	COUNT(TBE.IDTema) AS TemasAñoPedido,
	--Para añadir la cuarta columna con el símbolo, necesitamos un CASE
	Diferencia = CASE
				WHEN COUNT(TBE.IDTema)<SUB.TemasAñoPedido THEN '-'
				WHEN COUNT(TBE.IDTema)>SUB.TemasAñoPedido THEN '+'
				WHEN COUNT(TBE.IDTema)=SUB.TemasAñoPedido THEN '='
				END
	FROM LFEdiciones AS E
	INNER JOIN LFTemasBandasEdiciones AS TBE ON TBE.IDFestival=E.IDFestival AND TBE.Ordinal=E.Ordinal
	INNER JOIN LFTemas AS T ON T.ID=TBE.IDTema
	INNER JOIN LFEstilos AS S ON S.ID=T.IDEstilo
	-- Hacemos una subconsulta para sacar las interpretaciones del año anterior
		FULL JOIN (SELECT S.Estilo,
		COUNT(TBE.IDTema) AS TemasAñoPedido
		FROM LFEdiciones AS E
		INNER JOIN LFTemasBandasEdiciones AS TBE ON TBE.IDFestival=E.IDFestival AND TBE.Ordinal=E.Ordinal
		INNER JOIN LFTemas AS T ON T.ID=TBE.IDTema
		INNER JOIN LFEstilos AS S ON S.ID=T.IDEstilo
		WHERE YEAR(E.FechaHoraInicio)=(@año-1)
		GROUP BY S.Estilo) AS SUB ON SUB.Estilo=S.Estilo
	WHERE YEAR(E.FechaHoraInicio)=@año
	GROUP BY S.Estilo, SUB.TemasAñoPedido
GO

-- PRUEBA

SELECT * FROM dbo.temasDeCadaEstilo(2015)

/*Ejercicio 3: Escribe un procedimiento TemaEjecutado y anote en la tabla LFTemasBandasEdiciones que una banda ha interpretado ese tema en una edición 
concreta de un festival. Los datos de entrada son: Titulo, IDAutor, Estilo (nombre del estilo), Duracion, El Id de un festival, el ordinal de la 
edición, el ID de una banda y una fecha/hora. Si el tema es nuevo y no está dado de alta en la base de datos, se insertará en la tabla correspondiente.
Si el estilo no existe, también se dará de alta.*/

CREATE PROCEDURE TemaEjecutado
@TituloTema varchar(120),
@IDAutor int,
@Estilo varchar(30),
@Duracion time(7),
@IDFestival int,
@Ordinal tinyint,
@IDBanda smallint
--@FechaHora smalldatetime
AS
	-- Primero comprobamos si el estilo existe o no. Si no existe lo insertamos.
	IF NOT EXISTS (SELECT * FROM LFEstilos WHERE Estilo=@Estilo)
	BEGIN
		INSERT INTO LFEstilos (ID, Estilo)
		VALUES
		((SELECT (MAX(ID)+1) FROM LFEstilos ), @Estilo)
	END

	-- Ahora comprobamos si existe el tema, si no existe lo insertamos también.
	IF NOT EXISTS (SELECT * FROM LFTemas WHERE Titulo=@TituloTema AND IDAutor=@IDAutor)
	INSERT INTO LFTemas (ID, Titulo, IDAutor, IDEstilo, Duracion)
	VALUES
	(NEWID(), @TituloTema, @IDAutor, (SELECT ID FROM LFEstilos WHERE Estilo=@Estilo), @Duracion)

	-- Por último anotamos en la tabla LFTemasBandasEdiciones la interpretación del tema
	INSERT INTO LFTemasBandasEdiciones
	(IDBanda, IDFestival, Ordinal, IDTema)
	VALUES
	(@IDBanda, @IDFestival, @Ordinal, (SELECT ID FROM LFTemas WHERE Titulo=@TituloTema))
GO

--PRUEBA
BEGIN TRANSACTION

EXECUTE TemaEjecutado 'La Mandanga', 30, 'Flamenco-fusión', '00:04:20', 6, 7, 16

ROLLBACK TRANSACTION

/*Ejercicio 4: Escribe un procedimiento almacenado que actualice la columna caché de la tabla LFBandas de acuerdo a las siguientes reglas:

    Se computarán 105 € por cada miembro activo de la banda
    Se añadirán 170 € por cada actuación en los tres años anteriores
    Esa cantidad se incrementará un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y se decrementará un 50% si toca 
	Reggaeton o Hip-Hop

Nota: Valora la posibilidad de diseñar funciones para comprobar las condiciones.*/

GO
CREATE PROCEDURE actualizarCache
AS
	-- Añadimos 105€ por cada miembro activo al caché de cada banda
	UPDATE LFBandas
	SET CacheMinimo=105*SUB.MusicosActivos
	FROM LFBandas AS B INNER JOIN (SELECT B.NombreBanda, COUNT(MB.IDMusico) AS MusicosActivos
		FROM LFBandas AS B
		INNER JOIN LFMusicosBandas AS MB ON MB.IDBanda=B.ID 
		WHERE MB.FechaAbandono IS NULL
		GROUP BY B.NombreBanda) AS SUB ON SUB.NombreBanda=B.NombreBanda

	-- Ahora añadimos 170€ por cada actuación en los tres años anteriores
	UPDATE LFBandas
	SET CacheMinimo=170*SUB.Actuaciones
	FROM LFBandas AS B 
	INNER JOIN (SELECT * FROM dbo.Actuaciones3UltimosAños()) AS SUB 
	ON SUB.NombreBanda=B.NombreBanda

	-- Por último incrementamos un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y decrementamos un 50% si toca 
	--Reggaeton o Hip-Hop
	UPDATE LFBandas
	SET CacheMinimo=CacheMinimo*1.05
	WHERE NombreBanda IN (SELECT NombreBanda FROM gruposRockFlamencoJazz())

	UPDATE LFBandas
	SET CacheMinimo=CacheMinimo*0.5
	WHERE NombreBanda IN (SELECT NombreBanda FROM gruposBasura())

GO

--PRUEBA
EXECUTE actualizarCache

--Creo una función para calcular las actuaciones que han hecho en los 3 últimos años

CREATE FUNCTION Actuaciones3UltimosAños()
RETURNS TABLE AS
RETURN
SELECT B.NombreBanda, COUNT(BE.Ordinal) AS Actuaciones
FROM LFBandas AS B 
INNER JOIN LFBandasEdiciones AS BE ON BE.IDBanda= B.ID
INNER JOIN LFEdiciones AS E ON E.IDFestival=BE.IDFestival AND E.Ordinal=BE.Ordinal
WHERE DATEDIFF(year, E.FechaHoraInicio, CURRENT_TIMESTAMP)<=3
GROUP BY B.NombreBanda

-- Creamos una función para saber si un grupo toca alguno de estos generos: rock, flamenco, jazz o blues
CREATE FUNCTION gruposRockFlamencoJazz()
RETURNS TABLE AS
RETURN
SELECT DISTINCT B.NombreBanda
FROM LFBandas AS B
INNER JOIN LFBandasEstilos AS BE ON BE.IDBanda=B.ID
INNER JOIN LFEstilos AS E ON E.ID=BE.IDEstilo
WHERE E.Estilo IN ('Rock', 'Flamenco', 'Jazz', 'Blues')

CREATE FUNCTION gruposBasura()
RETURNS TABLE AS
RETURN
SELECT DISTINCT B.NombreBanda
FROM LFBandas AS B
INNER JOIN LFBandasEstilos AS BE ON BE.IDBanda=B.ID
INNER JOIN LFEstilos AS E ON E.ID=BE.IDEstilo
WHERE E.Estilo IN ('Reggaeton', 'Hip-Hop')