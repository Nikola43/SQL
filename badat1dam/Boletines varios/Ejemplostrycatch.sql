BEGIN TRY  
    -- Generamos un error de división entre 0.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS NumeroError  
        ,ERROR_SEVERITY() AS Gravedad  
        ,ERROR_STATE() AS Estado 
        ,ERROR_LINE() AS Linea  
        ,ERROR_MESSAGE() AS Mensaje;  
END CATCH
GO  

BEGIN TRY
	DECLARE @Edad int
	SET @Edad = 'veinte'
	print @Edad 
END TRY
BEGIN CATCH
	PRINT 'Error al leer la edad'
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
END CATCH
GO

USE Northwind
GO

select * from products 

BEGIN TRY
	DELETE FROM Products
	WHERE ProductID='100tobente'
END TRY
BEGIN CATCH
	PRINT 'No existe ningun producto con ese ID'
	PRINT ERROR_MESSAGE()
END CATCH