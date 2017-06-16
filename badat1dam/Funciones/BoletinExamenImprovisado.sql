-- Bolet�n personalizado LeoFest

/*
1. Tras su fracaso en Eurovisi�n, Manel Navarro, representante de Espa�a, ha decidido montar un grupo junto a 3 surfistas m�s, apodados
"Los gallos de Playa", de g�nero "Pop surfero". Crea un procedimiento LF_anadirBandaEstilo cuyos par�metros sean el nombre de la banda,
la fecha de formaci�n y la fecha de disoluci�n (opcionales) y el estilo. El estilo se registrar� si no lo est� ya en la base de datos.
Si la fecha de formaci�n no es especificada, se tomar� la fecha y hora del sistema. 
*/

CREATE PROCEDURE LF_anadirBandaEstilo
@NombreBanda varchar(50),
@FechaFormacion date,
@FechaDisolucion date,
@Estilo varchar(30)
AS
	-- Comprobamos que el estilo que le hemos pasado por par�metros exista, si no existe lo crea.
	IF (SELECT ID FROM LFEstilos WHERE Estilo=@Estilo) IS NULL
		BEGIN
			INSERT INTO LFEstilos (ID, Estilo)
			VALUES
			(NEWID(), @Estilo)
		END


GO

select * from LFEstilos