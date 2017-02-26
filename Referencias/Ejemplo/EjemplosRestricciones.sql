CREATE DATABASE Ejemplos

GO
USE Ejemplos
GO


/*
1.	DatosRestrictivos. Columnas:
	a.	ID Es un SmallInt autonum�rico que se rellenar� con n�meros impares.. No admite nulos. Clave primaria
	b.	Nombre: Cadena de tama�o 15. No puede empezar por "N� ni por "X� A�ade una restiricci�n UNIQUE. No admite nulos
	c.	Numpelos: Int con valores comprendidos entre 0 y 145.000
	d.	TipoRopa: Car�cter con uno de los siguientes valores: "C�, "F�, "E�, "P�, "B�, �N�
	e.	NumSuerte: TinyInt. Tiene que ser un n�mero divisible por 3.
	f.	Minutos: TinyInt Con valores comprendidos entre 20 y 85 o entre 120 y 185.

*/
CREATE TABLE DatosRestrictivos(
ID smallInt not null IDENTITY (1,2)
,Nombre nVarChar(15) not null
,NumPelos int null
,TipoRopa char(1) null
,NumSuerte tinyInt null
,Minutos tinyInt null
CONSTRAINT PK_DatosRestrictivos PRIMARY KEY (ID)
,CONSTRAINT CK_Nombre CHECK (Nombre LIKE ('[^NX]%'))
,CONSTRAINT U_Nombre UNIQUE (Nombre)
,CONSTRAINT CK_NumPelos CHECK (NumPelos BETWEEN 0 AND 145000)
,CONSTRAINT CK_TipoRopa CHECK (TipoRopa LIKE ('[cfepbn]') )
,CONSTRAINT CK_NumSuerte CHECK  (NumSuerte%3=0)
,CONSTRAINT CK_Minutos CHECK ((Minutos BETWEEN 20 AND 85) OR (Minutos BETWEEN 120 AND 185))
)


/*
2.	DatosRelacionados. Columnas:

-NombreRelacionado, �misma restriccion en la columna de esta table?
	No, en esta tabla solo se pueden introducir algo que este ya en la PK de la tabla a la que referencia.
	Si la ponemos habira redundancia, y en caso de querer cambiar esta restriccion deberiamos tener en cuneta que hay que cambiarlas en las dos tablas.

	a.	NombreRelacionado: Cadena de tama�o 15. Define una FK para relacionarla con la columna "Nombre� de la tabla DatosRestrictivos.
		�Deber�amos poner la misma restricci�n que en la columna correspondiente?
		�Qu� ocurrir�a si la ponemos?�Y si no la ponemos?
	b.	PalabraTabu: Cadena de longitud max 20. No admitir� los valores "Barcenas�, "Gurtel�, "P�nica�, "Bankia� ni "sobre�. Tampoco admitir� ninguna palabra terminada en "eo�
	c.	NumRarito: TinyInt menor que 20. No admitir� n�meros primos.
	d.	NumMasgrande: SmallInt. Valores comprendidos entre NumRarito y 1000. Definirlo como clave primaria.
	�Puede tener valores menores que 20?
*/
CREATE TABLE DatosRelacionados(
NombreRelacionado NVarChar (15) not null
,PalabraTabu NVarChar (20) not null
,NumRarito tinyInt not null
,NumMasGrande smallInt not null
CONSTRAINT PK_DatosRelacionados PRIMARY KEY (NombreRelacionado)
,CONSTRAINT FK_DatosRelacionadosRestrictivos FOREIGN KEY (NombreRelacionado) REFERENCES DatosRestrictivos (Nombre)
,CONSTRAINT CK_PalabraTabu1 CHECK (PalabraTabu NOT IN ('Barcenas','Gurtel','P�nica','Bankia','sobre') AND PalabraTabu NOT LIKE ('%eo'))
,CONSTRAINT CK_NumRaritoMenor20 CHECK (NumRarito BETWEEN 0 AND 20)
,CONSTRAINT CK_NumRaritoNoPrimo CHECK (NumRarito NOT IN ('2', '3', '7', '11', '13', '17', '19'))
,CONSTRAINT CK_NumMasGrande CHECK (NumMasGrande BETWEEN NumRarito AND 1000) 
)

/*

*/