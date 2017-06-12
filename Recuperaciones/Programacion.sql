 
USE LeoFest
SET Dateformat 'ymd'
GO

--Programación
--Sobre la base de datos LeoFest.
--Ejercicio 1
--Haz una función a la que se pase el nombre de una banda y un rango de fechas y nos devuelva una tabla indicando
--cuantas veces ha interpretado cada tema en ese rango de fechas. Las columnas serán ID del tema, título, nombre del autor, 
--nombre del estilo y número de veces que se ha interpretado.ç
GO
ALTER FUNCTION dbo.calcularVecesCantadasCadaTema(@nombreBanda varchar(50), @inicio date, @fin date)
RETURNS TABLE AS
RETURN 
(
	SELECT TBE.IDTema, T.Titulo, M.Nombre, Est.Estilo, COUNT(TBE.IDTema) AS NumeroDeVeces
	FROM LFBandas AS B
	INNER JOIN LFBandasEdiciones AS BE
	  ON B.ID = BE.IDBanda
	INNER JOIN LFEdiciones AS E
	  ON BE.IDFestival = E.IDFestival
	INNER JOIN LFTemasBandasEdiciones AS TBE
	  ON E.IDFestival = TBE.IDFestival AND E.Ordinal = TBE.Ordinal
    INNER JOIN LFTemas AS T
	  ON TBE.IDTema = T.ID
    INNER JOIN LFMusicos AS M
	  ON T.IDAutor = M.ID
    INNER JOIN LFEstilos AS Est
	  ON T.IDEstilo = Est.ID
	WHERE E.FechaHoraInicio BETWEEN @inicio AND @fin AND @nombreBanda = B.NombreBanda
	GROUP BY TBE.IDTema, T.Titulo, M.Nombre, Est.Estilo
)
GO

SELECT * FROM dbo.calcularVecesCantadasCadaTema('Ejecucion hipotecaria','2001-04-20', '2005-04-20')

SELECT * from LFBandas
--Ejercicio 2
--Diseña una función que nos devuelva los datos de los músicos que han formado parte de una banda a lo largo de su historia. Las columnas serán Id,
--nombre artístico, años de antigüedad, meses y días. La antigüedad se calculará mediante la diferencia entre el momento en que el músico entró a
--formar parte de la banda y cuando la abandonó. Si todavía sigue en la misma, se considerará la antiguedad hasta la fecha actual. 
--Si un músico ha formado parte de la banda, la ha abndonado y luego ha vuelto se sumará la duración de todos los periodos en los que haya formado
--parte de la misma. El parámetro de entrada será el nombre de la banda.
GO
ALTER FUNCTION dbo.historialBandasMusicos(@nombreBanda varchar(50))
RETURNS TABLE AS
RETURN 
(
	SELECT M.ID, M.NombreArtistico, DATEDIFF(day,MB.FechaIncorporacion, MB.FechaIncorporacion) AS 'Diferencia'
	FROM LFMusicos AS M
	INNER JOIN LFMusicosBandas AS MB
	  ON M.ID = MB.IDMusico
	INNER JOIN LFBandas AS B
	  ON MB.IDBanda = B.ID
	GROUP BY M.ID, M.NombreArtistico, MB.FechaIncorporacion
)
GO

SELECT * FROM dbo.historialBandasMusicos('Ejecucion hipotecaria')

SELECT * FROM LFBandas

SELECT * FROM LFMusicos


DECLARE @antiguedad Date

SET @antiguedad = DATEDIFF(day,'2000-01-01', '2000-01-01')

PRINT @antiguedad

SELECT * FROM LFMusicosBandas

SELECT DATEDIFF(day,'2000-01-01', '2000-11-01')

--Ejercicio 3
--Algunas veces se organizan ediciones "revival" de un festival, en las que se programan las mismas bandas y las mismas canciones que una edición 
--anterior del mismo festival o de otro. Escribe un procedimeinto almacenado que "clone" una edición de un festival.
--Los datos de entrada serán el ID del festival y la fecha de inicio de la edición que queremos clonar y el ID del festival y la 
--fecha de inicio prevista para la nueva edición "revival". Todos los datos de esta ueva edición (duración, lema, etc) se copiaran del 
--que estamos replicando.

--Ejercicio 4
--Realiza una función que nos diga hasta qué punto una banda es fiel a sus estilos. Para ello, deberá contar cuantos temas de cada estilo 
--ha interpretado y dividirlos en dos bloques, los que pertenecen a alguno de los estilos de la banda y los que no. Luego se calculará 
--el porcentaje de temas que pertenecen a alguno de sus estilos respecto del total.

--Se contarán las interpretaciones, no los temas. Es decir, si un mismo tema se ha interpretado cinco veces contará como cinco, no como uno.

--El dato de entrada será el nombre de la banda y el de salida el índice de fidelidad, con un decimal.

GO
CREATE FUNCTION dbo.fidelidadEstilosTemas(@nombreBanda varchar(50))
    RETURNS decimal(6,2)
    BEGIN
        DECLARE @resultado decimal(6,2)
        --SET @resultado = (SELECT Matricula FROM LM_Trenes WHERE ID = @id)
		SET @resultado = 2.2

		SELECT TBE.IDTema, COUNT(TBE.IDTema)
		FROM LFBandas AS B
		INNER JOIN LFBandasEdiciones AS BE
		  ON B.ID = BE.IDBanda
		INNER JOIN LFEdiciones AS E
		  ON BE.IDFestival = E.IDFestival
		INNER JOIN LFTemasBandasEdiciones AS TBE
		  ON E.IDFestival = TBE.IDFestival
		WHERE B.NombreBanda = @nombreBanda
		GROUP BY TBE.IDTema
		
        RETURN @resultado
    END
GO

DECLARE @nombreBanda varchar(50) = 'Ejecucion hipotecaria'

SELECT TBE.IDTema, COUNT(TBE.IDTema)
		FROM LFBandas AS B
		INNER JOIN LFBandasEdiciones AS BE
		  ON B.ID = BE.IDBanda
		INNER JOIN LFEdiciones AS E
		  ON BE.IDFestival = E.IDFestival
		INNER JOIN LFTemasBandasEdiciones AS TBE
		  ON E.IDFestival = TBE.IDFestival
		WHERE B.NombreBanda = @nombreBanda
		GROUP BY TBE.IDTema