CREATE DATABASE EjemplosPaulo
Go
USE EjemplosPaulo
Go

--DatosRestrictivos. Columnas:
--ID Es un SmallInt autonum�rico que se rellenar� con n�meros impares.. No admite nulos. Clave primaria
--Nombre: Cadena de tama�o 15. No puede empezar por "N� ni por "X� A�ade una restiricci�n UNIQUE. No admite nulos
--Numpelos: Int con valores comprendidos entre 0 y 145.000
--TipoRopa: Car�cter con uno de los siguientes valores: "C�, "F�, "E�, "P�, "B�, �N�
--NumSuerte: TinyInt. Tiene que ser un n�mero divisible por 3.
--Minutos: TinyInt Con valores comprendidos entre 20 y 85 o entre 120 y 185.
CREATE TABLE DatosRestrictivos
(
	-- Creacion de columnas
	ID smallInt NOT NULL identity (1, 2), 
	Nombre varChar(15) NOT NULL UNIQUE,
	NumPelos int,
	TipoRopa char,
	NumSuerte TinyInt,
	Minutos TinyInt,

	-- Creacion de claves primarias y ajenas
	Constraint PK_DatosRestrictivos Primary Key (ID),

	-- Restricciones
	Constraint CK_Nombre CHECK ( Nombre NOT LIKE 'N%' AND Nombre NOT LIKE 'X%' ),
	Constraint CK_NumPelos CHECK ( NumPelos BETWEEN 0 AND 145000 ),
	Constraint CK_TipoRopa CHECK ( TipoRopa  IN ('C', 'F', 'E', 'P', 'B', 'N') ), -- LIKE [CFEPBN]
	Constraint CK_NumSuerte CHECK ( NumSuerte % 3 = 0 ),
	Constraint CK_Minutos CHECK ( (Minutos BETWEEN 20 AND 85) OR (Minutos BETWEEN 120 AND 185) )
)
Go


--DatosRelacionados. Columnas:
--NombreRelacionado: Cadena de tama�o 15. Define una FK para relacionarla con la columna "Nombre� de la tabla DatosRestrictivos.
--�Deber�amos poner la misma restricci�n que en la columna correspondiente? 
	-- NO, YA QUE NO SE MODIFICA DESDE ESTA TABLA EL VALOR DE LA FORING KEY
--�Qu� ocurrir�a si la ponemos?
	-- FUKCING BREAK BRAIN
--�Y si no la ponemos?
	-- 
--PalabraTabu: Cadena de longitud max 20. No admitir� los valores "Barcenas�, "Gurtel�, "P�nica�, "Bankia� ni "sobre�. Tampoco admitir� ninguna palabra terminada en "eo�
--NumRarito: TinyInt menor que 20. No admitir� n�meros primos.
--NumMasgrande: SmallInt. Valores comprendidos entre NumRarito y 1000. Definirlo como clave primaria.
--�Puede tener valores menores que 20?
CREATE TABLE DatosRelacionados
(
	-- Creacion de columnas
	NombreRelacionado varChar(15) NOT NULL,
	PalabraTabu varChar(20) NOT NULL, 
	NumRarito tinyInt NOT NULL,
	NumMasGrande smallInt NOT NULL,

	-- Creacion de claves primarias y ajenas
	Constraint PK_DatosRelacionados Primary Key (NumMasGrande),
	Constraint FK_DatosRelacionados_DatosRestrictivos Foreign Key (NombreRelacionado)
	REFERENCES DatosRestrictivos (Nombre) ON UPDATE CASCADE ON DELETE CASCADE,

	-- Restrincciones
	Constraint CK_PalabraTabu CHECK ( PalabraTabu NOT IN ('Barcenas', 'Gurtel', 'P�nica', 'Bankia', 'sobre') OR (PalabraTabu NOT LIKE '%eo') ),
	Constraint CK_NumRarito CHECK ( NumRarito < 20 AND NumRarito NOT IN (2, 3, 5, 7, 11, 13, 17, 19) ),
	Constraint CK_NumMasGrande CHECK ( NumMasGrande BETWEEN NumRarito AND 1000 ),
)
Go

--DatosAlMogollon. Columnas:
--ID. SmallInt. No admitir� m�ltiplos de 5. Definirlo como PK
--LimiteSuperior. SmallInt comprendido entre 1500 y 2000.
--OtroNumero. Ser� mayor que el ID y Menor que LimiteSuperior. Poner UNIQUE
--NumeroQueVinoDelMasAlla: SmallInt FK relacionada con NumMasGrande de la tabla DatosRelacionados
--Etiqueta. Cadena de 3 caracteres. No puede tener los valores "pao�, "peo�, "pio� ni "puo�