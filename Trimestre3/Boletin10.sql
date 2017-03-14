USE LeoMetro
SET Dateformat 'ymd'
GO

-- 1. Crea una función inline que nos devuelva el número de estaciones que ha recorrido cada tren en un
--    determinado periodo de tiempo. El principio y el fin de ese periodo se pasarán como parámetros
-- Creamos la funcion
GO
ALTER FUNCTION calcularNumeroEstacionesCadaTren (@inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(estacion) AS [Numero de estaciones], Tren
    FROM LM_Recorridos
    WHERE Momento BETWEEN @inicio AND @fin
    GROUP BY Tren
)

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DateTime
DECLARE @fechaFin DateTime

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-26'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularNumeroEstacionesCadaTren(@fechaInicio, @fechaFin)
GO
-----------------------------------------------------------------------------------------------

-- 2. Crea una función inline que nos devuelva el número de veces que cada usuario ha entrado
-- en el metro en un periodo de tiempo. El principio y el fin de ese periodo se pasarán como parámetros
GO
ALTER FUNCTION calcularNumeroVecesPasajeroEntroEnMetro (@inicio DATETIME, @fin DATETIME)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(V.MomentoEntrada) AS [NumeroVeces], V.IDPasajero
    FROM LM_Viajes AS V
    WHERE V.MomentoEntrada BETWEEN @inicio AND @fin
    GROUP BY V.IDPasajero
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DateTime
DECLARE @fechaFin DateTime

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-26'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularNumeroVecesPasajeroEntroEnMetro (@fechaInicio, @fechaFin)
GO

-- 3. Crea una función inline a la que pasemos la matrícula de un tren y una fecha de inicio y fin y nos
-- devuelva una tabla con el número de veces que ese tren ha estado en cada estación, además del ID, nombre y dirección de la estación
GO
ALTER FUNCTION calcularNumeroVecesTrenEnCadaEstacion (@matricula CHAR(7), @inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(R.Momento) AS NumeroVeces, E.ID, E.Denominacion, E.Direccion
    FROM LM_Trenes AS T
        INNER JOIN LM_Recorridos AS R
          ON T.ID = R.Tren
        INNER JOIN LM_Estaciones AS E
          ON R.estacion = E.ID
    WHERE T.Matricula = @matricula AND R.Momento BETWEEN @inicio AND @fin
    GROUP BY E.ID, E.Denominacion, E.Direccion
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DateTime
DECLARE @fechaFin DateTime
DECLARE @matricula Char(7)

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'
SET @matricula = '5607GLZ'

-- Ejecutamos la consulta usando el metodo
SELECT * FROM calcularNumeroVecesTrenEnCadaEstacion (@matricula, @fechaInicio, @fechaFin)
GO

-- 4. Crea una función inline que nos diga el número de personas que han pasado por una estacion en un
-- periodo de tiempo. Se considera que alguien ha pasado por una estación si ha entrado o salido del metro
-- por ella. El principio y el fin de ese periodo se pasarán como parámetros
GO
ALTER FUNCTION calcularNumeroPersonasQueHanPasadoPorCadaEstacion (@inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(P.ID) AS NumeroPersonas
    FROM LM_Pasajeros AS P
      INNER JOIN LM_Viajes AS V
        ON P.ID = V.IDPasajero
    WHERE V.MomentoEntrada BETWEEN @inicio AND @fin OR V.MomentoSalida BETWEEN @inicio AND @fin
    GROUP BY V.IDEstacionEntrada
)
GO

-- sumar los que entran y los que salen


-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DateTime
DECLARE @fechaFin DateTime

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

-- Ejecutamos la consulta usando el metodo
SELECT * FROM calcularNumeroPersonasQueHanPasadoPorCadaEstacion (@fechaInicio, @fechaFin)
GO

-- 5. Crea una función inline que nos devuelva los kilómetros que ha recorrido cada tren en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros
GO
ALTER FUNCTION calcularKilometrosRecorridosPorCadaTren (@inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT T.ID, SUM(I.Distancia) AS Kilometros
    FROM LM_Trenes AS T
    INNER JOIN LM_Recorridos AS R
      ON T.ID = R.Tren
    INNER JOIN LM_Lineas AS L
      ON R.Linea = L.ID
    INNER JOIN LM_Itinerarios AS I
      ON L.ID = I.Linea
    WHERE R.Momento BETWEEN @inicio AND @fin
    GROUP BY T.ID, I.Distancia
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularKilometrosRecorridosPorCadaTren (@fechaInicio, @fechaFin)
GO

-- 6. Crea una función inline que nos devuelva el número de trenes que ha circulado por cada línea en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá el ID, denominación y color de la línea
GO
ALTER FUNCTION calcularNumeroTrenesCadaLinea (@inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(R.Linea) AS NumeroVecesQueHaCirculado, R.Tren
    FROM LM_Trenes AS T
        INNER JOIN LM_Recorridos AS R
        ON T.ID = R.Tren
    WHERE R.Momento BETWEEN @inicio AND @fin
    GROUP BY R.Linea, R.Tren
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularNumeroTrenesCadaLinea (@fechaInicio, @fechaFin)
GO

-- 7. Crea una función inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá ID, nombre y apellidos del pasajero.
-- El tiempo se expresará en horas y minutos.
GO
CREATE FUNCTION calcularTiempoQueHaPasadoEnMetroCadaUsuario (@inicio DateTime, @fin DateTime)
RETURNS TABLE AS
RETURN
(
    SELECT
        P.ID,
        P.Nombre,
        P.Apellidos,
        DATEDIFF(MINUTE, V.MomentoEntrada, V.MomentoSalida) AS TiempoViajandoEnMetroEnMinutos
    FROM LM_Pasajeros AS P
        INNER JOIN LM_Viajes AS V
            ON P.ID = V.IDPasajero
    WHERE V.MomentoEntrada BETWEEN @inicio AND @fin
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularTiempoQueHaPasadoEnMetroCadaUsuario (@fechaInicio, @fechaFin)
GO

