--Examen Paulo Gustavo Soares Teixeira
USE LeoMetro
SET Dateformat 'ymd'
Go

-- 1. Indica el numero de trenes de cada clase que pasan al dia por cada estacion
-- Contamos el numero de ocurrencias de cada tren en la tabla recorridos
SELECT E.Denominacion, T.Tipo as Clase, DAY(R.Momento) AS DIA, COUNT(T.ID) AS [Numero de trenes]
FROM LM_Trenes AS T
INNER JOIN LM_Recorridos AS R
  ON T.ID = R.Tren
INNER JOIN LM_Estaciones AS E
  ON R.estacion = E.ID
GROUP BY T.Tipo, E.Denominacion, DAY(R.Momento) -- Agrupamos por tipo, estacion y por dia para saber
                                                -- el numero de trenes cada dia en cada estacion
------------------------------------------------------------------------------------------------------------------------


-- 2. Inserta un nuevo tren
BEGIN TRANSACTION

  INSERT INTO LM_Trenes (ID, Matricula, Tipo, Capacidad, FechaEntraServicio)
  VALUES (220, '3294GPT', 2, 65, CURRENT_TIMESTAMP) -- Insertamos un nuevo tren con fecha de hoy

COMMIT TRANSACTION -- ROLLBACK TRANSACTION

-- Comprobamos que se ha insertado el tren correctamente con la fecha de hoy
SELECT *
FROM LM_Trenes
WHERE ID = '220'
------------------------------------------------------------------------------------------------------------------------

-- 3. Actualiza la tabla LM_Recorridos para que el nuevo tren insertado haya hecho ayer (1 de marzo) los mismos
-- recorridos que realizo el tren numero 4 (id 104) el 27 de febrero

-- Primero realizamos una consulta para saber los recorridos que realizo el tren numero 4 el 27 de febrero
/*
SELECT T.ID, R.Linea, R.estacion, R.Momento
FROM LM_Trenes AS T
INNER JOIN LM_Recorridos AS R
  ON T.ID = R.Tren
WHERE R.Tren = '104' AND CAST (R.Momento AS DATE) = '2017-02-27'
*/

-- Ahora insertamos en la tabla LM_Recorridos todos los recorridos del tren 104 en el nuevo tren pero con fecha 2017-03-01

-- Daba error al insertar el momento(PK LM_Recorridos) por que hay columnas duplicadas, entonces lo que hice fue usar DATETIMEFROMPART, 
-- puse la fecha a mano y cogi las horas, minutos y segundos de los recorridos del tren 104 y asi ya no da error el insert :)




BEGIN TRANSACTION

  INSERT INTO LM_Recorridos (Tren, Linea, estacion, Momento)
      SELECT '220' AS Tren, R.Linea, R.estacion, DATETIMEFROMPARTS('2017', '03', '01', DATEPART(HOUR, R.Momento), DATEPART(MINUTE, R.Momento), DATEPART(SECOND, R.Momento),DATEPART(MILLISECOND, R.Momento))
      FROM LM_Trenes AS T
      INNER JOIN LM_Recorridos AS R
        ON T.ID = R.Tren
      WHERE R.Tren = '104' AND CAST (R.Momento AS DATE) = '2017-02-27'

COMMIT TRANSACTION -- ROLLBACK TRANSACTION

-- Comprobamos que ahora este nuevo tren introducido tiene los mismo recorridos
SELECT T.ID, R.Linea, R.estacion, R.Momento
FROM LM_Trenes AS T
INNER JOIN LM_Recorridos AS R
  ON T.ID = R.Tren
WHERE R.Tren = '220'
------------------------------------------------------------------------------------------------------------------------

-- 4. Calcula la media de kilometros al dia que hace cada tren. Considere unicamente los dias que ha estado en servicio
-- Usango AVG(), nos devolvera la media de los kilometros recorridos cada dia por todos los trenes
SELECT T.ID, AVG(I.Distancia) AS [Media kilometros], DAY(R.Momento) AS DIA
FROM LM_Trenes AS T
INNER JOIN LM_Recorridos AS R
  ON T.ID = R.Tren
INNER JOIN LM_Lineas AS L
  ON R.Linea = L.ID
INNER JOIN LM_Itinerarios AS I
  ON L.ID = I.Linea
GROUP BY T.ID, DAY(R.Momento)
ORDER BY T.ID, DAY(R.Momento)
------------------------------------------------------------------------------------------------------------------------

-- 5. Calcula cual ha sido el intervalo de tiempo en que mas personas registradas han estado en el metro al mismo tiempo
-- Considera intervalos de una hora (de 12:00 a 12:49, de 13:00 a 13:59, etc)
-- Si hay varios momentos con el numero maximo de personas, muestra el siguiente

SELECT *
FROM LM_Viajes

-- NO ME HA DADO TIEMPO, PERDI MUCHO TIEMPO EN EL EJ3 PARA INSERTAR LOS RECORRIDOS
-- SI NO HUBIESE PERDIDO TANTO TIEMPO CON ESO, QUIZAS ME HUBIESE DADO TIEMPO DE TERMINAR LOS 5
