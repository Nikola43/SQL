USE pubs
GO

--1. Título y tipo de todos los libros en los que alguno de los autores vive en California (CA). t ta a

SELECT DISTINCT T.title, T.type
	FROM titles AS T
	INNER JOIN titleauthor AS TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON A.au_id=TA.au_id
WHERE A.state='CA'

--2. Título y tipo de todos los libros en los que ninguno de los autores vive en California (CA).

SELECT DISTINCT T.title, T.type
	FROM titles AS T
	INNER JOIN titleauthor AS TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON A.au_id=TA.au_id
WHERE A.state!='CA'

--3. Número de libros en los que ha participado cada autor, incluidos los que no han publicado nada.

SELECT A.au_fname AS Nombre, A.au_lname AS Apellidos, COUNT(T.title_id) AS LibrosEscritos
	FROM titles AS T
	INNER JOIN titleauthor AS TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON A.au_id=TA.au_id
	GROUP BY A.au_fname, A.au_lname

--4. Número de libros que ha publicado cada editorial, incluidas las que no han publicado ninguno.

SELECT P.pub_name AS Editorial, COUNT(T.title_id) AS LibrosPublicados
	FROM titles AS T
	RIGHT JOIN publishers AS P ON P.pub_id=T.pub_id
	GROUP BY P.pub_name

--5. Número de empleados de cada editorial.

SELECT P.pub_name AS Editorial, COUNT(E.emp_id) AS Empleados
	FROM publishers AS P
	INNER JOIN employee AS E ON E.pub_id=P.pub_id
	GROUP BY P.pub_name

--6. Calcular la relación entre número de ejemplares publicados y número de empleados de cada editorial, incluyendo el nombre de la misma.



--7. Nombre, Apellidos y ciudad de todos los autores que han trabajado para la editorial "Binnet & Hardley” o "Five Lakes Publishing”

SELECT A.au_fname AS Nombre, A.au_lname AS Apellidos, A.city AS Ciudad
	FROM authors AS A
	INNER JOIN titleauthor AS TA ON TA.au_id=A.au_id
	INNER JOIN titles AS T ON TA.title_id=T.title_id
	INNER JOIN publishers AS P ON P.pub_id=T.pub_id
WHERE P.pub_name in ('Binnet & Hardley', 'Five Lakes Publishing')
ORDER BY A.au_fname, A.au_lname

--8. Empleados que hayan trabajado en alguna editorial que haya publicado algún libro en el que alguno de los autores fuera Marjorie Green o 
-- Michael O'Leary.
--E P T TA A

SELECT DISTINCT E.emp_id AS ID, E.fname AS Nombre, E.lname AS Apellidos
	FROM employee AS E
	INNER JOIN publishers AS P ON P.pub_id=E.pub_id
	INNER JOIN titles AS T ON T.pub_id=P.pub_id
	INNER JOIN titleauthor as TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON A.au_id=TA.au_id
WHERE A.au_fname in ('Marjorie', 'Michael') AND A.au_lname in ('O''Leary', 'Green')
ORDER BY E.fname, E.lname

-- Otra forma, solo por los loles
-- Creamos una vista que muestre las editoriales que han publicado libros de Marjorie Green o Michael O'Leary
GO
CREATE VIEW [EditorialesQueHanPublicadoLibrosDeMarjorieOMichael]
AS
SELECT P.pub_id AS ID, P.pub_name AS Editorial
	FROM publishers AS P
	INNER JOIN titles AS T ON T.pub_id=P.pub_id
	INNER JOIN titleauthor AS TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON A.au_id=TA.au_id
	WHERE A.au_fname in ('Marjorie', 'Michael') AND A.au_lname in ('O''Leary', 'Green')
GO

-- Ahora hacemos la consulta que incluirá en la condición la vista anterior
SELECT DISTINCT emp_id, fname, lname
FROM employee
WHERE pub_id IN (SELECT ID From [EditorialesQueHanPublicadoLibrosDeMarjorieOMichael])
ORDER BY fname, lname
	
--9. Número de ejemplares vendidos de cada libro, especificando el título y el tipo.

SELECT T.title AS Título, T.type AS Tipo, SUM(S.qty) AS UdVendidas
	FROM titles AS T
	INNER JOIN sales AS S ON S.title_id=T.title_id
	GROUP BY T.title, T.type
	ORDER BY T.title

--10.  Número de ejemplares de todos sus libros que ha vendido cada autor.

SELECT A.au_fname AS Nombre, A.au_lname AS Apellidos, SUM(s.qty) AS UdVendidas
	FROM sales AS S
	INNER JOIN titles AS T ON S.title_id=T.title_id
	INNER JOIN titleauthor AS TA ON TA.title_id=T.title_id
	INNER JOIN authors AS A ON a.au_id=TA.au_id
	GROUP BY au_fname, au_lname 

--11.  Número de empleados de cada categoría (jobs).

SELECT J.job_desc AS Categoría, COUNT(E.emp_id) AS Empleados
	FROM employee AS E
	INNER JOIN jobs AS J on J.job_id=E.job_id
	GROUP BY J.job_desc

--12.  Número de empleados de cada categoría (jobs) que tiene cada editorial, incluyendo aquellas categorías en las que no haya ningún empleado.

SELECT J.job_desc AS Categoría, P.pub_name AS Editorial, COUNT(E.emp_id) AS Empleados
	FROM jobs AS J
	INNER JOIN employee AS E ON E.job_id=J.job_id
	INNER JOIN publishers AS P ON E.pub_id=P.pub_id
	GROUP BY J.job_desc, P.pub_name

--13.  Autores que han escrito libros de dos o más tipos diferentes

SELECT A.au_fname AS Nombre, A.au_lname AS Apellidos, COUNT(T.type) AS TiposEscritos
	FROM authors AS A
	INNER JOIN titleauthor AS TA on TA.au_id=A.au_id
	INNER JOIN titles AS T ON T.title_id= TA.title_id
	GROUP BY A.au_fname, A.au_lname 
	HAVING COUNT(T.type)>1

--14.  Empleados que no trabajan en editoriales que han publicado libros cuya columna notes contenga la palabra "and”

SELECT DISTINCT E.fname AS Nombre, E.lname AS Apellidos 
	FROM employee AS E
	INNER JOIN publishers AS P ON E.pub_id=P.pub_id
	INNER JOIN titles AS T ON P.pub_id=T.pub_id
WHERE T.notes NOT LIKE ('%and%')