USE Northwind

/* 1. Deseamos incluir un producto en la tabla Products llamado "Cruzcampo lata” pero no estamos seguros si se ha insertado o no.
El precio son 4,40, el proveedor es el 16, la categoría 1 y la cantidad por unidad es "Pack 6 latas” "Discontinued” toma el valor 0 y
el resto de columnas se dejarán a NULL. Escribe un script que compruebe si existe un producto con ese nombre.
En caso afirmativo, actualizará el precio y en caso negativo insertarlo. */

GO
DECLARE @idProducto INT
SELECT @idProducto = (SELECT ProductID FROM Products WHERE ProductName = 'Cruzcampo lata')

IF @idProducto IS NOT NULL
    BEGIN
        PRINT 'Ese producto ya existe en la base de datos, procederemos a actualizar su precio'
        UPDATE Products
            SET UnitPrice = 4.40
        WHERE ProductName = 'Cruzcampo lata'
    END
ELSE
    BEGIN
        PRINT 'Ese producto no existe en la base de datos, procedemos a insertarlo'
        BEGIN TRANSACTION
            INSERT INTO Products
            VALUES ('Cruzcampo lata', 16, 1, 'Pack 6 latas', 4.3, 7, NULL, NULL,NULL)
        COMMIT TRANSACTION
    END

SELECT * FROM Products
    WHERE ProductName = 'Cruzcampo lata'

/* 2. Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID, el Nombre,
      el Precio unitario, el número total de unidades vendidas y el total de dinero facturado con ese producto.
      Si no existe, créala*/

    IF (SELECT dbo.comprobarSiTablaExiste('Productsdfdfdfs') = 1)
        BEGIN
            PRINT 'existe'
        END
    ELSE
        BEGIN
            PRINT 'No existe'
        END

/* 3. Comprueba si existe una tabla llamada ShipShip. Esta tabla ha de tener de cada Transportista el ID,
      el Nombre de la compañía, el número total de envíos que ha efectuado y el número de países diferentes
      a los que ha llevado cosas. Si no existe, créala */

/* 4. Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID,
      el Nombre completo, el número de ventas totales que ha realizado, el número de clientes diferentes a los
      que ha vendido y el total de dinero facturado. Si no existe, créala */

/* 5. Entre los años 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido.
      Queremos cambiar el precio unitario según la siguiente tabla:

        Incremento de ventas    Incremento de precio
      * Negativo         -      -10%
      * Entre 0 y 10%    -      No varía
      * Entre 10% y 50%  -      +5%
      * Mayor del 50%    -      10% con un máximo de 2,25
*/

GO
CREATE FUNCTION dbo.comprobarSiTablaExiste(@nombreTabla NVARCHAR(20))
    RETURNS Bit
    BEGIN
        DECLARE @existe Bit
        IF OBJECT_ID (@nombreTabla) IS NOT NULL
            SET @existe = 1;
        ELSE
            SET @existe = 0;
        RETURN @existe
    END
GO