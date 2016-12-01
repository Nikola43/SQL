--USE MASTER
--GO
--DROP DATABASE ACUARIOS_NEMO
--GO

CREATE DATABASE ACUARIOS_NEMO
GO
USE ACUARIOS_NEMO
GO

------------ BOMBAS ------------
CREATE TABLE AN_Bombas
(
	-- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	Marca nVarChar (10) NULL,
	Modelo nVarChar (10) NULL,
	Caudal Int NULL,
	Consumo Int NULL,

	-- Creacion PK
	Constraint PK_Bombas Primary Key (ID), 
)
Go

------------ ACUARIOS ------------
CREATE TABLE AN_Acuarios 
(
    -- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	ID_Bomba Int NOT NULL,
	Capacidad Int NULL,
	Ancho Int NULL,
	Alto Int NULL,
	Largo Int NULL,

	-- Creacion PK y FK
	Constraint PK_Acuarios Primary Key (ID), -- PK Acuarios
	Constraint FK_Acuarios_Bombas Foreign Key (ID_Bomba) REFERENCES AN_Acuarios (ID), -- FK Bombas
)
Go

------------ Socios ------------
CREATE TABLE AN_Socios
(
	-- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	ID_Acuarios Int NOT NULL,
	Nombre nVarChar (20) NULL,
	Apellidos nVarChar (20) NULL,
	Direccion nVarChar NULL,
	Email nVarChar NULL,
	Telefono Int NULL,

	-- Creacion PK y FK
	Constraint PK_Socio Primary Key (ID), -- PK Socio
	
	Constraint FK_Socios_Acurios Foreign Key (ID_Acuarios) 
	REFERENCES AN_Acuarios (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Acuarios
)
Go

------------ SeresVivos ------------
CREATE TABLE AN_SeresVivos
(
    -- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	Especie nVarChar (15) NULL,
	Temperatura_Maxima Int NULL,
	Temperatura_Minima Int NULL,

	-- Creacion PK
	Constraint PK_SeresVivos Primary Key (ID)
)
Go

------------ SeresVivos ------------
CREATE TABLE AN_Alimentos
(
    -- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	Tipo nVarChar NOT NULL,
	Nombre nVarChar NULL,
	ValorEnergetico Int NULL,

	-- Creacion FK
	Constraint PK_Alimentos Primary Key (ID), -- PK Alimentos
)
Go

------------ Peces ------------
CREATE TABLE AN_Peces
(
	-- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	ID_Alimento Int NOT NULL,
	Nombre nVarchar (20) NULL,
	Color nVarChar (20) NULL,
	Tipo nVarChar (20) NULL,
	Tamanio Int NULL,

	-- Creacion PK
	Constraint PK_Peces Primary Key (ID), -- PK Socio
	Constraint FK_PecesAlimento Foreign Key (ID_Alimento) 
	REFERENCES AN_Alimentos (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Alimentos
)
Go

------------ Plantas ------------
CREATE TABLE AN_Plantas
(
	-- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	NombreComun nVarChar NULL,
	TamanioMaximo Int NULL,
	NecesidadDeLuz Int NULL,

	-- Creacion PK
	Constraint PK_Plantas Primary Key (ID)
)

------------ Tierras ------------
CREATE TABLE AN_Tierras
(
	-- Creacion Columnas
	ID Int NOT NULL,
	Nombre nVarChar NULL,
	Mezcla nVarChar NULL,

	-- Creacion PK
	Constraint PK_Tierras Primary Key (ID)
)

------------ Plantas_Tierras ------------
CREATE TABLE AN_Plantas_Tierras
(
    -- Creacion Columnas
	ID_Planta Int NOT NULL,
	ID_Tierra Int NOT NULL,

	-- Creacion PK Y FK
	Constraint PK_Plantas_Tierras Primary Key (ID_Planta, ID_Tierra), -- PK Plantas_Tierras compuesta 
	
	Constraint FK_Plantas_Tierras_Planta Foreign Key (ID_Planta) 
	REFERENCES AN_Plantas (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Plantas

	Constraint FK_Plantas_Tierras_Tierras Foreign Key (ID_Tierra)
	 REFERENCES AN_Tierras (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Tierras
)

------------ SeresVivos_Acuarios ------------
CREATE TABLE AN_SeresVivos_Acuarios
(
    -- Creacion Columnas
	ID_SerVivo Int NOT NULL,
	ID_Acuario Int NOT NULL,

	-- Creacion PK Y FK
	Constraint PK_SeresVivos_Acuarios Primary Key (ID_SerVivo, ID_Acuario), -- PK SeresVivos_Acuarios compuesta 
	
	Constraint FK_SeresVivos_AcuariosSerVivo Foreign Key (ID_SerVivo) 
	REFERENCES AN_SeresVivos (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK SeresVivos

	Constraint FK_SeresVivos_AcuariosAcuario Foreign Key (ID_Acuario) 
	REFERENCES AN_Acuarios (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Acuarios
)

------------ PecesIncompatibles ------------
CREATE TABLE AN_PecesIncompatibles
(
	-- Creacion Columnas
	ID_Pez1 INT NOT NULL,
	ID_Pez2 INT NOT NULL,

	-- Creacion PK Y FK
	Constraint PK_PecesIncompatibles Primary Key (ID_Pez1, ID_Pez2), -- PK PecesIncompatibles compuesta

	Constraint FK_PecesIncompatiblesPez1 Foreign Key (ID_Pez1)
    REFERENCES AN_Peces (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Peces

	Constraint FK_PecesIncompatiblesPez2 Foreign Key (ID_Pez2)
    REFERENCES AN_Peces (ID) ON UPDATE CASCADE ON DELETE NO ACTION, -- FK Peces
)