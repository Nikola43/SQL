USE pubs
go

--Consultas sobre una sola Tabla sin agregados
--1. Título, precio y notas de los libros (titles) que tratan de cocina, ordenados de mayor a menor precio.

SELECT title, price, notes
FROM titles
WHERE [type] in ('mod_cook', 'trad_cook')
ORDER BY price

--2. ID, descripción y nivel máximo y mínimo de los puestos de trabajo (jobs) que pueden tener un nivel 110.

SELECT job_id, job_desc, max_lvl, min_lvl
FROM jobs
WHERE 110 BETWEEN min_lvl AND max_lvl

--3. Título, ID y tema de los libros que contengan la palabra "and” en las notas

SELECT title, title_id, type, notes
FROM titles
WHERE notes LIKE '%and%'

--4. Nombre y ciudad de las editoriales (publishers) de los Estados Unidos que no estén en California ni en Texas

SELECT pub_name, city, [state], country 
FROM publishers
WHERE country='USA' AND [state] NOT IN ('CA', 'TX')

--5. Título, precio, ID de los libros que traten sobre psicología o negocios y cuesten entre diez y 20 dólares.

SELECT title, price, title_id
FROM titles
WHERE (price BETWEEN 10 AND 20) AND [type] IN ('business', 'psychology')

--6. Nombre completo (nombre y apellido) y dirección completa de todos los autores que no viven en California ni en Oregón.

SELECT au_lname, au_fname, [address], city, [state]
FROM authors
WHERE [state] NOT IN ('CA', 'OR')

--7. Nombre completo y dirección completa de todos los autores cuyo apellido empieza por D, G o S.

SELECT au_lname, au_fname, [address], city, [state]
FROM authors
WHERE au_lname LIKE 'D%' OR au_lname LIKE 'G%' OR au_lname LIKE 'S%'

--8. ID, nivel y nombre completo de todos los empleados con un nivel inferior a 100, ordenado alfabéticamente

SELECT emp_id, job_lvl, lname, fname
FROM employee
WHERE job_lvl<100
ORDER BY lname, fname

--Modificaciones de datos
--1. Inserta un nuevo autor.

INSERT INTO authors 
VALUES 
('123-45-6789', 'Pérez-Reverte', 'Arturo', '123 456-7890', '4 Real Academia, Felipe IV', 'Madrid', 'ES', '28014', 0)

--2. Inserta dos libros, escritos por el autor que has insertado antes y publicados por la editorial "Ramona publishers”.
select * from titles --el pub_id de Ramona Publishers es 1756

INSERT INTO titles
VALUES ('TC1234', 'El Puto Venado', 'mod_cook', '1756', null, null, null, null, null, '19990425 00:00:00.000'),
('PC1234', 'El Club De La Lucha', 'popular_comp', '1756', null, null, null, null, null, '19980425 00:00:00.000')

--3. Modifica la tabla jobs para que el nivel mínimo sea 90.

UPDATE jobs
SET min_lvl=90
WHERE min_lvl<90

--4. Crea una nueva editorial (publihers) con ID 9908, nombre Mostachon Books y sede en Utrera.

INSERT INTO publishers
VALUES ('9908', 'Mostachon Books', 'Utrera', 'ES', 'España') 

--5. Cambia el nombre de la editorial con sede en Alemania para que se llame "Machen Wücher" y traslasde su sede a Stuttgart

UPDATE publishers
SET pub_name='Machen Wücher', city='Stuttgart'
WHERE country='Germany'