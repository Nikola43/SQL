--Sobre la base de datos AirLeo
/*1. Dise�a una funci�n fn_distancia recorrida a la que se pase un c�digo de avi�n y un rango
dE fechas y nos devuelva la distancia total recorrida por ese avi�n en ese rango de
fechas.*/
/*
Interfaz

Esta funci�n calcula la distancia recorrida de un avi�n entre dos fechas determinadas
prototipo: fn_DistanciaRecorrida(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE) 
Precondiciones: Las fechas deben ser correctas
Entradas: Una matr�cula de avion int y dos fechas date
Salida: Un entero
Postcondiciones: El entero es la distancia recorrida de un avi�n entre dos fechas, si se introduce un avion que no existe devuelve 0
*/

BEGIN TRANSACTION
go
alter FUNCTION fn_DistanciaRecorrida(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE) 
RETURNS INT AS
BEGIN	--Nos saltamos la tabla aeropuertos, ya que podemos unir vuelos con distancias directamente
	DECLARE @DistanciaTotal INT
	SET @DistanciaTotal=(SELECT SUM(D.Distancia)
						 FROM AL_Vuelos AS V
						 INNER JOIN AL_Distancias AS D
						 ON (V.Aeropuerto_Llegada=D.Destino AND V.Aeropuerto_Salida=D.Origen) OR (V.Aeropuerto_Llegada=D.Origen AND V.Aeropuerto_Salida=D.Destino)
						 WHERE V.Matricula_Avion=@CodAvion AND (CAST(V.Salida AS DATE)BETWEEN @FechaInicio AND @FechaFin) AND(CAST(V.Llegada AS DATE)BETWEEN @FechaInicio AND @FechaFin)
						 )
	IF @DistanciaTotal IS NULL
	BEGIN
		SET @DistanciaTotal=0
	END
	RETURN @DistanciaTotal
END
go
ROLLBACK

SELECT dbo.fn_DistanciaRecorrida('USA5068','2008-01-14 14:05:00','2008-02-14 17:30:00')
/*2. Dise�a una funci�n fn_horasVuelo a la que se pase un c�digo de avi�n y un rango de
fechas y nos devuelva las horas totales que ha volado ese avi�n en ese rango de fechas.*/
/*
Interfaz

Esta funci�n te devuelve el total de horas recorridas de un avi�n entre dos fechas determinadas
Prototipo: fn_horasVuelo(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE)
Precondiciones: No hay
Entradas: una matr�cula de avi�n char(10) y dos fechas date
Salida: Un entero
Postcondiciones: El entero es mayor o igual a 0
*/
GO
ALTER FUNCTION fn_horasVuelo(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE)
RETURNS INT AS
BEGIN
	DECLARE @HorasTotales INT
	SET @HorasTotales=(SELECT SUM(DATEDIFF(MINUTE,Salida,Llegada)/60)
					   FROM AL_Vuelos
					   WHERE Matricula_Avion=@CodAvion AND (CAST(Salida AS DATE) BETWEEN @FechaInicio AND @FechaFin) AND (CAST(Llegada AS DATE) BETWEEN @FechaInicio AND @FechaFin))
	IF @HorasTotales IS NULL
	BEGIN
		SET @HorasTotales=0
	END
	RETURN @HorasTotales
END
go
SELECT DBO.FN_HORASVUELO('USA5068','2008-01-14 14:05:00','2008-01-14 17:30:00')
/*3. Dise�a una funci�n a la que se pase un c�digo de avi�n y un rango de fechas y nos
devuelva una tabla con los nombres y fechas de todos los aeropuertos en que ha estado
el avi�n en ese intervalo.*/
/*
Interfaz

Esta funci�n devuelve un tabla donde se ven todos los nombres de los aeropuertos por los que ha pasado un avi�n en dos fechas determinadas
prototipo: fn_nombreAeropuertos(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE)
Precondiciones: No hay
Entradas: Un char(10) y dos fechas date
Salidas: Una tabla
Postcondiciones: La tabla contendr� los nombres de los aeropuertos e indicar� si son de salida o de llegada
*/
GO
/*alter FUNCTION fn_nombreAeropuertos(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE AS
RETURN
(SELECT DISTINCT Nombre,v.Salida, V.Llegada
FROM AL_Aeropuertos AS A
INNER JOIN AL_Vuelos AS V
ON A.Codigo=V.Aeropuerto_Llegada or A.Codigo=V.Aeropuerto_Salida
WHERE V.Matricula_Avion=@CodAvion AND CAST (V.Salida AS DATE) BETWEEN @FechaInicio AND @FechaFin AND CAST (V.Llegada AS DATE) BETWEEN @FechaInicio AND @FechaFin)--Queda controlar las fechas
GO
SELECT *
from dbo.fn_nombreAeropuertos('USA5068','2008-01-14','2008-01-30')*/
create FUNCTION fn_nombreAeropuertos(@CodAvion CHAR(10), @FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE AS
	RETURN
		(SELECT DISTINCT Nombre, Fecha=
		CASE
			WHEN A.Codigo=V.Aeropuerto_Llegada THEN CAST(V.Llegada AS DATE)
			WHEN A.Codigo=V.Aeropuerto_Salida THEN CAST(V.Salida AS DATE)
		END, LlegadaSalida=
		CASE
			WHEN A.Codigo=V.Aeropuerto_Llegada THEN 'Llegada'
			WHEN A.Codigo=V.Aeropuerto_Salida THEN 'Salida'
		END
		FROM AL_Aeropuertos AS A
		INNER JOIN AL_Vuelos AS V
		ON A.Codigo=V.Aeropuerto_Salida OR A.Codigo=V.Aeropuerto_Llegada
		WHERE V.Matricula_Avion=@CodAvion AND (CAST (V.Salida AS DATE) BETWEEN @FechaInicio AND @FechaFin) AND (CAST (V.Llegada AS DATE) BETWEEN @FechaInicio AND @FechaFin)
)
go
SELECT *
from dbo.fn_nombreAeropuertos('USA5068','2008-01-14','2008-01-30')
order by Fecha
/*4. Dise�a una funci�n fn_ViajesCliente que nos devuelva nombre y apellidos, kil�metros
recorridos y n�mero de vuelos efectuados por cada cliente en un rango de fechas,
ordenado de mayor a menor distancia recorrida.*/
/*
Esta funci�n nos devuelve una tabla con nombre y apellidos, kil�metros
recorridos y n�mero de vuelos efectuados por cada cliente en un rango de fechas,
ordenado de mayor a menor distancia recorrida.
Precondiciones: Las fechas son v�lidas
Entradas: Dos fechas date
Salidas: Una tabla
Postcondiciones: Contiene nombre y apellidos, kilometros recorridos y n�mero de vuelos efectuados
*/
GO
alter FUNCTION fn_ViajesCliente (@fechaInicio DATE, @fechaFin DATE)
RETURNS TABLE AS RETURN
(
SELECT Nombre, Apellidos, COUNT (p.ID) AS [N�mero de vuelos], sum(D.Distancia) AS [Distancia Recorrida]
FROM AL_Pasajeros AS P
INNER JOIN AL_Pasajes AS PAS
ON P.ID=PAS.ID_Pasajero
INNER JOIN AL_Vuelos_Pasajes AS VPAS
ON PAS.Numero=VPAS.Numero_Pasaje
inner join AL_Vuelos as V
ON VPAS.Codigo_Vuelo=V.Codigo
INNER JOIN AL_Distancias AS D
ON (V.Aeropuerto_Llegada=D.Destino AND V.Aeropuerto_Salida=D.Origen) OR (V.Aeropuerto_Llegada=D.Origen AND V.Aeropuerto_Salida=D.Destino)
WHERE VPAS.Embarcado='S' AND (CAST (V.Salida AS DATE) BETWEEN @FechaInicio AND @FechaFin) AND (CAST (V.Llegada AS DATE) BETWEEN @FechaInicio AND @FechaFin)
GROUP BY P.Nombre, P.Apellidos
)
GO
SELECT *
from dbo.fn_ViajesCliente('2008-01-14','2011-04-14')
order by [Distancia Recorrida] asc
