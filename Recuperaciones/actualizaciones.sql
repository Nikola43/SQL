--Bases de datos
--Ejercicios actualizaciones
--Ejercicios sobre la base de datos pubs

USE pubs
SET DATEFORMAT YMD
GO

--Actualizaciones
--1.- Hemos descubierto que Albert Ringer es un pseudónimo utilizado por los hermanos gemelos John y Margaret Sullivan.

-- Queremos crear estos dos autores copiando los datos de Albert Ringer y colocarlos a ambos como autores en todos los libros
-- en que aparezca este último. 

--Estos nombres son los únicos datos que pueden introducirse de forma directa, el resto de datos han
-- de obtenerse de las otras tablas con UPDATE…FROM o INSERT…SELECT

--------------------------   INSERTAMOS DOS NUEVOS AUTORES ----------------------------
BEGIN TRANSACTION

-- INSERTAMOS A John Sullivan.
INSERT INTO authors
SELECT '998-72-3568', 'Sullivan', 'John', phone, address, city, state, zip, contract
FROM authors 
WHERE au_fname = 'Albert' AND au_lname = 'Ringer'

-- INSERTAMOS A Margaret Sullivan.
INSERT INTO authors
SELECT '998-72-3569', 'Sullivan', 'Margaret', phone, address, city, state, zip, contract
FROM authors 
WHERE au_fname = 'Albert' AND au_lname = 'Ringer'

COMMIT TRANSACTION
-------------------------------------------------------------------------------------------------------

--------------------------   ASIGNAMOS LIBROS A LOS NUEVOS AUTORES CREADOS ----------------------------
BEGIN TRANSACTION

	UPDATE titleauthor
	SET au_id = (SELECT au_id
				 FROM authors
				 WHERE au_fname = 'John' AND au_lname = 'Sullivan')
	FROM authors AS A
	INNER JOIN titleauthor AS TA
	  ON A.au_id = TA.au_id
	WHERE au_fname = 'Albert' AND au_lname = 'Ringer'

COMMIT TRANSACTION
-------------------------------------------------------------------------------------------------------

--------------- INSERTAMOS EN TITLEAUTHOR QUE LOS LIBROS PERTENECEN AL OTRO AUTOR TANBIEN -------------
BEGIN TRANSACTION

	-- Insertamos en title autor que los libros pertenecen a otro autor tambien
	INSERT INTO titleauthor
		SELECT (SELECT au_id
				 FROM authors
				 WHERE au_fname = 'Margaret' AND au_lname = 'Sullivan'), TA.title_id, TA.au_ord, TA.royaltyper
		FROM authors AS A
		INNER JOIN titleauthor AS TA
		  ON A.au_id = TA.au_id
		WHERE au_fname = 'John' AND au_lname = 'Sullivan'

COMMIT TRANSACTION
-------------------------------------------------------------------------------------------------------

SELECT T.title 
FROM authors AS A
INNER JOIN titleauthor AS TS
  ON A.au_id = TS.au_id
INNER JOIN titles AS T
  ON TS.title_id = T.title_id
WHERE au_fname = 'John' AND au_lname = 'Sullivan'

SELECT T.title 
FROM authors AS A
INNER JOIN titleauthor AS TS
  ON A.au_id = TS.au_id
INNER JOIN titles AS T
  ON TS.title_id = T.title_id
WHERE au_fname = 'Margaret' AND au_lname = 'Sullivan'

--2.- Para afrontar la crisis, hemos decidido bajar un 10% los precios de los libros de los que se hayan vendido menos de 20 ejemplares.

-- Libros que se han vendido menos de 20 ejemplares
BEGIN TRANSACTION
UPDATE titles
SET price = price - (price * 0.10)
FROM titles AS T
INNER JOIN sales AS S
  ON T.title_id = S.title_id
WHERE T.title_id IN (SELECT S.title_id
				  FROM titles AS T
				  INNER JOIN sales AS S
				    ON T.title_id = S.title_id
				  GROUP BY S.title_id 
				  HAVING SUM(S.qty) < 20)
--ROLLBACK
COMMIT TRANSACTION

-- Comprobamos que los libros ahora valen un 10% menos
SELECT S.title_id, T.price
FROM titles AS T
INNER JOIN sales AS S
  ON T.title_id = S.title_id
GROUP BY S.title_id, T.price
HAVING SUM(S.qty) < 20






--3.-  Título de cada libro, nombre de la editorial y número de autores

--Programación
--4.- Crea un procedimiento que incremente el nivel de los trabajadores según la siguiente regla:

--Los que trabajen en editoriales que tengan más de 5 autores diferentes y tengan más de 10 años de antigüedad, subirán 5 puntos.
--Los que sólo cumplan la primera condición, subirán 3 puntos.
--Comprueba que no se exceda el nivel máximo asignado a su puesto.
--5.- Crea una columna “UnidadesVendidas” en la tabla Titles. Asígnale el valor que le corresponda. Crea los triggers necesarios en la tabla Sales para mantenerla actualizada

--6.- Crea una función a la que pasemos como parámetro una editorial y un rango de fechas y nos devuelva el total vendido por esa editorial en ese periodo.

--7.- Crea una función a la que pasemos como parámetro un año y nos devuelva una tabla en la que conste el id,
--nombre y apellidos de cada autor y el total ganado en ese año. Para calcular las ganancias es necesario tener
--en cuenta las ventas de los libros de ese autor, el royalty asignado a cada libro (es el porcentaje que 
--reciben los autores de las ventas y depende del libro y del número de ejemplares vendido según la tabla 
--roysched) y el porcentaje de ese royalty que percibe cada uno de los autores en caso de que haya más de uno.
-- Este dato se obtiene de la columna royaltyper de la tabla titleauthor
