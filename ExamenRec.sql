USE LeoSailing
SET Dateformat 'ymd'
GO

--Ejercicio 1
--Queremos saber nombre, apellidos y edad de cada miembro y el n�mero de regatas que ha disputado en barcos de cada clase.

--Ejercicio 2
--Miembros que tengan m�s de 250 horas de cursos y que nunca hayan disputado una regata compartiendo barco con Esteban Dido.

-- En realidad, no hace falta tener en la consulta las horas de curso, porque no nos las piden, con lo que podemos hacerla con EXCEPT

--Ejercicio 3
--Crea una vista VTrabajoMonitores que contenga n�mero de licencia, 
--nombre y apellidos de cada monitor, n�mero de cursos y n�mero total de horas que ha impartido, 
--as� como el n�mero total de alumnos que han participado en sus cursos. A la hora de contar los asistentes, se contaran participaciones, no personas. 
--Es decir, si un mismo miembro ha asistido a tres cursos distintos, se contar� como tres, no como uno. Deben incluirse los monitores a cuyos cursos no haya asistido nadie, para echarles una buena bronca.

GO
CREATE VIEW VTrabajoMonitores 
AS  

	
GO

SELECT * 
FROM EV_Miembros


SELECT * FROM EV_Monitores

SELECT * FROM 
EV_Cursos




GO
CREATE VIEW V_AsistentesCursos
AS  
	SELECT C.codigo_curso, C.licencia, COUNT (MC.licencia_federativa) AS NumeroDeMiembros
	FROM EV_Miembros AS MI
	INNER JOIN EV_Miembros_Cursos AS MC
	  ON MI.licencia_federativa = MC.licencia_federativa
	INNER JOIN EV_Cursos AS C
	  ON MC.codigo_curso = C.codigo_curso
	LEFT JOIN EV_Monitores AS M
	  ON MC.licencia_federativa = M.licencia_federativa
	GROUP BY C.codigo_curso, C.licencia
	
GO

GO
CREATE VIEW V_CurosQueDaCadaMonitor
AS  
	SELECT MO.licencia_federativa, MI.nombre, MI.apellidos, COUNT(C.codigo_curso) AS NumeroCursosImpartidos, AC.NumeroDeMiembros
	FROM EV_Monitores AS MO
	INNER JOIN EV_Miembros AS MI
	  ON MO.licencia_federativa = MI.licencia_federativa
	INNER JOIN EV_Cursos AS C
	  ON MO.licencia_federativa = C.licencia
	INNER JOIN V_AsistentesCursos AS AC
	  ON C.codigo_curso = AC.codigo_curso
	GROUP BY MO.licencia_federativa, MI.nombre, MI.apellidos, AC.NumeroDeMiembros
GO

SELECT * FROM EV_Monitores
WHERE licencia_federativa NOT IN (SELECT licencia_federativa FROM EV_Miembros_Cursos )




SELECT MO.licencia_federativa, MI.nombre, MI.apellidos, COUNT(C.codigo_curso) AS NumeroCursosImpartidos
FROM EV_Monitores AS MO
INNER JOIN EV_Miembros AS MI
  ON MO.licencia_federativa = MI.licencia_federativa
INNER JOIN EV_Cursos AS C
  ON MO.licencia_federativa = C.licencia
RIGHT JOIN EV_Miembros_Cursos AS MC
ON MO.licencia_federativa = MC.licencia_federativa
GROUP BY MO.licencia_federativa, MI.nombre, MI.apellidos
ORDER BY MO.licencia_federativa





SELECT MO.licencia_federativa, MI.nombre, MI.apellidos, C.codigo_curso
FROM EV_Monitores AS MO
INNER JOIN EV_Miembros AS MI
  ON MO.licencia_federativa = MI.licencia_federativa
INNER JOIN EV_Cursos AS C
ON MO.licencia_federativa = C.licencia
ORDER BY MO.licencia_federativa








SELECT * FROM EV_Miembros

SELECT * FROM EV_Miembros_Cursos

SELECT * FROM EV_Cursos
-- Esta vista nos da n�mero de cursos y horas totales de cada monitor

--Ejercicio 4
--N�mero de horas de cursos acumuladas por cada miembro que no haya disputado una regata en la clase 470 en los dos �ltimos a�os (2013 y 2014). Se contar�n �nicamente las regatas que se hayan disputado en un campo de regatas situado en longitud Oeste (W). Se sabe que la longitud es W porque el n�mero es negativo.

--Ejercicio 5
--El comit� de competiciones est� preocupado por el bajo rendimiento de los regatistas en las clases Tornado y 49er, as� que decide organizar unos cursos para repasar las t�cnicas m�s importantes. Los cursos se titulan "Perfeccionamiento Tornado� y "Perfeccionamiento 49er�, ambos de 120 horas de duraci�n. Comezar�n los d�as 21 de marzo y 10 de abril, respectivamente. El primero ser� impartido por Salud Itos y el segundo por Fernando Minguero.
--Escribe un INSERT-SELECT para matricular en estos cursos a todos los miembros que hayan participado en regatas en alguna de estas clases desde el 1 de Abril de 2014, cuidando de que los propios monitores no pueden ser tambi�n alumnos.
-- Insertamos los dos cursos con los c�digos 21 y 22