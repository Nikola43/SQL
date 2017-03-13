USE LeoMetro
SET Dateformat 'ymd'
GO

-- 1. Crea una función inline que nos devuelva el número de estaciones que ha recorrido cada tren en un
--    determinado periodo de tiempo. El principio y el fin de ese periodo se pasarán como parámetros
-- Creamos la funcion
GO
CREATE FUNCTION calcularNumeroEstacionesCadaTren (@inicio DATETIME, @fin DATETIME)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(estacion) AS [Numero de estaciones], Tren
    FROM LM_Recorridos
    WHERE Momento BETWEEN @inicio AND @fin
    GROUP BY Tren
)

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularNumeroEstacionesCadaTren(@fechaInicio, @fechaFin)
GO
-----------------------------------------------------------------------------------------------

-- 2. Crea una función inline que nos devuelva el número de veces que cada usuario ha entrado en el metro
-- en un periodo de tiempo. El principio y el fin de ese periodo se pasarán como parámetros
GO
CREATE FUNCTION calcularNumeroVecesPasajeroEntroEnMetro (@inicio DATETIME, @fin DATETIME)
RETURNS TABLE AS
RETURN
(
    SELECT COUNT(V.MomentoEntrada) AS [NumeroVeces], P.Nombre
    FROM LM_Viajes AS V
    INNER JOIN LM_Pasajeros AS P
    ON V.IDPasajero = P.ID
    WHERE V.MomentoEntrada BETWEEN @inicio AND @fin
    GROUP BY P.Nombre
)
GO

-- Creamos las variables con los tipos correspondientes
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME

-- Asignamos valor a las variables
SET @fechaInicio = '2017-02-27'
SET @fechaFin = '2017-02-28'

SELECT * FROM calcularNumeroVecesPasajeroEntroEnMetro (@fechaInicio, @fechaFin)
GO

-- 3. Crea una función inline a la que pasemos la matrícula de un tren y una fecha de inicio y fin y nos
-- devuelva una tabla con el número de veces que ese tren ha estado en cada estación, además del ID, nombre y dirección de la estación
GO
CREATE FUNCTION calcularNumeroVecesTrenEnCadaEstacion (@matricula CHAR(7), @inicio DATETIME, @fin DATETIME)
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
DECLARE @fechaInicio DATETIME
DECLARE @fechaFin DATETIME
DECLARE @matricula CHAR(7)

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

-- 5. Crea una función inline que nos devuelva los kilómetros que ha recorrido cada tren en un periodo de tiempo.El principio y el fin de ese periodo se pasarán como parámetros

