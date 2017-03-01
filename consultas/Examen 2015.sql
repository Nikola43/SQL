USE Flamenco

--EJERCICIO 1
--Número de veces que ha actuado cada cantaor en cada festival de la provincia de Cádiz, incluyendo a los que no han actuado nunca
SELECT
	C.Nombre_Artistico,
	COUNT(*) AS [Número de veces]
FROM
	F_Cantaores AS C
	LEFT OUTER JOIN F_Festivales_Cantaores AS FC
	ON C.Codigo = FC.Cod_Cantaor
	LEFT OUTER JOIN F_Festivales AS F
	ON FC.Cod_Festival = F.Cod
	LEFT OUTER JOIN F_Provincias AS P
	ON F.Provincia = P.Cod_Provincia
	WHERE P.Provincia = 'Cádiz' OR P.Provincia IS NULL
GROUP BY
	C.Nombre_Artistico

--EJERCICIO 2
--Crea un nuevo palo llamado “Toná”.
--Haz que todos los cantaores que cantaban Bamberas o Peteneras canten Tonás.
--No utilices los códigos de los palos, sino sus nombres.
INSERT INTO F_Palos VALUES('TO', 'Toná')

INSERT INTO F_Palos_Cantaor
	SELECT C.Codigo, 'TO'
	FROM F_Cantaores AS C
	INNER JOIN F_Palos_Cantaor AS PC
	ON C.Codigo = PC.Cod_cantaor
	INNER JOIN F_Palos AS P
	ON PC.Cod_Palo = P.Cod_Palo
	WHERE P.Palo IN ('Bamberas', 'Peteneras')

--Ejercicio 3
--Número de cantaores mayores de 30 años que han actuado cada año en cada peña.
--Se contará la edad que tenían en el año de la actuación.
SELECT
	P.Nombre, YEAR(A.Fecha) AS [Año], COUNT(*) AS [Número de cantaores]
FROM
	F_Penhas AS P
	INNER JOIN F_Actua AS A
	ON P.Codigo = A.Cod_Penha
	INNER JOIN F_Cantaores AS C
	ON A.Cod_Cantaor = C.Codigo
WHERE (YEAR(A.Fecha)-C.Anno) >= 30
GROUP BY P.Nombre, YEAR(A.Fecha)

--Ejercicio 4
--Cantaores (nombre, apellidos y nombre artístico)
--que hayan actuado más de dos veces en peñas de la provincia de Sevilla y canten Fandangos o Bulerías.
--Sólo se incluyen las actuaciones directas en Peñas, no los festivales.
SELECT
	DISTINCT
	C.Nombre,
	C.Apellidos,
	C.Nombre_Artistico,
	COUNT(*)
FROM
	F_Cantaores AS C
	INNER JOIN F_Actua AS A
	ON C.Codigo = A.Cod_Cantaor
	INNER JOIN F_Penhas AS PE
	ON A.Cod_Penha = PE.Codigo
	INNER JOIN F_Palos_Cantaor AS PC
	ON C.Codigo = PC.Cod_cantaor
	INNER JOIN F_Palos AS PA
	ON PC.Cod_Palo = PA.Cod_Palo
	INNER JOIN F_Provincias AS PR
	ON PE.Cod_provincia = PR.Cod_Provincia
WHERE
	PA.Palo IN ('Fandangos', 'Bulerías') AND
	PR.Provincia = 'Sevilla'
GROUP BY 
	C.Nombre,
	C.Apellidos,
	C.Nombre_Artistico
HAVING
	COUNT(*)>2

--Ejercicio 5
--Número de actuaciones que se han celebrado en cada peña, incluyendo actuaciones directas y en festivales.
--Incluye el nombre de la peña y la localidad.
SELECT * FROM F_Festivales
SELECT * FROM F_Penhas