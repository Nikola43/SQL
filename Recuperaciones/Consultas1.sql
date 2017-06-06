
USE pubs
GO
SET DATEFORMAT YMD
GO 

--Observa la base de datos pubs. ¿Notas algo extraño?

--Iniciación:
--Una sola tabla

--1.- Nombre, fecha de contratación y nivel de los trabajadores con más de 15 años de antigüedad
SELECT fname, hire_date, job_lvl, DATEDIFF(YEAR, hire_date, CURRENT_TIMESTAMP) AS Antigüedad
FROM employee
WHERE DATEDIFF(YEAR, hire_date, CURRENT_TIMESTAMP) > 15

--2.- Título y precio de los libros que no sean de la categoría “psychology“ ni “Business”
SELECT title, price
FROM titles
WHERE type in ('business', 'psychology')

--Medio:
--3.-  Título de cada libro, nombre de la editorial y número de autores
SELECT T.title, P.pub_name, COUNT(TA.au_id) AS NumeroAutores
FROM authors AS A
INNER JOIN titleauthor AS TA
  ON A.au_id = TA.au_id
INNER JOIN titles AS T
  ON TA.title_id = T.title_id
INNER JOIN publishers AS P
  ON T.pub_id = P.pub_id
GROUP BY T.title, P.pub_name

--4.- Descripción de cada puesto de trabajo (job) y número de empleados que realizan esa labor.
SELECT J.job_desc, COUNT(E.job_id) AS NumeroTrabajadores
FROM jobs AS J
INNER JOIN employee AS E
  ON j.job_id = E.job_id
GROUP BY J.job_desc

--5.- Número de trabajadores de cada editorial, nivel medio de los mismos y antigüedad media.

--6.- Valor de las ventas totales de cada almacén en cada año, y nombre del almacén.

--7.- Nombre de la editorial y de los empleados que trabajen como Publisher, editor o designer.

--8.- Autores (nombre completo y ciudad) que hayan escrito algún libro de cocina (incluye cocina moderna y tradicional).

--9.- Título del libro más vendido de cada categoría, indicando también cuántos ejemplares se han vendido.

--10.- Título del libro más vendido de cada editorial, indicando también cuántos ejemplares se han vendido.

 

--Si te quedas con ganas, intenta este reto:

--Finding the Islands
--Considera que no hay más de dos periodos contiguos.

--http://beyondrelational.com/puzzles/challenges/113/finding-the-islands.aspx

 

--Última modificación: lunes, 10 de junio de 2013, 21:09