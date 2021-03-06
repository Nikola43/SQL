--Bases de datos
--Consultas y actualizaciones Bichos
--Consultas y DML. Entry level
--Sobre la base de datos BICHOS.

USE Bichos

--1. Introduce dos nuevos clientes. As�gnales los c�digos que te parezcan adecuados.
-- insertamos primer cliente
INSERT INTO BI_Clientes
VALUES ( '107', '666666666', 'c/ intel', 'ES4454545454545', 'Francisco jose' )

-- insertamos segundo cliente
INSERT INTO BI_Clientes
VALUES ( '108', '666666667', 'c/ amd', 'ES4454545454655', 'Pepito Grillo Jimenez' )

--2. Introduce una mascota para cada uno de ellos. As�gnales los c�digos que te parezcan adecuados.
-- insertamos una mascota para francisco
INSERT INTO BI_Mascotas
VALUES ( 'LM001', 'Aleman', 'Perro', '2002-02-03', NULL, 'guagua', '107' )

-- insertamos una mascota para pepito
INSERT INTO BI_Mascotas
VALUES ( 'LM002', 'Persa', 'Gato', '2005-02-03', NULL, 'miau', '108' )
SELECT * FROM BI_Mascotas

--3. Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota (una cualquiera). Los IDs no deben repetirse
SELECT IDEnfermedad FROM BI_Mascotas_Enfermedades
WHERE Mascota = 'PH004'

--4. El cliente Josema Ravilla ha llevado a visita a todas sus mascotas. Escribe un SELECT para averiguar el c�digo de Josema Ravilla.
SELECT Codigo FROM BI_Clientes
WHERE Nombre = 'Josema Ravilla'

--5. Escribe otro SELECT para averiguar los c�digos de las mascotas de Josema Ravilla.
SELECT Alias FROM BI_Mascotas
WHERE CodigoPropietario = '102'

--6. Con los c�digos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Visitas. La fecha y hora se tomar�n del sistema.
SELECT * FROM BI_Visitas
SELECT * FROM BI_Mascotas

INSERT INTO BI_Visitas
VALUES ( CURRENT_TIMESTAMP, 39, 32, 'GM002')

INSERT INTO BI_Visitas
VALUES ( CURRENT_TIMESTAMP, 38, 30, 'PH002')

--7. Todos los perros del cliente 104 han enfermado el 20 de diciembre de sarna. Escribe un SELECT para averiguar los c�digos de todos los perros del cliente 104
SELECT Alias, Codigo FROM BI_Mascotas
WHERE CodigoPropietario = '104' AND Especie = 'Perro'

--9. Con los c�digos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Mascotas_Enfermedades
INSERT INTO BI_Mascotas_Enfermedades
VALUES ( 4, 'PH004', CURRENT_TIMESTAMP, NULL ) 

INSERT INTO BI_Mascotas_Enfermedades
VALUES ( 6, 'PH104', CURRENT_TIMESTAMP, NULL ) 

INSERT INTO BI_Mascotas_Enfermedades
VALUES ( 6, 'PM004', CURRENT_TIMESTAMP, NULL ) 
--10. Escribe una consulta para obtener el nombre, especie y raza de todas las mascotas, ordenados por edad.
SELECT Alias, Especie, Raza, Year(CURRENT_TIMESTAMP- CAST (FechaNacimiento AS datetime))-1900 AS Edad FROM BI_Mascotas
ORDER BY Edad

--11. Escribe los c�digos de todas las mascotas que han ido alguna vez al veterinario un lunes o un viernes. Para averiguar el dia de la semana de una fecha se usa la funci�n DATEPART (WeekDay, fecha) que devuelve un entero entre 1 y 7 donde el 1 corresponde al lunes, el dos al martes y as� sucesivamente.
