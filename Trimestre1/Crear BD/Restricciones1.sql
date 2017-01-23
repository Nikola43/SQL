create database Ejemplos

go 

use Ejemplos

create table DatosRestrictivos
(
ID SmallInt Not NULL IDENTITY (1,2),
Nombre char(15) not null UNIQUE constraint  CK_Rest_Nombre check (Nombre not like '[NX]'),
Numpelos int constraint CK_Rango check (Numpelos between 0 and 145000),
TipoRopa char (1) Not null constraint CK_Caracteres check(TipoRopa in ('C','F','E','P','B','N')),
NumSuerte TinyInt Not null constraint CK_NumerosSuerte check (NumSuerte%3=0),
Minutos TinyInt not null constraint CK_Minutos check((Minutos between 20 and 85)or (Minutos between 120 and 185))
)
go
use Ejemplos
go
create table DatosRelacionados
(
NombreRelacionado char(15) not null,
PalabraTabu varchar(20) NULL constraint CK_NombresTabu check ((PalabraTabu not in ('Barcenas','Gurtel','Púnica','Bankia','sobre'))and (PalabraTabu like '^%eo')),
NumRarito TinyInt constraint ck_Primos check ((NumRarito <20) and (NumRarito not in(2, 3, 5, 7, 11, 13, 17, 19))),
NumMasGrande SmallInt constraint PK_DatosRelacionados primary key,

constraint CK_RestriccionNUmeroGrande check (NumMasGrande between NumRarito and 1000),
constraint FK_DatosRestrictivos foreign key(NombreRelacionado) references DatosRestrictivos(Nombre)
)

go 
use Ejemplos
go
create table DatosAlMogollon
(
ID Smallint constraint PK_DatosAlMogollon primary key constraint CK_Multiplos check (ID%5!=0),
LimiteSuperior SmallInt constraint CK_RangoSuperior check (LimiteSuperior between 1500 and 2000),
OtroNumero int UNIQUE,
NumeroQueVinoDelMasAlla Smallint,
Etiqueta char(3) constraint CK_TresLetras check (Etiqueta not in('pao','peo','pio','puo')),
constraint FK_DatosRelacionados foreign key (NumeroQueVinoDelMasAlla)references DatosRelacionados(NumMasGrande),
constraint CK_MAyores check (OtroNumero > ID and OtroNumero<LimiteSuperior)
)create database Ejemplos


