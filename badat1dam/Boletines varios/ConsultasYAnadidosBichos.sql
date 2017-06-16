USE Bichos
GO

--1. Introduce dos nuevos clientes. Asígnales los códigos que te parezcan adecuados.

--SELECT*FROM BI_Clientes 

INSERT INTO BI_Clientes
VALUES (107, '650824620', 'Calle Araquil, 12', 'ES4859652315478965231526', 'Amanda Huevos'),
(108, '603756900', 'Avenida de La Paz, 71', 'ES4583215698547236512895', 'Ana Bohueles')

--2. Introduce una mascota para cada uno de ellos. Asígnales los códigos que te parezcan adecuados.

--SELECT*FROM BI_Mascotas

INSERT INTO BI_Mascotas
VALUES ('PH107', 'Husky siberiano', 'Perro', '2007-06-13', NULL, 'Lobo', 107),
('CM108', 'Purasangre', 'Caballo', '2006-08-07', NULL, 'Zafiro', 108)

--3. Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota (una cualquiera). Los IDs no deben repetirse

--SELECT * FROM BI_Mascotas_Enfermedades 

SELECT DISTINCT IDEnfermedad
FROM BI_Mascotas_Enfermedades
WHERE Mascota='PH004' --aquí cambiamos el código de la mascota de la que se desea conocer las enfermedades

--4. El cliente Josema Ravilla ha llevado a visita a todas sus mascotas.
--4.1. Escribe un SELECT para averiguar el código de Josema Ravilla.

SELECT Codigo
FROM BI_Clientes
WHERE Nombre='Josema Ravilla'

--4.2. Escribe otro SELECT para averiguar los códigos de las mascotas de Josema Ravilla.

SELECT Codigo
FROM BI_Mascotas
WHERE CodigoPropietario=102 --GM002 y PH002

--4.3. Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Visitas. 
--La fecha y hora se tomarán del sistema.

SELECT * FROM BI_Visitas 

INSERT INTO BI_Visitas
(Fecha, Temperatura, Peso, Mascota)
VALUES (CAST(CURRENT_TIMESTAMP AS smalldatetime), 38, 5, 'GM002'),
(CAST(CURRENT_TIMESTAMP AS smalldatetime), 39, 20, 'PH002')

--5. Todos los perros del cliente 104 han enfermado el 20 de diciembre de sarna.
--5.1. Escribe un SELECT para averiguar los códigos de todos los perros del cliente 104

SELECT Codigo
FROM BI_Mascotas
WHERE CodigoPropietario='104' AND Codigo LIKE 'P%' --Codigos obtenidos: PH004, PH104, PM004

--5.2. Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Mascotas_Enfermedades

-- El ID De la Sarna es 4
INSERT INTO BI_Mascotas_Enfermedades
VALUES(4, 'PH004', '2016-12-20', NULL), (4, 'PH104', '2016-12-20', NULL), (4, 'PM004', '2016-12-20', NULL)

--6. Escribe una consulta para obtener el nombre, especie y raza de todas las mascotas, ordenados por edad.

SELECT Alias, Especie, Raza, FechaNacimiento  --DATEDIFF(YEAR, FechaNacimiento, CAST(CURRENT_TIMESTAMP AS date)) AS Edad
FROM BI_Mascotas
ORDER BY FechaNacimiento

/*7.Escribe los códigos de todas las mascotas que han ido alguna vez al veterinario un lunes o un viernes. Para averiguar el dia de 
la semana de una fecha se usa la función DATEPART (WeekDay, fecha) que devuelve un entero entre 1 y 7 donde el 1 corresponde al lunes, 
el dos al martes y así sucesivamente.
NOTA: El servidor se puede configurar para que la semana empiece en lunes o domingo.*/

SELECT * FROM BI_Visitas

SELECT DISTINCT Mascota
FROM BI_Visitas
WHERE DATEPART(WeekDay, Fecha) in (1, 5) 