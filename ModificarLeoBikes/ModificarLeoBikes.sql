/*
Deseamos una base de datos para una tienda de material para motociclistas llamada Leo Bikes con las siguientes especificaciones:
La tienda vende distintos productos. Cada producto se identifica por un c�digo y tiene un nombre. 
Deseamos saber cu�l es el stock disponible de cada producto (n�mero de unidades que tenemos) y su precio de venta. 
Tambi�n asignamos a cada producto un stock m�nimo, para saber cu�ndo hacer un pedido.
La tienda ofrece a sus clientes tarjetas de fidelizaci�n, con la que acumulan puntos en cada compra.
Cuando un cliente solicita dicha tarjeta se registran los siguientes datos: 
Documento identificativo (DI), nombre, apellidos, localidad en la que vive, descuento asignado y saldo de puntos.
Los clientes con tarjeta pueden hacernos encargos, que se registrar�n como pedidos. 
Cada pedido tendr� un identificador que le ser� asignado autom�ticamente por el sistema. 
Queremos saber en qu� fecha y hora se realiza el pedido y la fecha y hora en que se env�an los productos al cliente.
El producto constar� de uno o m�s productos, teniendo que quedar registrado la cantidad de cada producto y el precio de venta.
Cuando se realiza una venta se genera una factura, que contendr� los mismos datos del pedido,
s�lo que en lugar de la fecha en que se sirve anotaremos la fecha de cobro. Adem�s, la factura tendr� un importe total. 
Si la factura est� a nombre de un cliente registrado, se relacionar� con �l.
Se pide un script en T-SQL que cree la base de datos en 3FN de acuerdo a los requisitos anteriores.
*/

USE LeoBikes
-- a. Crea una nueva tabla LB_Avisos, para registrar los productos que est�n por debajo de su stock m�nimo. 
-- Los datos a guardar ser�n el ID del producto, la fecha en que se cre� el aviso, el stock m�nimo y el stock actual.
CREATE TABLE LB_Avisos 
(
	-- Crear columnas
	ID_Producto Char(5) NOT NULL,
	Fecha_Aviso Date NOT NULL,
	StockActual SmallInt NULL,
	StockMinimo TinyInt NULL,

	-- Claves PK Y FK
	-- PK de la tabla
	Constraint PK_Avisos Primary Key (ID_Producto),

	-- FK Productos
	Constraint FK_Avisos_Productos_Producto Foreign Key (ID_Producto) 
	REFERENCES LB_Productos(Codigo) ON DELETE CASCADE ON UPDATE CASCADE,
)

-- b. Sobre la tabla LB_Productos a�ade un valor por defecto a las columnas Stock_Actual (0) y Stock_Minimo (0).
	-- Establecer stock por defecto
	ALTER TABLE LB_Productos ADD CONSTRAINT DF_Stock_Actual DEFAULT '0' FOR Stock_Actual
	ALTER TABLE LB_Productos ADD CONSTRAINT DF_Stock_Minimo DEFAULT '0' FOR Stock_Minimo

-- c. A�ade un valor por defecto a la columna SaldoPuntos de la tabla LB_Clientes con valor 0. A��dele tambi�n una restricci�n para que su valor no pueda ser inferior a cero.
	-- Establecer 0 por defecto
	ALTER TABLE LB_Clientes ADD CONSTRAINT DF_SaldoPuntos DEFAULT '0' FOR SaldoPuntos

	-- Restriccion SaldoPuntos > 0
	ALTER TABLE LB_Clientes WITH NOCHECK
	ADD CONSTRAINT CK_SaldoPuntosNoNegativo CHECK (SaldoPuntos > 0)

--d. En la tabla LB_Avisos, a�ade un valor por defecto a la columna Fecha_Crea que sea la fecha actual. 
--A�ade una columna Fecha_Actualiza del mismo tipo que Fecha_Crea, pero que s� admita valores nulos. 
--Esta nueva columna tendr� el mismo valor por defecto.

	-- Establecer fecha por defecto
	ALTER TABLE LB_Avisos ADD CONSTRAINT DF_Fecha_Aviso DEFAULT '0' FOR Fecha_Aviso

	-- a�adir columna Fecha_Actualizada
	ALTER TABLE LB_Avisos 
	ADD Fecha_Actualizada SmallDateTime NULL

	-- Establecer por defecto Fecha_Actualizada
	ALTER TABLE LB_Avisos ADD CONSTRAINT DF_Fecha_Actualizada DEFAULT '0' FOR Fecha_Actualizada

-- e. En la misma tabla, a�ade una restricci�n llamada FK_Avisos_Productos que la relacione con LB_Productos. 
--Las columnas a relacionar ser�n Cod_Producto en LB_Avisos y Codigo en LB_Productos. 
--Tanto la actualizaci�n como el borrado se propagar�n en cascada.

	-- Crear FK_Avisos_Productos
	ALTER TABLE LB_Avisos 
	ADD Constraint FK_Avisos_Productos Foreign Key (ID_Producto)
	REFERENCES LB_Productos (Codigo) ON DELETE NO ACTION ON UPDATE NO ACTION

-- f. En la misma tabla a�ade una restricci�n para que el valor de la nueva columna Fecha_Actualiza, 
-- si no es nulo, sea superior a Fecha_Crea.
	-- Crear check fecha actualizada
	ALTER TABLE LB_Avisos WITH NOCHECK
	ADD CONSTRAINT CK_Fecha_ActualizaPosteriorFecha_Crea CHECK (Fecha_Actualizada < Fecha_Aviso)

--g. A�ade una restricci�n a la tabla LB_Clientes para asegurar que el valor de la columna Descuento est� entre 0 y 50.
	-- Crear restriccion descuento entre 0 y 50
	ALTER TABLE LB_Clientes WITH NOCHECK
	ADD Constraint CK_DescuentoEntre0_50 CHECK (Descuento BETWEEN 0 AND 50)

--h. A�ade una columna calculada a la tabla LB_Productos llamada Margen que contenga la diferencia entre Stock_Actual y Stock_Minimo.
	-- Crear columna calculada
	ALTER TABLE LB_Productos 
	ADD [Margen de diferencia Stock Actual y Stock Minimo] AS Stock_Actual - Stock_Minimo