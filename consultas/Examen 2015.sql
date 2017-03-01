USE Flamenco

--EJERCICIO 1
--N�mero de veces que ha actuado cada cantaor en cada festival de la provincia de C�diz, incluyendo a los que no han actuado nunca
SELECT
	C.Nombre_Artistico,
	COUNT(*) AS [N�mero de veces]
FROM
	F_Cantaores AS C
	LEFT OUTER JOIN F_Festivales_Cantaores AS FC
	ON C.Codigo = FC.Cod_Cantaor
	LEFT OUTER JOIN F_Festivales AS F
	ON FC.Cod_Festival = F.Cod
	LEFT OUTER JOIN F_Provincias AS P
	ON F.Provincia = P.Cod_Provincia
	WHERE P.Provincia = 'C�diz' OR P.Provincia IS NULL
GROUP BY
	C.Nombre_Artistico

--EJERCICIO 2
--Crea un nuevo palo llamado �Ton�.
--Haz que todos los cantaores que cantaban Bamberas o Peteneras canten Ton�s.
--No utilices los c�digos de los palos, sino sus nombres.
INSERT INTO F_Palos VALUES('TO', 'Ton�')

INSERT INTO F_Palos_Cantaor
	SELECT C.Codigo, 'TO'
	FROM F_Cantaores AS C
	INNER JOIN F_Palos_Cantaor AS PC
	ON C.Codigo = PC.Cod_cantaor
	INNER JOIN F_Palos AS P
	ON PC.Cod_Palo = P.Cod_Palo
	WHERE P.Palo IN ('Bamberas', 'Peteneras')

--Ejercicio 3
--N�mero de cantaores mayores de 30 a�os que han actuado cada a�o en cada pe�a.
--Se contar� la edad que ten�an en el a�o de la actuaci�n.
SELECT
	P.Nombre, YEAR(A.Fecha) AS [A�o], COUNT(*) AS [N�mero de cantaores]
FROM
	F_Penhas AS P
	INNER JOIN F_Actua AS A
	ON P.Codigo = A.Cod_Penha
	INNER JOIN F_Cantaores AS C
	ON A.Cod_Cantaor = C.Codigo
WHERE (YEAR(A.Fecha)-C.Anno) >= 30
GROUP BY P.Nombre, YEAR(A.Fecha)

--Ejercicio 4
--Cantaores (nombre, apellidos y nombre art�stico)
--que hayan actuado m�s de dos veces en pe�as de la provincia de Sevilla y canten Fandangos o Buler�as.
--S�lo se incluyen las actuaciones directas en Pe�as, no los festivales.
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
	PA.Palo IN ('Fandangos', 'Buler�as') AND
	PR.Provincia = 'Sevilla'
GROUP BY 
	C.Nombre,
	C.Apellidos,
	C.Nombre_Artistico
HAVING
	COUNT(*)>2

--Ejercicio 5
--N�mero de actuaciones que se han celebrado en cada pe�a, incluyendo actuaciones directas y en festivales.
--Incluye el nombre de la pe�a y la localidad.
SELECT * FROM F_Festivales
SELECT * FROM F_Penhas