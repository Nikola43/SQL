CREATE DATABASE EjemplosPaulo
Go
USE EjemplosPaulo
Go

--DatosRestrictivos. Columnas:
--ID Es un SmallInt autonumérico que se rellenará con números impares.. No admite nulos. Clave primaria
--Nombre: Cadena de tamaño 15. No puede empezar por "N” ni por "X” Añade una restiricción UNIQUE. No admite nulos
--Numpelos: Int con valores comprendidos entre 0 y 145.000
--TipoRopa: Carácter con uno de los siguientes valores: "C”, "F”, "E”, "P”, "B”, ”N”
--NumSuerte: TinyInt. Tiene que ser un número divisible por 3.
--Minutos: TinyInt Con valores comprendidos entre 20 y 85 o entre 120 y 185.
CREATE TABLE DatosRestrictivos
(
	ID smallInt NOT NULL identity (1, 2), 
	Nombre varChar(15) NOT NULL UNIQUE,
	NumPelos int,
	TipoRopa char,
	NumSuerte TinyInt,
	Minutos TinyInt,

	-- Claves primarias y ajenas
	Constraint PK_DatosRestrictivos Primary Key (ID),

	-- Restrincciones
	Constraint CK_Nombre CHECK ( Nombre NOT LIKE 'N%' OR Nombre NOT LIKE 'X%' ),
	Constraint CK_NumPelos CHECK ( NumPelos BETWEEN 0 AND 145000 ),
	Constraint CK_TipoRopa CHECK ( TipoRopa  IN ('C', 'F', 'E', 'P', 'B', 'N') )
)



--DatosRelacionados. Columnas:
--NombreRelacionado: Cadena de tamaño 15. Define una FK para relacionarla con la columna "Nombre” de la tabla DatosRestrictivos.
--¿Deberíamos poner la misma restricción que en la columna correspondiente?
--¿Qué ocurriría si la ponemos?
--¿Y si no la ponemos?
--PalabraTabu: Cadena de longitud max 20. No admitirá los valores "Barcenas”, "Gurtel”, "Púnica”, "Bankia” ni "sobre”. Tampoco admitirá ninguna palabra terminada en "eo”
--NumRarito: TinyInt menor que 20. No admitirá números primos.
--NumMasgrande: SmallInt. Valores comprendidos entre NumRarito y 1000. Definirlo como clave primaria.
--¿Puede tener valores menores que 20?

--DatosAlMogollon. Columnas:
--ID. SmallInt. No admitirá múltiplos de 5. Definirlo como PK
--LimiteSuperior. SmallInt comprendido entre 1500 y 2000.
--OtroNumero. Será mayor que el ID y Menor que LimiteSuperior. Poner UNIQUE
--NumeroQueVinoDelMasAlla: SmallInt FK relacionada con NumMasGrande de la tabla DatosRelacionados
--Etiqueta. Cadena de 3 caracteres. No puede tener los valores "pao”, "peo”, "pio” ni "puo”