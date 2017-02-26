CREATE DATABASE Famosillos

GO
USE Famosillos
GO

/*Un famosillo/a se identifica por un código de cinco caracteres y tiene nombre y apellidos reales, nombre público, 
fecha de nacimiento, lugar de nacimiento, dirección, código postal, provincia, e-mail y nacionalidad.
Nacionalidad 
*/

CREATE TABLE FA_Famosillos(
Codigo char (5) not null
,Nombre varchar (20) not null
,Apellidos varchar (40) not null
,[Nombre público] varchar (30) null
,[Fecha Nacimiento] date not null
,[Lugar nacimiento] varchar (30) not null
,Direccion varchar (50) not null
,CP char (5) not null
,Provincia varchar (30) not null
,Email varchar (30) not null
,[Email alternativo] varchar (30) null 
,Nacionalidad varchar (30) not null
,CONSTRAINT PK_FA_Famosillos PRIMARY KEY (Codigo)
,CONSTRAINT U_FA_Famosillos UNIQUE ([Nombre público])
)

CREATE TABLE FA_ParejaFamosillos(
ID smallint not null IDENTITY
,[Nombre famosillo 1] varchar (30) not null
,[Nombre famosillo 2] varchar (30) not null
,[Fecha inicio] date not null
,[Fecha fin] date not null
,Tipo varchar (50) not null
,CONSTRAINT PK_FA_ParejaFamosillos PRIMARY KEY (ID)
,CONSTRAINT FK_ParejaFamosillos1_Famosillos FOREIGN KEY ([Nombre famosillo 1]) REFERENCES FA_Famosillos ([Nombre público]) ON DELETE NO ACTION ON UPDATE CASCADE
,CONSTRAINT FK_ParejaFamosillos2_Famosillos FOREIGN KEY ([Nombre famosillo 2]) REFERENCES FA_Famosillos ([Nombre público]) ON DELETE NO ACTION ON UPDATE CASCADE
)

CREATE TABLE FA_Exclusivas(
Codigo char (5) not null
,Fecha date not null
,Descripcion varchar (100) not null
,Precio money not null
,CONSTRAINT PK_FA_Exclusivas PRIMARY KEY (Codigo)
)

CREATE TABLE FA_MediosLamentables(
Nombre varchar (30) not null
,Tipo varchar (30) not null
,Dirección varchar (50) not null
,CP char (5) not null
,Provincia varchar (30) not null
,Teléfono char (9) not null
,CONSTRAINT PK_FA_MediosLamentables PRIMARY KEY (Nombre)

)

CREATE TABLE FA_Lugares(
ID smallint not null IDENTITY
,Nombre varchar (30) not null
,Dirección varchar (50) not null
,CP char (5) not null
,Provincia varchar (30) not null
,Teléfono char (9) not null
,[Superficie cubierta (m^2)] int not null
,[Superficie libre (m^2)] int not null
,[Instrucciones de acceso] varchar (max) not null
,CONSTRAINT PK_FA_Lugares PRIMARY KEY (ID)
)


CREATE TABLE FA_Fiestas(
ID smallint not null IDENTITY
,[ID Lugares] smallint not null
,[Fecha-Hora] datetime not null
,Tema varchar(30) not null
,CONSTRAINT PK_FA_Fiestas PRIMARY KEY (ID)
,CONSTRAINT FK_Fiestas_Lugares FOREIGN KEY ([ID Lugares]) REFERENCES FA_Lugares (ID) ON DELETE NO ACTION ON UPDATE CASCADE
)

CREATE TABLE FA_Grupos(
Nombre varchar (30) not null
,Estilo varchar (30) not null
,[Telefono Contacto] char (9) not null
,CONSTRAINT PK_FA_Grupos PRIMARY KEY (Nombre)
)

CREATE TABLE FA_Artistas(
ID smallint not null IDENTITY
,Nombre varchar (30) not null
,Instrumento varchar (30) not null
,[Nombre grupo] varchar (30) not null
,CONSTRAINT PK_FA_Artistas PRIMARY KEY (ID)
,CONSTRAINT FK_Artistas_Grupos FOREIGN KEY ([Nombre grupo]) REFERENCES FA_Grupos (Nombre) ON DELETE NO ACTION ON UPDATE CASCADE 
)

