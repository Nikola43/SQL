USE LeoMetro
GO

/*Ejercicio 1: Indica el n�mero de trenes de cada clase que pasan cada d�a por cada estaci�n.*/

SELECT E.Denominacion AS Estacion, T.Tipo AS ClaseTren, CAST(R.Momento AS Date) AS Dia, COUNT(R.Tren) AS Trenes
FROM LM_Trenes AS T 
INNER JOIN LM_Recorridos AS R ON R.Tren=T.ID
INNER JOIN LM_Estaciones AS E ON E.ID=R.estacion
GROUP BY E.Denominacion, T.Tipo, CAST(R.Momento AS Date)
ORDER BY Estacion, ClaseTren, Dia

/*Ejercicio 2: Inserta un nuevo tren*/

INSERT INTO LM_Trenes
VALUES
(114, '3294GPT', 2, 60, '2009-1-30')

/*Ejercicio 3: Actualiza la tabla LM_Recorridos para que el nuevo tren insertado haya hecho ayer (1 de marzo) los mismos recorridos
que realiz� el tren n� 4 (104) el 27 de febrero.*/

--Realizamos una consulta para obtener los recorridos que realiz� el tren 104 el 27 de febrero
SELECT *
FROM LM_Recorridos
WHERE Tren=104 AND CAST(Momento AS DATE)='2017-02-27'

--Actualizamos la tabla mediante un insert-select

INSERT INTO LM_Recorridos
SELECT 114, Linea, estacion, DATEADD(DAY, 2, Momento)
FROM LM_Recorridos
WHERE Tren=104 AND CAST(Momento AS DATE)='2017-02-27'

/*Ejercicio 4: Calcula la media de kil�metros al d�a que hace cada tren. Considera �nicamente los d�as que ha estado en servicio.*/

--Hacemos una vista con los kil�metros diarios que ha recorrido cada tren.
GO
CREATE VIEW [MediaKilometrosDia] AS 
SELECT T.ID AS Tren, CAST(R.Momento AS DATE) AS Dia, SUM(I.Distancia) AS KmRecorridos
FROM LM_Trenes AS T
INNER JOIN LM_Recorridos AS R ON R.Tren=T.ID
INNER JOIN LM_Lineas AS L ON L.ID=R.Linea
INNER JOIN LM_Itinerarios AS I ON I.Linea=L.ID
GROUP BY T.ID, CAST(R.Momento AS DATE)
GO

-- A partir de la vista, realizamos una subconsulta para calcular la media de kil�metros que hace cada tren al d�a
SELECT Tren, AVG(KmRecorridos) AS MediaKilometrosDiarios
FROM [MediaKilometrosDia]
GROUP BY Tren

/*Ejercicio 5: Calcula cu�l ha sido el intervalo de tiempo en que m�s personas registradas han estado en el metro al mismo tiempo.
Considera intervalos de una hora (de 12:00 a 12:59, de 13:00 a 13:59, etc). Si hay varios momentos con el n�mero m�ximo de personas, 
muestra el m�s reciente.*/

-- Creamos una vista para obtener la cantidad de personas que usan el metro cada hora de cada d�a 
GO
CREATE VIEW [PersonasPorHora] AS
SELECT CAST(MomentoEntrada AS DATE) AS Dia, DATEPART(HOUR, MomentoEntrada) AS Hora, COUNT(IDPasajero) AS Pasajeros
FROM LM_Viajes 
GROUP BY CAST(MomentoEntrada AS DATE),  DATEPART(HOUR, MomentoEntrada)
GO

-- Ahora realizamos una consulta para obtener la m�xima cantidad de pasajeros registrados en una hora (si hay dos iguales, nos quedaremos
--con la m�s reciente)

SELECT TOP(1) *
FROM [PersonasPorHora] 
WHERE Pasajeros in (SELECT MAX(Pasajeros) AS TopRegistrados FROM [PersonasPorHora])
ORDER BY Dia, Hora