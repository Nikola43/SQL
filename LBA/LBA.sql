CREATE DATABASE LeoBasketAssociation
GO
USE LeoBasketAssociation
GO

CREATE TABLE LBA_Paises
(
	-- Creacion de columnas
	ID Char(3) NOT NULL,
	Denominacion Varchar(25) NOT NULL,
	UE Bit NOT NULL,

	-- Creacion de claves PK y FK
	Constraint PK_LBA_Paises Primary Key (ID),
)

CREATE TABLE LBA_Jugadores
(
	-- Creacion columnas
	Licencia     Char(10)    NOT NULL,
	Nombre       VarChar(20) NOT NULL,
	Apellidos    VarChar(30) NOT NULL,
	FechaNac     DATE        NULL,
	Dorsal       TinyInt     NOT NULL,
	Posicion     Char(1)     NULL,
	Nacionalidad Char(3)     NULL,

	-- Creacion de claves PK y FK
	Constraint PK_LBA_Jugadores Primary Key (Licencia),
	Constraint FK_LBA_Jugadores_Paises Foreign Key (Nacionalidad)
	REFERENCES LBA_Paises (ID) ON UPDATE CASCADE ON DELETE CASCADE,

	-- Creacion de restricciones
	Constraint CK_RangoEdadJugadores CHECK ( YEAR(CURRENT_TIMESTAMP) - (YEAR(FechaNac)) BETWEEN 15 AND 50 ),
	Constraint CK_RangoDorsalJugadores CHECK ( Dorsal BETWEEN 0 AND 99 ),
	Constraint CK_RangoDorsalJugadores CHECK ( Posicion IN ('B', 'A', 'P', 'E', 'L') ),
)

CREATE TABLE LBA_Canchas
(
	-- Creacion de columnas
	ID TinyInt IDENTITY(1,1) NOT NULL,
	Denominacion Varchar(30) NOT NULL,
	Direccion    Varchar(30) NULL,
	Localidad    Varchar(25) NOT NULL,

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Canchas Primary Key (ID),
)

CREATE TABLE LBA_Equipos
(
	-- Creacion de columnas
	ID Char(3) NOT NULL,
	Nombre Varchar(30) NOT NULL,
	Fecha_Fundacion DATE NULL,
	Localidad Varchar(25) NOT NULL,
	ID_Cancha TinyInt NOT NULL

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Equipos Primary Key (ID),
	Constraint FK_LBA_Equipos_Canchas Foreign Key (ID_Cancha)
	REFERENCES LBA_Canchas(ID) ON UPDATE CASCADE ON DELETE CASCADE,
	
	-- Creacion de restricciones
	Constraint CK_Limite_Fecha_Fundacion CHECK ( Fecha_Fundacion < CURRENT_TIMESTAMP ),
)

CREATE TABLE LBA_Partidos
(
    -- Creacion de columnas
	ID SmallInt IDENTITY(1,1) NOT NULL,
	Fecha_Hora SmallDateTime NOT NULL,
	ID_Local Char(3) NOT NULL,
	ID_Visitante Char(3) NOT NULL,
	Puntos_Local TinyInt NULL,
	Puntos_Visitante TinyInt NULL,

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Partidos Primary Key (ID),

	Constraint FK_LBA_Partidos_Equipos Foreign Key (ID_Local)
	REFERENCES LBA_Equipos(ID) ON UPDATE CASCADE ON DELETE CASCADE,

	Constraint FK_LBA_Partidos_Equipos Foreign Key (ID_Visitante)
	REFERENCES LBA_Equipos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE LBA_Juega
(
	-- Creacion de columnas
	Licencia Char(10) NOT NULL,
	ID_Partido SmallInt NOT NULL,
	Minutos Int NULL,
	Tiros1 TinyInt NULL,
	Tiros2 TinyInt NULL,
	Tiros3 TinyInt NULL,
	Puntos1 TinyInt NULL,
	Puntos2 TinyInt NULL,
	Puntos3 TinyInt NULL,
	Personales TinyInt NULL,

	-- Creacion de claves PK y FK
	Constraint PK_LBA_Juega Primary Key (Licencia),

	-- Creacion de restricciones 
	Constraint CK_LimiteMinutosPartido CHECK ( Minutos BETWEEN 0 AND 40 ), 
	--Constraint CK_PuntosCorrespondientes CHECK (  ),
)
