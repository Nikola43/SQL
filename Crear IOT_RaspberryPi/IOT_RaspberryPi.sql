CREATE DATABASE IOT_RaspberryPI
GO
USE IOT_RaspberryPI
GO



-- Tabla que guardara los diferentes sistemas que esten funcionando
CREATE TABLE IOTRP_Sistemas
(
	 ID SmallInt NOT NULL
	,Estado VarChar(40) NOT NULL
	,Fecha DATE
	,Hora TIME
	,Constraint PK_IOTRP_Sistemas Primary Key (ID) -- Establecemos el atributo ID como primary key
)
GO
	
-- Tabla que guardara los diferentes eventos que ocurren en un sistema
CREATE TABLE IOTRP_Eventos
(
	 ID SmallInt NOT NULL
	,ID_Sistemas SmallInt NOT NULL
	,Fecha DATE
	,Hora TIME
	,Constraint PK_IOTRP_Eventos Primary Key (ID) -- Establecemos el atributo ID como primary key
	,Constraint FK_Eventos_Sistemas Foreign Key (ID_Sistemas) 
	 REFERENCES IOTRP_Sistemas (ID) ON UPDATE CASCADE ON DELETE NO ACTION
	 -- Establecemos la id del sistema como fk de la tabla eventos
)
GO

-- Tabla que guardara las diferentes acciones que puede realizar el sistema
CREATE TABLE IOTRP_Acciones
(
	 ID SmallInt NOT NULL
	,ID_Evento SmallInt NOT NULL
	,Tipo VarChar(40) NOT NULL
	,Motivo VarChar(40) NOT NULL
	,Estado VarChar(40) NOT NULL
	,Constraint PK_IOTRP_Acciones Primary Key (ID)
	,Constraint FK_Eventos_Acciones Foreign Key (ID_Evento) REFERENCES IOTRP_Eventos (ID) 
) 
GO

CREATE TABLE IOTRP_Medidas
(
	 ID SmallInt NOT NULL
	,ID_Evento SmallInt NOT NULL
	,Valor Int NOT NULL
	,Unidad VarChar(40)
	,Constraint PK_IOTRP_Medidas Primary Key (ID)
	,Constraint FK_Eventos_Medidas Foreign Key (ID_Evento) REFERENCES IOTRP_Eventos (ID) 
) 
GO

-- Tabla que guardara los diferentes sensores que hay en el sistema
CREATE TABLE IOTRP_Sensores
(
	 ID SmallInt NOT NULL
	,ID_Medida SmallInt NOT NULL
	,Valor Int NOT NULL
	,Marca VarChar(40)
	,Modelo VarChar(40)
	,Rango VarChar(40)
	,Tipo VarChar(40)
	,Constraint PK_IOTRP_Sensores Primary Key (ID)
	,Constraint FK_Sensores_Medidas Foreign Key (ID_Medida) REFERENCES IOTRP_Medidas (ID)
) 
GO