CREATE DATABASE LeoBikes
GO
USE LeoBikes
GO

CREATE TABLE Productos
(
	codigo char(5) not null constraint PK_Productos primary key
  , nombre varchar(40) not null default 'Producto Generico'
  , stock_minimo tinyint
  , stock_disponible smallint
  , precio smallmoney
 --	codigo char(5) not null
 -- constraint PK_Productos primary key (codigo 
);
GO

CREATE TABLE Clientes
(
	id char(10) not null constraint PK_Clientes primary key
  ,	apellidos varchar(25) not null
  , nombre varchar(15) not null
  , localidad varchar(15) not null
  , descuento tinyint default '0'
  , saldo_puntos smallint not null
);
GO


CREATE TABLE Facturas
(
	id char(5) not null identity primary key
  ,	di_cliente char(10) default '00000001'
  , importe_total smallmoney
  , fecha_hora_pedido smalldatetime not null default CURRENT_TIMESTAMP
  , fecha_cobro  date
  , importe money
  , 
);



