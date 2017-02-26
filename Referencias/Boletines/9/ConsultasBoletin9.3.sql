USE pubs

--T�tulo y tipo de todos los libros en los que alguno de los autores vive en California (CA).
SELECT title, type FROM titles
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY

--T�tulo y tipo de todos los libros en los que ninguno de los autores vive en California (CA).
SELECT  FROM 
	WHERE
	GROUP BY
	HAVING
	ORDER BY

--N�mero de libros en los que ha participado cada autor, incluidos los que no han publicado nada.
SELECT a.au_fname, a.au_lname, COUNT(t.title_id) as N�Titles FROM authors as a
LEFT JOIN titleauthor as ta
ON a.au_id=ta.au_id
JOIN titles as t
ON ta.title_id=t.title_id
	--WHERE
	GROUP BY a.au_fname, a.au_lname
	--HAVING
	--ORDER BY

--N�mero de libros que ha publicado cada editorial, incluidas las que no han publicado ninguno.
SELECT p.pub_name, COUNT(title_id) as Libros FROM publishers as p
LEFT JOIN titles as t
ON p.pub_id=t.pub_id
	--WHERE
	GROUP BY p.pub_name
	--HAVING
	--ORDER BY

--N�mero de empleado de cada editorial.
SELECT p.pub_name, COUNT(e.emp_id) as N�Emp FROM employee as e
JOIN publishers AS p
ON e.pub_id=p.pub_id
	--WHERE
	GROUP BY p.pub_name
	--HAVING
	--ORDER BY

--Calcular la relaci�n entre n�mero de ejemplares publicados y n�mero de empleados de cada editorial, incluyendo el nombre de la misma.


--Nombre, Apellidos y ciudad de todos los autores que han trabajado para la editorial "Binnet & Hardley� o "Five Lakes Publishing�
SELECT a.au_fname, a.au_lname, a.city FROM authors AS a
JOIN titleauthor as ta
ON a.au_id=ta.au_id
JOIN titles as t
ON ta.title_id=t.title_id
JOIN publishers as p
ON t.pub_id=p.pub_id
	WHERE p.pub_name IN ('Binnet & Hardley', 'Five Lakes Publishing')
	--GROUP BY
	--HAVING
	--ORDER BY

--Empleados que hayan trabajado en alguna editorial que haya publicado alg�n libro en el que alguno de los autores fuera Marjorie Green o Michael O'Leary.
SELECT fname, lname FROM employee
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY

--N�mero de ejemplares vendidos de cada libro, especificando el t�tulo y el tipo.
SELECT t.title, t.type, COUNT(s.ord_num) as TitlesSales FROM titles as t
JOIN sales as s
ON t.title_id=s.title_id
	--WHERE
	GROUP BY t.title, t.type
	--HAVING
	--ORDER BY

--N�mero de ejemplares de todos sus libros que ha vendido cada autor.
SELECT au_fname, au_lname, COUNT(s.ord_num) as QtyTitles  FROM authors as a
JOIN titleauthor as ta
ON a.au_id=ta.au_id
JOIN titles as t
ON ta.title_id=t.title_id
JOIN sales as s
ON t.title_id=s.title_id
	--WHERE
	GROUP BY au_fname, au_lname
	--HAVING
	--ORDER BY

--N�mero de empleados de cada categor�a (jobs).
SELECT job_desc, COUNT(e.emp_id) as QtyEmpl FROM jobs as j
LEFT JOIN employee as e
ON j.job_id=e.job_id
	--WHERE
	GROUP BY job_desc
	--HAVING
	--ORDER BY

--N�mero de empleados de cada categor�a (jobs) que tiene cada editorial, incluyendo aquellas categor�as en las que no haya ning�n empleado.
SELECT  FROM
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY

--Autores que han escrito libros de dos o m�s tipos diferentes que no trabajan en editoriales que han publicado libros cuya columna notes contenga la palabra "and�
SELECT  FROM
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY