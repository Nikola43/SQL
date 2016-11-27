/*
Deseamos una base de datos para una tienda de material para motociclistas llamada Leo Bikes con las siguientes especificaciones:
La tienda vende distintos productos. Cada producto se identifica por un código y tiene un nombre. 
Deseamos saber cuál es el stock disponible de cada producto (número de unidades que tenemos) y su precio de venta. 
También asignamos a cada producto un stock mínimo, para saber cuándo hacer un pedido.
La tienda ofrece a sus clientes tarjetas de fidelización, con la que acumulan puntos en cada compra.
Cuando un cliente solicita dicha tarjeta se registran los siguientes datos: 
Documento identificativo (DI), nombre, apellidos, localidad en la que vive, descuento asignado y saldo de puntos.
Los clientes con tarjeta pueden hacernos encargos, que se registrarán como pedidos. 
Cada pedido tendrá un identificador que le será asignado automáticamente por el sistema. 
Queremos saber en qué fecha y hora se realiza el pedido y la fecha y hora en que se envían los productos al cliente.
El producto constará de uno o más productos, teniendo que quedar registrado la cantidad de cada producto y el precio de venta.
Cuando se realiza una venta se genera una factura, que contendrá los mismos datos del pedido,
sólo que en lugar de la fecha en que se sirve anotaremos la fecha de cobro. Además, la factura tendrá un importe total. 
Si la factura está a nombre de un cliente registrado, se relacionará con él.
Se pide un script en T-SQL que cree la base de datos en 3FN de acuerdo a los requisitos anteriores.
*/

USE LeoBikes
-- a. Crea una nueva tabla LB_Avisos, para registrar los productos que están por debajo de su stock mínimo. 
-- Los datos a guardar serán el ID del producto, la fecha en que se creó el aviso, el stock mínimo y el stock actual.
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

-- b. Sobre la tabla LB_Productos añade un valor por defecto a las columnas Stock_Actual (0) y Stock_Minimo (0).
	-- Establecer stock por defecto
	ALTER TABLE LB_Productos ADD CONSTRAINT DF_Stock_Actual DEFAULT '0' FOR Stock_Actual
	ALTER TABLE LB_Productos ADD CONSTRAINT DF_Stock_Minimo DEFAULT '0' FOR Stock_Minimo

-- c. Añade un valor por defecto a la columna SaldoPuntos de la tabla LB_Clientes con valor 0. Añádele también una restricción para que su valor no pueda ser inferior a cero.
	-- Establecer 0 por defecto
	ALTER TABLE LB_Clientes ADD CONSTRAINT DF_SaldoPuntos DEFAULT '0' FOR SaldoPuntos

	-- Restriccion SaldoPuntos > 0
	ALTER TABLE LB_Clientes WITH NOCHECK
	ADD CONSTRAINT CK_SaldoPuntosNoNegativo CHECK (SaldoPuntos > 0)

--d. En la tabla LB_Avisos, añade un valor por defecto a la columna Fecha_Crea que sea la fecha actual. 
--Añade una columna Fecha_Actualiza del mismo tipo que Fecha_Crea, pero que sí admita valores nulos. 
--Esta nueva columna tendrá el mismo valor por defecto.

	-- Establecer fecha por defecto
	ALTER TABLE LB_Avisos ADD CONSTRAINT DF_Fecha_Aviso DEFAULT '0' FOR Fecha_Aviso

	-- añadir columna Fecha_Actualizada
	ALTER TABLE LB_Avisos 
	ADD Fecha_Actualizada SmallDateTime NULL

	-- Establecer por defecto Fecha_Actualizada
	ALTER TABLE LB_Avisos ADD CONSTRAINT DF_Fecha_Actualizada DEFAULT '0' FOR Fecha_Actualizada

-- e. En la misma tabla, añade una restricción llamada FK_Avisos_Productos que la relacione con LB_Productos. 
--Las columnas a relacionar serán Cod_Producto en LB_Avisos y Codigo en LB_Productos. 
--Tanto la actualización como el borrado se propagarán en cascada.

	-- Crear FK_Avisos_Productos
	ALTER TABLE LB_Avisos 
	ADD Constraint FK_Avisos_Productos Foreign Key (ID_Producto)
	REFERENCES LB_Productos (Codigo) ON DELETE NO ACTION ON UPDATE NO ACTION

-- f. En la misma tabla añade una restricción para que el valor de la nueva columna Fecha_Actualiza, 
-- si no es nulo, sea superior a Fecha_Crea.
	-- Crear check fecha actualizada
	ALTER TABLE LB_Avisos WITH NOCHECK
	ADD CONSTRAINT CK_Fecha_ActualizaPosteriorFecha_Crea CHECK (Fecha_Actualizada < Fecha_Aviso)

--g. Añade una restricción a la tabla LB_Clientes para asegurar que el valor de la columna Descuento está entre 0 y 50.
	-- Crear restriccion descuento entre 0 y 50
	ALTER TABLE LB_Clientes WITH NOCHECK
	ADD Constraint CK_DescuentoEntre0_50 CHECK (Descuento BETWEEN 0 AND 50)

--h. Añade una columna calculada a la tabla LB_Productos llamada Margen que contenga la diferencia entre Stock_Actual y Stock_Minimo.
	-- Crear columna calculada
	ALTER TABLE LB_Productos 
	ADD [Margen de diferencia Stock Actual y Stock Minimo] AS Stock_Actual - Stock_Minimo