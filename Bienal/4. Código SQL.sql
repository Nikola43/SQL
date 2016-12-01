
USE _Ejemplos
GO
DROP DATABASE _BienalDeFlamenco
GO
CREATE DATABASE _BienalDeFlamenco
GO
USE _BienalDeFlamenco

--Código sin terminar, faltan entidades y relaciones
CREATE TABLE Trabajadores (
	DNI char(9) NOT NULL CONSTRAINT PK_Trabajadores PRIMARY KEY,
	Nombre nvarchar(10) NOT NULL,
	Apellidos nvarchar(20) NOT NULL,
	Tipo nvarchar(10) NOT NULL,
)


CREATE TABLE Empresas(
	CIF char(9) NOT NULL CONSTRAINT PK_Empresas PRIMARY KEY,
	Nombre nvarchar(10) NOT NULL,
	Direccion nvarchar(20) NOT NULL
)

ALTER TABLE Trabajadores ADD Empresas_CIF char(9) CONSTRAINT FK_Trabajadores REFERENCES Empresas ON DELETE CASCADE ON UPDATE CASCADE

CREATE TABLE Artistas(
	DNI char(9) NOT NULL CONSTRAINT PK_Artistas PRIMARY KEY,
	Nombre nvarchar(10) NOT NULL,
	Apellidos nvarchar(20) NOT NULL,
	Tipo nvarchar (10) NOT NULL
)