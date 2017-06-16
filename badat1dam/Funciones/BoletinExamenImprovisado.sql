-- Boletín personalizado LeoFest

/*
1. Tras su fracaso en Eurovisión, Manel Navarro, representante de España, ha decidido montar un grupo junto a 3 surfistas más, apodados
"Los gallos de Playa", de género "Pop surfero". Crea un procedimiento LF_anadirBandaEstilo cuyos parámetros sean el nombre de la banda,
la fecha de formación y la fecha de disolución (opcionales) y el estilo. El estilo se registrará si no lo está ya en la base de datos.
Si la fecha de formación no es especificada, se tomará la fecha y hora del sistema. 
*/

CREATE PROCEDURE LF_anadirBandaEstilo
@NombreBanda varchar(50),
@FechaFormacion date,
@FechaDisolucion date,
@Estilo varchar(30)
AS
	-- Comprobamos que el estilo que le hemos pasado por parámetros exista, si no existe lo crea.
	IF (SELECT ID FROM LFEstilos WHERE Estilo=@Estilo) IS NULL
		BEGIN
			INSERT INTO LFEstilos (ID, Estilo)
			VALUES
			(NEWID(), @Estilo)
		END


GO

select * from LFEstilos