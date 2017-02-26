USE CasinOnLine

-- 1 Escribe una consulta que nos devuelva el numero de veces que se ha apostado a
-- cada numero con apuestas de los tipos 10,13 o 15. Ordena el resultado de mayor a menos popularidad
SELECT COUNT(A.IDJugada) AS [Numero De Apuestas], NA.Numero AS [Numero Apostado], A.Tipo
FROM COL_Apuestas AS A
JOIN COL_NumerosApuesta AS NA ON A.IDJugada = NA.IDJugada
WHERE A.Tipo IN ('10', '13', '15')
GROUP BY A.IDJugada, NA.Numero, A.Tipo
ORDER BY [Numero De Apuestas] DESC

-- SELECT Tipo FROM COL_Apuestas (SOLO HAY TIPO 8 ??)
--------------------------------------------------------------------------------------------------------------------




-- 2 El casino quiere fomentar la participacion y decide regalar saldo extra a los jugadores 
-- que hayan apostado mas de 3 veces en el ultimo mes. Se considera el mes de febrero
-- La cantidad que se les regalará sera un 5% del total que hayan apostado en ese mes
SELECT CJ.Nombre, CJ.Apellidos, CJ.Nick, COUNT(J.IDJugada) AS [Numero De Apuestas]
FROM COL_Jugadores AS CJ
JOIN COL_NumerosApuesta AS NA ON CJ.ID = NA.IDJugador
JOIN COL_Jugadas AS J ON NA.IDJugada = J.IDJugada
WHERE MONTH(J.MomentoJuega) LIKE '1'
GROUP BY CJ.Nombre, CJ.Apellidos, CJ.Nick, J.IDJugada
--------------------------------------------------------------------------------------------------------


-- 3 El dia 2 de febrero se celebró el dia de la marmota. Para Conmemorarlo, el casino ha decidido
-- volver a repetir todas las jugadas que se hicieron ese dia, pero poniendoles fecha de mañana(Con la misma hora)
-- y permitiendo que los jugadores apuesten. El numero ganador de cada jugada se pondra a null y el novamas a 0

-- 4 Crear una vista que nos muestre, para cada jugador, nombre, apellidos, Nick, numero de apuestas realizadas
-- total de dinero apostado y total de dinero
GO

CREATE VIEW VJugadores AS
SELECT DISTINCT CJ.Nombre, CJ.Apellidos, CJ.Nick, SUM(A.Importe) AS [Total Dinero Apostado], COUNT(A.IDJugada) AS [Numero De Apuestas], CJ.Saldo
FROM COL_Jugadores AS CJ
JOIN COL_Apuestas AS A ON CJ.ID = A.IDJugador
GROUP BY A.IDJugada, CJ.Nombre, CJ.Apellidos, CJ.Nick, A.Importe, A.IDJugada, CJ.Saldo
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------



-- 5 Nos comunican que la policia ha detenido a nuestro cliente Ombligo Pato por delitos de estada, falsedad, 
-- administracion desleal, y mal gusto para comprar bañadores
-- Dado que nuestro casino esta en Gibraltar, siguiendo la tradicion de estas tierras
-- Queremos borrar todo nuestro rastro a su paso por el casino
-- Borra todas las apuestas que haya realizado, pero no busques su ID a mano en la tabla COL_Clientes.
-- Utiliza su nick(bankiaman) para identificarlo en la instruccion DELETE
BEGIN TRANSACTION
DELETE FROM COL_NumerosApuesta
	WHERE Numero in
	(
		SELECT DISTINCT NA.Numero AS [Numero Apostado], CJ.Nick
		FROM COL_Jugadores AS CJ
		JOIN COL_Apuestas AS CA ON CJ.ID = CA.IDJugador
		JOIN COL_NumerosApuesta AS NA ON CA.IDJugador = NA.IDJugador
		WHERE CJ.Nick IN ('bankiaman')
		GROUP BY NA.Numero, CJ.Nick
	)

ROLLBACK TRANSACTION
--------------------------------------------------------------------------------------------------------------------------

