--Examen Paulo Gustavo Soares Teixeira
USE LeoMetro
SET Dateformat 'ymd'
Go


BEGIN TRANSACTION

DECLARE @idTren int
DECLARE @matricula char(4)

SET @idTren = '223'
SET @matricula = '3294GPT'
-- 2. Inserta un nuevo tren


  INSERT INTO LM_Trenes (ID, Matricula, Tipo, Capacidad, FechaEntraServicio)
  VALUES (@idTren, @matricula, 2, 65, CURRENT_TIMESTAMP) -- Insertamos un nuevo tren con fecha de hoy

COMMIT TRANSACTION -- ROLLBACK TRANSACTION

-- Comprobamos que se ha insertado el tren correctamente con la fecha de hoy
SELECT *
FROM LM_Trenes
WHERE ID = '220'
------------------------------------------------------------------------------------------------------------------------
