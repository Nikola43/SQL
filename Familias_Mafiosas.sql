-- Examen 02/12/2016 Paulo Gustavo Soares Teixeira
-------------------------------------------------- 1. CREAR TABLAS --------------------------------------------------
/*
Tablas	             Atributos

Dones:               ID (PK), Nombre, Apellidos, Apodo, Fecha_Nacimiento, Procedencia, Fecha_Nombramiento,  Nombre_Famiglia(FK Famiglias unique)
Consiglieres:        Nombre(PK), Apellidos, Apodo, Fecha_Nacimiento, Procedencia, Titulacion, ID_Don(FK Dones)
Negocios:            ID(PK), Denominacion, IlegalSN
Territorios:         ID(PK), Ciudad, Barrio
Famiglias:           Nombre(PK), Procedencia, Familia_Protectora
Capos_Regime_Decime: ID(PK), Nombre, Apellidos, Apodo, Fecha_Nacimiento, Procedencia, Nombre_Famiglia(FK Famiglias), Tipo_Capo, Porcentaje_Comision, Sueldo, Fecha_Contratacion
Soldatos:      	     ID(PK), Nombre, Apellidos, Apodo, Fecha_Nacimiento, Procedencia, Tatuaje_Principal, ID_Capo (FK Capos)
Lugartenientes:      ID(PK), Nombre, Apellidos, Apodo, ID_Capo (FK Capos)
Tecnicas_Persuacion: ID(PK), Denominacion
Armas: 		         ID(PK), Denominacion, LegalSN, LicenciaSN
Armas_Blanca:        Longitud_Hoja, Tipo_Filo, RetractilSN, ID_Arma(PK) (FK Arma)
Armas_Fuego:         Marca, Modelo, Calibre, Capacidad_Proyectiles, ID_Arma(PK) (FK Arma)


Relaciones
Famiglias_Territorios_Negocios : Nombre_Famiglia, ID_Territorio, ID_Negocio (PK compuesta por las PK de las tablas que relaciona)

Famiglias_Protegidas : ID_FamigliaProtectora, ID_FamigliaProtegida (PK compuesta por las PK de las tablas que relaciona)

Capos_Tecnicas_Pensuacion : ID_Capo, ID_Tecnica_Persuacion (PK compuesta por las PK de las tablas que relaciona)

Soldatos_Armas : ID_Soltado, ID_Arma, Destreza (PK compuesta por las PK de las tablas que relaciona)
*/

-------------------------------------------------- 2. Pasar tablas a codigo SQL --------------------------------------------------

-- Creamos la base de datos
CREATE DATABASE Familias_Mafiosas
Go
-- Usamos la base de datos que acabamos de crear
USE Familias_Mafiosas
Go

------------ NEGOCIOS ------------
CREATE TABLE FM_Negocios
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Denominacion nVarChar(15) NULL,
	IlegalSN Char (1) NULL, -- Solo admitira 'S' o 'N'

	-- Creacion de la PK
	Constraint PK_Negocios Primary Key (ID), -- PK De la tabla
)
Go 

------------ TERRITORIOS ------------
CREATE TABLE FM_Territorios
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Ciudad nVarChar(15) NULL,
	Barrio nVarChar(15) NULL,

	-- Creacion de la PK
	Constraint PK_Territorios Primary Key (ID), -- PK De la tabla
)
Go

------------ FAMIGLIAS ------------
CREATE TABLE FM_Famiglias
(
	-- Creacion de las columnas de la tabla
	Nombre nVarChar(15) NOT NULL,
	Procedencia nVarChar(15) NULL,
	Familia_Protectora nVarChar(15) NULL,

	-- Creacion de las PK
	Constraint PK_Famiglias Primary Key (Nombre), -- PK De la tabla
	Constraint FK_Famiglias_Famiglias Foreign Key (Familia_Protectora) References FM_Famiglias 
	ON UPDATE NO ACTION ON DELETE NO ACTION -- FK Famiglias (Familia que proteje a esta familia)
)
Go

------------ DONES ------------
CREATE TABLE FM_Dones
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Nombre nVarChar(15) NULL,
	Apellidos nVarChar(15) NULL,
	Apodo nVarChar(15) NULL,
	Fecha_Nacimiento Date NULL,
	Procedencia nVarChar(15) NULL,
	Fecha_Nombramiento Date,
	Nombre_Famiglia nVarChar(15) NULL,

	-- Creacion de las PK Y FK
	Constraint PK_Dones Primary Key (ID), -- PK De la tabla
	Constraint FK_Dones_Famiglias Foreign Key (Nombre_Famiglia) References FM_Famiglias, -- FK Famiglias
)
Go

------------ CONSIGLIERE ------------
CREATE TABLE FM_Consiglieres
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Nombre nVarChar(15) NULL,
	Apellidos nVarChar(15) NULL,
	Apodo nVarChar(15) NULL,
	Fecha_Nacimiento Date NULL,
	Procedencia nVarChar(15) NULL,
	Titulacion nVarChar(15) NULL,
	ID_Don Int NULL,

	-- Creacion de las PK Y FK
	Constraint PK_Consiglieres Primary Key (ID), -- PK De la tabla
	Constraint FK_Consiglieres_Dones Foreign Key (ID_Don) References FM_Dones 
	ON UPDATE CASCADE ON DELETE CASCADE -- FK Dones
)
Go

------------ CAPOS_RECIME_DECIME ------------
CREATE TABLE FM_Capos_Regime_Decime
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Nombre nVarChar(15) NULL,
	Apellidos nVarChar(15) NULL,
	Apodo nVarChar(15) NULL,
	Fecha_Nacimiento Date NULL,
	Procedencia nVarChar(15) NULL,
	Nombre_Famiglia nVarChar(15) NULL,
	Tipo_Capo Char(1) NULL, -- El tipo sera 'R' o 'D'
	Porcentaje_Comision Int NULL,
	Sueldo Int NULL,
	Fecha_Contratacion DATE NULL,

	-- Creacion de la PK
	Constraint PK_Capos_Regime_Decime Primary Key (ID), -- PK De la tabla
)
Go

------------ SOLDATOS ------------
CREATE TABLE FM_Soldatos
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Nombre nVarChar(15) NULL,
	Apellidos nVarChar(15) NULL,
	Apodo nVarChar(15) NULL,
	Fecha_Nacimiento Date NULL,
	Procedencia nVarChar(15) NULL,
	Tatuaje_Principal nVarChar(15) NULL,
	ID_Capo Int NULL,

	-- Creacion de las PK y FK
	Constraint PK_Soldatos Primary Key (ID), -- PK De la tabla
	Constraint FK_Soldatos_Capos Foreign Key (ID_Capo) References FM_Capos_Regime_Decime (ID),
)
Go

------------ LUGARTENIENTES ------------
CREATE TABLE FM_Lugartenientes
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Nombre nVarChar(15) NULL,
	Apellidos nVarChar(15) NULL,
	Apodo nVarChar(15) NULL,
	ID_Capo Int NOT NULL,

	-- Creacion de las PK y FK
	Constraint PK_Lugartenientes Primary Key (ID), -- PK De la tabla
	Constraint FK_Lugarteniente_Capos Foreign Key (ID_Capo) References FM_Capos_Regime_Decime (ID), -- FK Capos
)
Go

------------ TECNICAS_PERSUACION ------------
CREATE TABLE FM_Tecnicas_Persuacion
(
    -- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Denominacion nVarChar(15) NULL,

	-- Creacion de la PK
	Constraint PK_Tecnicas_Persuacion Primary Key (ID), -- PK De la tabla
)
Go

------------ ARMAS ------------
CREATE TABLE FM_Armas
(
    -- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Denominacion nVarChar(15) NULL,
	LegalSN Char(1) NULL, -- Sera 'S' o 'N'
	LicenciaSN Char(1) NULL, -- Sera 'S' o 'N'

	-- Creacion de la PK
	Constraint PK_Armas Primary Key (ID), -- PK De la tabla
)
Go

------------ ARMA_BLANCA ------------
CREATE TABLE FM_Armas_Blanca
(
    -- Creacion de las columnas de la tabla
	Longitud_Hoja SmallInt NULL,
	Tipo_Filo nVarchar(15) NULL,
	RetractilSN Char(1) NULL, -- Sera 'S' o 'N'
	ID_Arma Int NOT NULL

	-- Creacion de la PK
	Constraint PK_Arma_Blanca Primary Key (ID_Arma), -- PK De la tabla
	Constraint FK_Arma_Blanca_Arma Foreign Key (ID_Arma) References FM_Armas (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION,
)
Go

------------ ARMA_FUEGO ------------
CREATE TABLE FM_Armas_Fuego
(
    -- Creacion de las columnas de la tabla
	Marca nVarChar(15) NULL,
	Modelo nVarChar(15) NULL,
	Calibre Int NULL,
	Capacidad_Proyectiles Int Null,
	ID_Arma Int NOT NULL,

	-- Creacion de las PK y FK
	Constraint PK_Arma_Fuego Primary Key (ID_Arma), -- PK De la tabla
	Constraint FK_Arma_Fuego_Arma Foreign Key (ID_Arma) References FM_Armas (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION,
)
Go

-------------------------------------------------- RELACIONES --------------------------------------------------

------------ Famiglias_Territorios_Negocios ------------
CREATE TABLE FM_Famiglias_Territorios_Negocios
(
    -- Creacion de las columnas de la tabla
	Nombre_Famiglia nVarChar(15) NOT NULL,
	ID_Territorio Int NOT NULL,
	ID_Negocio Int NOT NULL

	-- Creacion de las PK y FK
	Constraint PK_Famiglias_Territorios_Negocios Primary Key (Nombre_Famiglia, ID_Territorio, ID_Negocio), -- PK De la tabla
	
	Constraint FK_Famiglias_Territorios_Negocios_Famiglias Foreign Key (Nombre_Famiglia) References FM_Famiglias (Nombre) 
	ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Famiglias

	Constraint FK_Famiglias_Territorios_Negocios_Territorios Foreign Key (ID_Territorio) References FM_Territorios (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Territorios

	Constraint FK_Famiglias_Territorios_Negocios_Negocios Foreign Key (ID_Negocio) References FM_Negocios (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Negocios
)
Go

------------ CAPOS_TECNICAS_PERSUACION ------------
CREATE TABLE Capos_Tecnicas_Pensuacion
(
    -- Creacion de las columnas de la tabla
	ID_Capo Int NOT NULL,
	ID_Tecnica_Persuacion Int NOT NULL

	-- Creacion de las PK y FK
	Constraint PK_Capos_Tecnicas_Pensuacion Primary Key (ID_Capo, ID_Tecnica_Persuacion),

	Constraint FK_Capos_Tecnicas_Pensuacion_Capos Foreign Key (ID_Capo) References FM_Capos_Regime_Decime (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Capos
	
	Constraint FK_Capos_Tecnicas_Pensuacion_Tenicas_Persuacion Foreign Key (ID_Tecnica_Persuacion) References FM_Tecnicas_Persuacion (ID) 
	ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Tecnicas_Persuacion
)
Go

------------ SOLDATOS_ARMAS ------------
CREATE TABLE Soldatos_Armas
(
    -- Creacion de las columnas de la tabla
	ID_Soldato Int NOT NULL,
	ID_Arma Int NOT NULL,
	Destreza TinyInt NOT NULL,

	-- Creacion de las PK y FK
	Constraint PK_Soldados_Armas Primary Key (ID_Soldato, ID_Arma),

	Constraint FK_Soldados_Armas_Soldados Foreign Key (ID_Soldato) References FM_Soldatos,

	Constraint FK_Soldados_Armas_Armas Foreign Key (ID_Arma) References FM_Armas,

	-- Creacion restricciones
	Constraint CK_RangoDestreza CHECK ( Destreza BETWEEN 0 AND 5 )
)
GO
-------------------------------------------------- 3. CREAR RESTRICCIONES --------------------------------------------------

-- 1. Rango de edad de los soldados
ALTER TABLE FM_Soldatos
ADD Constraint CK_RangoEdad CHECK ((YEAR(CURRENT_TIMESTAMP-CAST(Fecha_Nacimiento AS DATETIME))-1900) BETWEEN 15 AND 55)
Go

-- 2. Arma ilegar licencia lo tiene a null
ALTER TABLE FM_Armas                
ADD Constraint CK_ArmaIlegalNoLicencia CHECK ( LegalSN = 'N' AND LicenciaSN = NULL ) -- Si las armas tienen S en el campo de legalidad (es ilegal) debe tener NULL en licencia
Go

-- 3. Los capos no pueden tener el mismo apodo
ALTER TABLE FM_Capos_Regime_Decime
ADD Constraint CK_CaposDistintoApodo CHECK ( Apodo != Apodo )
Go

-- 4. El tipo de filo de un arma blanca sera: recto, convexo, scandi, serrado o mixto
ALTER TABLE FM_Armas_Blanca
ADD Constraint CK_TipoLimitadoDeFilos CHECK (Tipo_Filo IN ('recto', 'convexo', 'scandi', 'serrado','mixto'))
Go

-- 5. Añadir columna calculada a la tabla armas de fuego, se llamara 'pupa' Formula: pupa = (Calibre / 10) * Capacidad_Proyectiles
ALTER TABLE FM_Armas_Fuego
ADD [Pupa] AS ((Calibre / 10) * Capacidad_Proyectiles)
Go

-- 6. Establecer por defecto "Sicilia" al campo Procedencia de la tabla Capos 
ALTER TABLE FM_Capos_Regime_Decime
ADD Constraint DF_Procedencia DEFAULT 'Sicilia' FOR Procedencia

-------------------------------------------------- 4. CREAR TABLA DELITOS --------------------------------------------------
------------ DELITOS ------------
CREATE TABLE FM_Delitos
(
	-- Creacion de las columnas de la tabla
	ID Int NOT NULL,
	Denominacion nVarChar(15) NULL,
	ArticuloCP nVarChar(15) NULL,
	CondenaMin Int NULL,
	CondenaMax Int NULL,

	-- Creacion de las PK y FK
	Constraint PK_Delitos Primary Key (ID) -- PK de la tabla
)
Go

-- Condena maxima debe estar entre condena minima y 360
ALTER TABLE FM_Delitos
ADD Constraint CK_TiposDeFilos CHECK (CondenaMax BETWEEN CondenaMin AND 360)
Go

-------------------------------------------------- 5. RELACIONAR DELITOS CON SOLDATOS Y CON CAPOS --------------------------------------------------
CREATE TABLE FM_Delitos_Soldatos_Capos_Regime_Decime
(
	-- Creacion de las columnas de la tabla
	ID_Delito Int NOT NULL,
	ID_Soldato Int NOT NULL,
	ID_Capo Int NOT NULL

	-- Creacion de las PK Y FK
	Constraint PK_Delitos_Soldatos_Capos_Regime_Decime Primary Key(ID_Delito, ID_Soldato, ID_Capo),

	Constraint FK_Delitos_Soldatos_Capos_Regime_Decime_Delitos Foreign Key (ID_Delito) References FM_Delitos (ID)
	ON UPDATE CASCADE ON DELETE NO ACTION,

	Constraint FK_Delitos_Soldatos_Capos_Regime_Decime_Soldatos Foreign Key (ID_Soldato) References FM_Soldatos (ID)
	ON UPDATE CASCADE ON DELETE NO ACTION,

	Constraint FK_Delitos_Soldatos_Capos_Regime_Decime_Capos_Regime_Decime Foreign Key (ID_Capo) References FM_Capos_Regime_Decime (ID)
	ON UPDATE CASCADE ON DELETE NO ACTION,
)
Go

-- ESPERO APROBAR, SI NO, LLAMARE A DON VITO CORLEONE, NO ES NO ES NADA PERSONAL SOLO CUESTION DE NEGOCIOS :)