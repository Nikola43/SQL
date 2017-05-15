CREATE DATABASE LeoFest
GO
USE LeoFest
GO
-- Artistas 
CREATE TABLE LFMusicos (
	ID Int NOT NULL,
	Nombre VarChar(20) NOT NULL,
	Apellidos VarChar(30) NOT NULL,
	NombreArtistico VarChar(50) NULL,
	Direccion VarChar(50) NULL,
	Ciudad VarChar(20) NULL,
	Telefono1 Char(9) NULL,
	Telefono2 Char(9) NULL,
 CONSTRAINT PKMusicos PRIMARY KEY (ID)
)

-- Estilos
CREATE TABLE LFEstilos(
	ID SmallInt Not NULL,
	Estilo VarChar (30) Not NULL,
	CONSTRAINT PKEstilos Primary Key (ID) 
)
-- Bandas
CREATE TABLE LFBandas(
	ID SmallInt Not NULL Identity(1,1),
	NombreBanda VarChar(50) Not NULL,
	FechaFormacion Date NULL,
	FechaDisolucion DATE NULL,
	CONSTRAINT PKBandas Primary Key (ID) 
)
-- Festivales
CREATE TABLE LFFestivales(
	ID Int Not NULL Identity(1,1),
	Denominacion VarChar(55) Not NULL,
	Comentarios VarChar(800) NULL,
	CONSTRAINT PKFestivales Primary Key (ID) 
)
GO
-- Ediciones. Entidad débil de Festivales. Dependencia en identificación
CREATE TABLE LFEdiciones(
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	Lema VarChar(300) NULL,
	Lugar VarChar(40) NULL,
	Ciudad VarChar(45) Not NULL,
	ComunidadAutonoma VarChar(30) Not NULL,
	FechaHoraInicio SmallDateTime NULL,
	FechaHoraFin SmallDateTime NULL,
	CONSTRAINT PKEdiciones Primary Key (IDFestival, Ordinal),
	CONSTRAINT FKEdicionesFestivales Foreign Key (IDFestival) REFERENCES LFFestivales (ID) On Update CASCADE On Delete CASCADE,
	CONSTRAINT CKTiempo CHECK (FechaHoraInicio < FechaHoraFin)
)
-- Temas
CREATE TABLE LFTemas(
	ID UniqueIdentifier Not NULL,
	Titulo VarChar(120),
	IDAutor Int,
	IDEstilo SmallInt Not NULL,
	Duracion Time NULL,
	CONSTRAINT PKTemas Primary Key (ID),
	CONSTRAINT FKTemasAutores FOREIGN KEY (IDAutor) REFERENCES LFMusicos(ID) On Delete No Action On Update CASCADE,
	CONSTRAINT FKTemasEstilos Foreign Key (IDEstilo) REFERENCES LFEstilos (ID)
)
-- Relación NM entre Bandas y Estilos
CREATE TABLE LFBandasEstilos (
	IDBanda SmallInt Not NULL,
	IDEstilo SmallInt Not NULL,
	CONSTRAINT PKBandasEstilos Primary Key (IDBanda,IDEstilo),
	CONSTRAINT FKBandasEstilosBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKBandasEstilosEstilos Foreign Key (IDEstilo) REFERENCES LFEstilos (ID)
)
-- Relación NM entre bandas y Musicos
CREATE TABLE LFMusicosBandas(
	ID UniqueIdentifier Not NULL,
	IDBanda SmallInt Not NULL,
	IDMusico Int Not NULL,
	FechaIncorporacion Date NULL,
	FechaAbandono Date NULL,
	CONSTRAINT PKMusicosBandas PRIMARY KEY (ID),
	CONSTRAINT FKMusicosBandasBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKMusicosBandasMusicos FOREIGN KEY (IDMusico) REFERENCES LFMusicos(ID)
)
-- Bandas que han participado en cada edición
CREATE TABLE LFBandasEdiciones(
	IDBanda SmallInt Not NULL,
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	Categoria TinyInt,
	CONSTRAINT PKBandasEdiciones Primary Key (IDBanda,IDFestival,Ordinal),
	CONSTRAINT FKBandasEdicionesBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKBandasEdicionesEdiciones Foreign Key (IDFestival, Ordinal) REFERENCES LFEdiciones (IDFestival, Ordinal)
)
-- Temas que ha interpretado cada banda en cada edición. Relación ternaria
CREATE TABLE LFTemasBandasEdiciones(
	IDBanda SmallInt Not NULL,
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	IDTema UniqueIdentifier Not NULL,
	Momento SmallDateTime NULL,
	CONSTRAINT PKTemasBandasEdiciones Primary Key (IDBanda,IDFestival,Ordinal,IDTema),
	CONSTRAINT FKTemasBandasEdicionesBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKTemasBandasEdicionesEdiciones Foreign Key (IDFestival, Ordinal) REFERENCES LFEdiciones (IDFestival, Ordinal) On Update No Action On Delete No Action,
	CONSTRAINT FKTemasBandasEdicionesTemas Foreign Key (IDTema) REFERENCES LFTemas (ID)
)

GO
INSERT INTO LFEstilos (ID,Estilo) VALUES (1,'Pop'), (2,'Rock'), (3,'Música electrónica'), (4,'Flamenco'), (5,'Ska'), (6,'Hip-Hop'), (7,'Funky'), (8,'Jazz'), (9,'Latina')
INSERT INTO LFEstilos (ID,Estilo) VALUES (10,'Soul'), (11,'Blues'), (12,'Punk'), (13,'Melódica'), (14,'Folk'), (15,'Cantautor'), (16,'Reggae'), (17,'Heavy Metal'), (18,'Reggaeton'), (19,'Hard Rock')
INSERT INTO LFEstilos (ID,Estilo) VALUES (20,'Baladas'), (21,'Thrash Metal'), (22,'Techno'), (23,'Grunge'), (24,'House'), (25,'Rithm & Blues'), (26,'Country'), (27,'Tango'), (28,'Rap'), (29,'Chill out')
GO
-- Musicos

GO
-- Temas
INSERT INTO LFTemas (ID,Titulo,IDAutor,IDEstilo,Duracion)
     VALUES (NewId(),'El melón volador',1,20,TIMEFROMPARTS(0,3,15,0,0))
GO



GO
USE AirLeo