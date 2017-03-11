USE LeoMetro
GO

DECLARE @idPasajero TINYINT
SET @idPasajero = 100

SELECT *
FROM LM_Recorridos
WHERE @idPasajero = Tren

