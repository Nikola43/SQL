USE pubs
--1.Número de libros que tratan de cada tema
SELECT type, COUNT(type) AS [Número] FROM titles GROUP BY type

--2. Número de autores diferentes en cada ciudad y estado
SELECT city, state, COUNT(au_lname) FROM authors GROUP BY city, state

--3. Nombre, apellidos, nivel y antigüedad en la empresa de los empleados con un nivel entre 100 y 150.
SELECT fname, lname, job_lvl, datediff(year, hire_date, CURRENT_TIMESTAMP) AS [Antigüedad] FROM employee WHERE (job_lvl>=100 AND job_lvl<=150)

--4. Número de editoriales en cada país. Incluye el país.
SELECT country, COUNT(pub_name) AS [Número de editoriales] FROM publishers GROUP BY country

--5. Número de unidades vendidas de cada libro en cada año (title_id, unidades y año).
SELECT YEAR(ord_date) AS [Año], title_id, SUM(qty) AS [Unidades Vendidas] FROM sales GROUP BY YEAR(ord_date), title_id

--6. Número de autores que han escrito cada libro (title_id y numero de autores).
SELECT title_id, COUNT(*) AS [Número de autores] FROM titleauthor GROUP BY title_id ORDER BY COUNT(title_id) DESC

--7. ID, Titulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y título
SELECT title_id, title, price FROM titles WHERE advance>7000 ORDER BY type, title