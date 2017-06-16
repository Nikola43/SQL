USE pubs
GO

--Consultas sobre una sola Tabla con agregados
--1. Numero de libros que tratan de cada tema

SELECT [type] as Tema, COUNT(title_id) NumeroLibros
FROM titles
GROUP BY [type]

--2. N�mero de autores diferentes en cada ciudad y estado

SELECT [state] AS Estado, city AS Ciudad, COUNT(au_id) AS Autores
FROM authors
GROUP BY [state], city
ORDER BY [state] 

--3. Nombre, apellidos, nivel y antig�edad en la empresa de los empleados con un nivel entre 100 y 150.

SELECT fname AS Nombre, lname AS Apellidos, job_lvl AS Nivel, DATEDIFF(YEAR, hire_date, CURRENT_TIMESTAMP) AS Antiguedad
FROM employee
WHERE job_lvl BETWEEN 100 AND 150
ORDER BY Apellidos, Nombre 

--4. N�mero de editoriales en cada pa�s. Incluye el pa�s.
 
SELECT country AS Pais, COUNT(pub_id) AS Editoriales
FROM publishers
GROUP BY country
ORDER BY country 

--5. N�mero de unidades vendidas de cada libro en cada a�o (title_id, unidades y a�o).

SELECT title_id AS Libro, YEAR(ord_date) AS A�o, SUM(qty) AS UdVendidas
FROM sales
GROUP BY title_id, YEAR(ord_date)
ORDER BY Libro, A�o 

--6. N�mero de autores que han escrito cada libro (title_id y numero de autores).

SELECT title_id AS Libro, COUNT(au_id) AS Autores
FROM titleauthor
GROUP BY title_id
ORDER BY title_id

--7. ID, Titulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y t�tulo

SELECT title_id AS ID, title as T�tulo, [type] AS Tipo, price AS Precio
FROM titles
WHERE advance>7000
ORDER BY Tipo, T�tulo