 
USE LeoFest
SET Dateformat 'ymd'
GO

--Programación
--Sobre la base de datos LeoFest.
--Ejercicio 1
--Haz una función a la que se pase el nombre de una banda y un rango de fechas y nos devuelva una tabla indicando
--cuantas veces ha interpretado cada tema en ese rango de fechas. Las columnas serán ID del tema, título, nombre del autor, 
--nombre del estilo y número de veces que se ha interpretado.ç
GO
CREATE FUNCTION dbo.calcularVecesCantadasCadaTema(@nombreBanda varchar(50), @inicio date, @fin date)
RETURNS TABLE AS
RETURN 
(
	SELECT * 
	FROM LFBandas
)
GO

--Ejercicio 2
--Diseña una función que nos devuelva los datos de los músicos que han formado parte de una banda a lo largo de su historia. Las columnas serán Id,
--nombre artístico, años de antigüedad, meses y días. La antigüedad se calculará mediante la diferencia entre el momento en que el músico entró a
--formar parte de la banda y cuando la abandonó. Si todavía sigue en la misma, se considerará la antiguedad hasta la fecha actual. 
--Si un músico ha formado parte de la banda, la ha abndonado y luego ha vuelto se sumará la duración de todos los periodos en los que haya formado
--parte de la misma. El parámetro de entrada será el nombre de la banda.

--Ejercicio 3
--Algunas veces se organizan ediciones "revival" de un festival, en las que se programan las mismas bandas y las mismas canciones que una edición 
--anterior del mismo festival o de otro. Escribe un procedimeinto almacenado que "clone" una edición de un festival.
--Los datos de entrada serán el ID del festival y la fecha de inicio de la edición que queremos clonar y el ID del festival y la 
--fecha de inicio prevista para la nueva edición "revival". Todos los datos de esta ueva edición (duración, lema, etc) se copiaran del 
--que estamos replicando.

--Ejercicio 4
--Realiza una función que nos diga hasta qué punto una banda es fiel a sus estilos. Para ello, deberá contar cuantos temas de cada estilo 
--ha interpretado y dividirlos en dos bloques, los que pertenecen a alguno de los estilos de la banda y los que no. Luego se calculará 
--el porcentaje de temas que pertenecen a alguno de sus estilos respecto del total.

--Se contarán las interpretaciones, no los temas. Es decir, si un mismo tema se ha interpretado cinco veces contará como cinco, no como uno.

--El dato de entrada será el nombre de la banda y el de salida el índice de fidelidad, con un decimal.
--Última modificación: lunes, 5 de junio de 2017, 22:07
