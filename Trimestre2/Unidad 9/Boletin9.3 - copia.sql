use pubs

--1. T�tulo y tipo de todos los libros en los que alguno de los autores vive en California (CA).
SELECT T.title, T.type, A.state
FROM titles AS T
INNER JOIN titleauthor AS TA
ON T.title_id = TA.title_id
INNER JOIN authors AS A
ON TA.au_id = A.au_id
WHERE A.state = 'CA'

--2. T�tulo y tipo de todos los libros en los que ninguno de los autores vive en California (CA).
SELECT T.title, T.type, A.state
FROM titles AS T
INNER JOIN titleauthor AS TA
ON T.title_id = TA.title_id
INNER JOIN authors AS A
ON TA.au_id = A.au_id
WHERE A.state != 'CA'

--3. N�mero de libros en los que ha participado cada autor, incluidos los que no han publicado nada.
SELECT COUNT(T.title_id) AS [Numero de libros], A.au_id
FROM titles AS T
INNER JOIN titleauthor AS TA
ON T.title_id = TA.title_id
INNER JOIN authors AS A
ON TA.au_id = A.au_id
GROUP BY A.au_id
ORDER BY A.au_id

--4. N�mero de libros que ha publicado cada editorial, incluidas las que no han publicado ninguno.
SELECT COUNT(T.title_id) AS [Numero de libros], P.pub_name
FROM titles AS T
INNER JOIN publishers AS P
ON T.pub_id = P.pub_id
GROUP BY P.pub_name

--5. N�mero de empleado de cada editorial.
SELECT COUNT(E.emp_id) AS [Numero de empleados], P.pub_name
FROM employee AS E
INNER JOIN publishers AS P
ON E.pub_id = P.pub_id
GROUP BY P.pub_name

--6. Calcular la relaci�n entre n�mero de ejemplares publicados y n�mero de empleados de cada editorial, incluyendo el nombre de la misma.

--7. Nombre, Apellidos y ciudad de todos los autores que han trabajado para la editorial "Binnet & Hardley� o "Five Lakes Publishing�
--8. Empleados que hayan trabajado en alguna editorial que haya publicado alg�n libro en el que alguno de los autores fuera Marjorie Green o Michael O'Leary.
--9. N�mero de ejemplares vendidos de cada libro, especificando el t�tulo y el tipo.
--10.  N�mero de ejemplares de todos sus libros que ha vendido cada autor.
--11.  N�mero de empleados de cada categor�a (jobs).
SELECT
FROM
--12.  N�mero de empleados de cada categor�a (jobs) que tiene cada editorial, incluyendo aquellas categor�as en las que no haya ning�n empleado.
--13.  Autores que han escrito libros de dos o m�s tipos diferentes
--14.  Empleados que no trabajan en editoriales que han publicado libros cuya columna notes contenga la palabra "and�