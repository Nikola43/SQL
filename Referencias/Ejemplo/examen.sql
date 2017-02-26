USE LeoSailing

--Control Consultas avanzadas
--Especificaciones:
--Descargate el Script EscuelaVela.sql de la plataforma y ejecútalo en SQL Server.
--A los efectos de las consultas, se considera "monitor” a cualquier miembro que haya impartido algún curso en la escuela.
--Consultas y actualizaciones
--Ejercicio 1
--Queremos saber nombre, apellidos y edad de cada miembro y el número de regatas que ha disputado en barcos de cada clase.

--Ejercicio 2
--Miembros que tengan más de 250 horas de cursos y que nunca hayan disputado una regata compartiendo barco con Esteban Dido.

--Ejercicio 3
--Crea una vista VTrabajoMonitores que contenga número de licencia, nombre y apellidos de cada monitor, número de cursos y 
--número total de horas que ha impartido, así como el número total de alumnos que han participado en sus cursos.
--A la hora de contar los asistentes, se contaran participaciones, no personas.
--Es decir, si un mismo miembro ha asistido a tres cursos distintos, se contará como tres, no como uno. 
--Deben incluirse los monitores a cuyos cursos no haya asistido nadie, para echarles una buena bronca.

--Ejercicio 4
--Número de horas de cursos acumuladas por cada miembro que no haya disputado una regata en la clase 470 
--en los dos últimos años (2013 y 2014). Se contarán únicamente las regatas que se hayan disputado en un campo de regatas 
--situado en longitud Oeste (W). Se sabe que la longitud es W porque el número es negativo.

--Ejercicio 5
--El comité de competiciones está preocupado por el bajo rendimiento de los regatistas en las clases Tornado y 49er, 
--así que decide organizar unos cursos para repasar las técnicas más importantes. Los cursos se titulan "Perfeccionamiento Tornado” y 
--"Perfeccionamiento 49er”, ambos de 120 horas de duración. Comezarán los días 21 de marzo y 10 de abril, respectivamente. 
--El primero será impartido por Salud Itos y el segundo por Fernando Minguero.

--Escribe un INSERT-SELECT para matricular en estos cursos a todos los miembros que hayan participado en regatas en alguna de estas clases desde el 1 de Abril de 2014, 
--cuidando de que los propios monitores no pueden ser también alumnos.

 -- 1 Queremos saber nombre, apellidos y edad de cada miembro y el número de regatas que ha disputado en barcos de cada clase.
 SELECT DISTINCT M.nombre, M.apellidos, YEAR(CURRENT_TIMESTAMP - M.f_nacimiento) - 1900 AS EDAD, B.nombre_clase, COUNT(*) AS NumeroRegatas
 FROM EV_Miembros AS M 

 JOIN EV_Miembros_Barcos_Regatas AS MBR ON M.licencia_federativa = MBR.licencia_miembro
 JOIN EV_Barcos AS B ON MBR.n_vela = B.n_vela

 WHERE B.nombre_clase IS NOT NULL

 GROUP BY M.licencia_federativa, M.nombre, M.apellidos, M.f_nacimiento, B.nombre_clase


 -- 2 Miembros que tengan más de 250 horas de cursos y que nunca hayan disputado una regata compartiendo barco con Esteban Dido.
 SELECT DISTINCT M.nombre, M.apellidos, SUM(C.duracion) AS Horas
 FROM EV_Miembros AS M

 JOIN EV_Miembros_Cursos AS MC ON M.licencia_federativa = MC.licencia_federativa
 JOIN EV_Cursos AS C ON MC.codigo_curso = C.codigo_curso
 WHERE M.licencia_federativa NOT IN (SELECT M.licencia_federativa FROM EV_Miembros 
 WHERE M.nombre = 'Esteban' and m.apellidos = 'Dido' )
GROUP BY M.nombre, M.apellidos
 HAVING SUM(C.duracion) > 250



SELECT M.nombre, M.apellidos
	FROM EV_Miembros AS M
		JOIN EV_Miembros_Cursos AS MC ON M.licencia_federativa = MC.licencia_federativa
		JOIN EV_Cursos AS C ON MC.codigo_curso = c.codigo_curso
	GROUP BY M.licencia_federativa, M.nombre, M.apellidos
	HAVING SUM(C.duracion) > 250
EXCEPT
SELECT DISTINCT M1.nombre, M1.apellidos			-- Los que han compartido barco con Esteban
			FROM EV_Miembros AS M1 
				JOIN EV_Miembros_Barcos_Regatas AS MBR1 ON M1.licencia_federativa = MBR1.licencia_miembro
				JOIN EV_Miembros_Barcos_Regatas AS MBR2 ON MBR1.f_inicio_regata = MBR2.f_inicio_regata AND MBR1.n_vela = MBR2.n_vela
				JOIN EV_Miembros AS M2 ON MBR2.licencia_miembro = M2.licencia_federativa
			WHERE M2.nombre = 'Esteban' AND M2.apellidos = 'Dido' AND M1.nombre <> 'Esteban' AND M1.apellidos <> 'Dido'


 SELECT * FROM EV_Miembros
 SELECT * FROM EV_Cursos


----Crea una vista VTrabajoMonitores que contenga número de licencia, nombre y apellidos de cada monitor, número de cursos y 
--número total de horas que ha impartido, así como el número total de alumnos que han participado en sus cursos.

GO
CREATE VIEW VTrabajoMonitores AS
SELECT m.SS, m.DI, m.licencia_federativa, COUNT(c.codigo_curso) as numero_de_cursos, sum(C.duracion) as numero_de_horas, COUNT(MC.licencia_federativa) as numero_de_alumnos
FROM EV_Monitores AS M
JOIN EV_Cursos AS C ON M.licencia_federativa = C.licencia
JOIN EV_Miembros_Cursos AS MC ON c.licencia = mc.licencia_federativa 
group by m.SS, m.DI, m.licencia_federativa
GO

--Miembros que tengan más de 250 horas de cursos y que nunca hayan disputado una regata compartiendo barco con Esteban Dido.
SELECT DISTINCT nombre, apellidos, YEAR(CURRENT_TIMESTAMP - f_nacimiento) - 1900 AS EDAD, COUNT(C.duracion) AS Horas
FROM EV_Miembros AS M

JOIN EV_Miembros_Cursos AS MC ON M.licencia_federativa = MC.licencia_federativa

JOIN EV_Cursos AS C ON MC.codigo_curso = C.codigo_curso


GROUP BY M.nombre, M.apellidos, M.f_nacimiento, C.duracion

SELECT duracion From EV_Cursos
