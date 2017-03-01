--BOLETÍN 7.2
--Consultas sobre una sola Tabla sin agregados
USE pubs
--1. Título, precio y notas de los libros (titles) que tratan de cocina, ordenados de mayor a menor precio.
SELECT title, price, notes FROM titles WHERE type LIKE '%cook' ORDER BY price DESC

--2. ID, descripción y nivel máximo y mínimo de los puestos de trabajo (jobs) que pueden tener un nivel 110.
SELECT job_desc, max_lvl, min_lvl FROM jobs WHERE max_lvl>=110

--3. Título, ID y tema de los libros que contengan la palabra "and” en las notas
SELECT title, title_id, type AS tema FROM titles WHERE notes LIKE '%and%'

--4. Nombre y ciudad de las editoriales (publishers) de los Estados Unidos que no estén en California ni en Texas
SELECT pub_name, city FROM publishers WHERE country = 'USA' AND state NOT IN ('CA','TX')

--5. Título, precio, ID de los libros que traten sobre psicología o negocios y cuesten entre diez y 20 dólares.
SELECT title, price, title_id FROM titles WHERE (type IN ('psychology', 'business') ) AND (price BETWEEN 10 AND 20)

--6. Nombre completo (nombre y apellido) y dirección completa de todos los autores que no viven en California ni en Oregón.
SELECT au_fname+' '+au_lname AS [Nombre Completo], address+', '+city+', '+state AS [Dirección Completa] FROM authors WHERE state NOT IN ('CA', 'OR')

--7. Nombre completo y dirección completa de todos los autores cuyo apellido empieza por D, G o S.
SELECT au_fname+' '+au_lname AS [Nombre Completo], address+', '+city+', '+state AS [Dirección Completa] FROM authors WHERE au_lname LIKE '[DGS]%'

--8. ID, nivel y nombre completo de todos los empleados con un nivel inferior a 100, ordenado alfabéticamente
SELECT emp_id, job_lvl, fname+' '+lname AS [Nombre completo] FROM employee WHERE job_lvl < 100 ORDER BY fname ASC


--Modificaciones de datos
--1. Inserta un nuevo autor.
INSERT INTO authors (au_id, au_lname, au_fname, phone, address, city, state, zip, contract)
VALUES ('123-56-1278' ,'Parrado Ortega', 'Daniel', '696272727', 'Avenida de las Tortitas con caramelo', 'Sevilla', 'AN', '41007', 1)


--2. Inserta dos libros, escritos por el autor que has insertado antes y publicados por la editorial "Ramona publishers”.

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('hola', 'Bailando con unicornios rosas', 'BaileUniRos_', '1756', 999.99, 999.99, 100, 272727, 'El mejor libro de este milenio', CURRENT_TIMESTAMP)
INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('adios', 'Bailando con hadas verdes', 'BaileHadVerd', '1756', 999.99, 999.99, 100, 272727, 'El mejor libro del siguiente milenio', CURRENT_TIMESTAMP)

INSERT INTO titleauthor VALUES ('123-56-1278', 'hola', 3, 12)
INSERT INTO titleauthor VALUES ('123-56-1278', 'adios', 3, 12)

--3. Modifica la tabla jobs para que el nivel mínimo sea 90.
--ALTER TABLE jobs DROP CONSTRAINT CK_nivelMinimo90
ALTER TABLE jobs ADD CONSTRAINT CK_nivelMinimo90 CHECK (min_lvl = 90)


--4. Crea una nueva editorial (publihers) con ID 9908, nombre Mostachon Books y sede en Utrera.
INSERT INTO publishers VALUES ('9908', 'Mostachon Books', 'Utrera', 'AN', 'Spain')

--5. Cambia el nombre de la editorial con sede en Alemania para que se llame "Machen Wücher" y traslasde su sede a Stuttgart
UPDATE publishers SET pub_name = 'Machen Wücher' WHERE country = 'Germany'
SELECT * FROM publishers WHERE country = 'Germany'
