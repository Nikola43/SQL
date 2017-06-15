USE LeoFest
--1.Haz una funci�n a la que se pase el nombre de una banda y un rango de fechas y nos devuelva una tabla indicando cuantas veces ha interpretado cada tema 
--en ese rango de fechas. Las columnas ser�n ID del tema, t�tulo, nombre del autor, nombre del estilo y n�mero de veces que se ha interpretado.
GO
ALTER FUNCTION VecesQueSeHaInterpretadoCadaTema(@NombreBanda varchar(50), @InicioRango DATE, @FinRango DATE)
RETURNS TABLE AS
RETURN(
	SELECT T.ID,Titulo,Estilo,Nombre,COUNT(TBE.IDTema) AS [Numero de veces que se ha interpretado]
	FROM LFTemas AS T 
	INNER JOIN LFEstilos AS E ON T.IDEstilo = E.ID
	INNER JOIN LFMusicos AS M ON T.IDAutor = M.ID
	INNER JOIN LFTemasBandasEdiciones AS TBE ON T.ID = TBE.IDTema
	INNER JOIN LFEdiciones AS ED ON TBE.Ordinal = ED.Ordinal AND ED.IDFestival = TBE.IDFestival
	INNER JOIN LFBandas AS BA ON TBE.IDBanda = BA.ID
	WHERE (ED.FechaHoraInicio BETWEEN @InicioRango AND @FinRango) AND @NombreBanda = NombreBanda
	GROUP BY T.ID,Titulo,Estilo,Nombre
)
GO
SELECT * FROM VecesQueSeHaInterpretadoCadaTema('Ejecucion hipotecaria','2001-12-24','2012-11-11 ')
GO
SELECT * FROM LFBandas


--2.Dise�a una funci�n que nos devuelva los datos de los m�sicos que han formado parte de una banda a lo largo de su historia. Las columnas ser�n ID, 
--nombre art�stico, a�os de antig�edad, meses y d�as. La antig�edad se calcular� mediante la diferencia entre el momento en que el m�sico entr� a formar 
--parte de la banda y cuando la abandon�. Si todav�a sigue en la misma, se considerar� la antiguedad hasta la fecha actual. 
--Si un m�sico ha formado parte de la banda, la ha abandonado y luego ha vuelto se sumar� la duraci�n de todos los periodos en los que haya formado parte 
--de la misma. El par�metro de entrada ser� el nombre de la banda.
GO
ALTER FUNCTION MusicosQueHanFormadoParteDeUnaBanda(@NombreBanda varchar(50))
RETURNS TABLE AS 
RETURN(
		SELECT IDMusico,NombreArtistico, 
		YEAR(DATEADD(DAY, SUM(DATEDIFF(DAY,FechaIncorporacion,ISNULL(FechaAbandono,CURRENT_TIMESTAMP))),CAST('31-12-1999' AS SMALLDATETIME))) -2000 AS [A�os antig�edad],
		MONTH(DATEADD(DAY, SUM(DATEDIFF(DAY,FechaIncorporacion,ISNULL(FechaAbandono,CURRENT_TIMESTAMP))),CAST('31-12-1999' AS SMALLDATETIME))) AS [Meses antig�edad],
		DAY(DATEADD(DAY, SUM(DATEDIFF(DAY,FechaIncorporacion,ISNULL(FechaAbandono,CURRENT_TIMESTAMP))),CAST('31-12-1999' AS SMALLDATETIME))) AS [Dias antig�edad]
		FROM LFMusicosBandas AS MB
		INNER JOIN LFMusicos AS M ON MB.IDMusico = M.ID
		INNER JOIN LFBandas AS B ON MB.IDBanda = B.ID
		WHERE NombreBanda = @NombreBanda
		GROUP BY IDMusico,NombreArtistico
)
GO

SELECT * FROM MusicosQueHanFormadoParteDeUnaBanda('Ejecucion hipotecaria')

--3.Algunas veces se organizan ediciones "revival" de un festival, en las que se programan las mismas bandas y las mismas canciones que una edici�n anterior 
--del mismo festival o de otro. Escribe un procedimeinto almacenado que "clone" una edici�n de un festival.
--Los datos de entrada ser�n el ID del festival y la fecha de inicio de la edici�n que queremos clonar y el ID del festival y la fecha de inicio prevista 
--para la nueva edici�n "revival". Todos los datos de esta ueva edici�n (duraci�n, lema, etc) se copiaran del que estamos replicando.
GO
CREATE PROCEDURE EdicionesRevival @IDFestivalQueQueremosClonar int, @FechaInicioEdicionQueQueremosClonar smalldatetime, @IDFestivalPrevisto int, @FechaInicioPrevista smalldatetime
AS
BEGIN
INSERT INTO LFEdiciones(IDFestival,Ordinal,Lema,Lugar,Ciudad,ComunidadAutonoma,FechaHoraInicio,FechaHoraFin)
SELECT @IDFestivalPrevisto,Ordinal,Lema,Lugar,Ciudad,ComunidadAutonoma,@FechaInicioPrevista,FechaHoraFin
FROM LFEdiciones
WHERE IDFestival = @IDFestivalQueQueremosClonar AND FechaHoraInicio = @FechaInicioEdicionQueQueremosClonar
	
END
GO

DECLARE @IDFestivalQueQueremosClonar int = 5
DECLARE @FechaInicioEdicionQueQueremosClonar smalldatetime = '2001-12-24 12:04:00'
DECLARE @IDFestivalPrevisto int = 6
DECLARE @FechaInicioPrevista smalldatetime = '2009-12-24 12:04:00'

EXECUTE EdicionesRevival @IDFestivalQueQueremosClonar, @FechaInicioEdicionQueQueremosClonar,@IDFestivalPrevisto,@FechaInicioPrevista




--4.Realiza una funci�n que nos diga hasta qu� punto una banda es fiel a sus estilos. Para ello, deber� contar cuantos temas de cada estilo ha interpretado 
--y dividirlos en dos bloques, los que pertenecen a alguno de los estilos de la banda y los que no. Luego se calcular� el porcentaje de temas que pertenecen
--a alguno de sus estilos respecto del total.
--Se contar�n las interpretaciones, no los temas. Es decir, si un mismo tema se ha interpretado cinco veces contar� como cinco, no como uno.
--El dato de entrada ser� el nombre de la banda y el de salida el �ndice de fidelidad, con un decimal.