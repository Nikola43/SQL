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
	Constraint FK_Socios_Acurios Foreign Key (ID_Acuarios) REFERENCES AN_Acuarios (ID), -- FK Acuarios
)
Go

------------ SeresVivos ------------
CREATE TABLE SeresVivos
(
    -- Creacion Columnas
	ID Int Identity(1,1) NOT NULL,
	Especie nVarChar (15) NULL,
	Temperatura 

)
