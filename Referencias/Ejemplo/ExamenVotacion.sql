CREATE DATABASE ExamenVotacion
GO
USE ExamenVotacion
GO



Create table EV_Formaciones(
ID smallint not null CONSTRAINT PK_Formaciones PRIMARY KEY
,NombreCompleto nvarchar (30) not null
,NombreAbreviado nvarchar (10) not null
,FechaFundacion date not null
)
GO

Create table EV_Partidos(
ID smallint not null CONSTRAINT PK_Partidos PRIMARY KEY
,IDFormacion smallint not null CONSTRAINT FK_Partidos_Formaciones FOREIGN KEY REFERENCES EV_Formaciones (ID)
,Ideología nvarchar (20) not null
,NombreLíder nvarchar (40) not null
)
GO



Create table EV_Coaliciones(
ID smallint not null CONSTRAINT PK_Coaliciones PRIMARY KEY
,IDFormacion smallint not null CONSTRAINT FK_Coaliciones_Formaciones FOREIGN KEY REFERENCES EV_Formaciones (ID)
,Ámbito nvarchar (10) not null
)
GO

Create table EV_CoalicionesPartidos(
IDCoalicion smallint not null CONSTRAINT FK_CoalicionesPartidos_Coaliciones FOREIGN KEY REFERENCES EV_Coaliciones (ID)
,IDPartido smallint not null CONSTRAINT FK_CoalicionesPartidos_Partidos FOREIGN KEY REFERENCES EV_Partidos (ID)
,CONSTRAINT FK_CoalicionesPartidos PRIMARY KEY (IDCoalicion, IDPartido)
)
GO

Create table EV_Circunscripciones(
Codigo smallint not null CONSTRAINT PK_Circunscripciones PRIMARY KEY
,Nombre nvarchar (30) not null
)
GO



Create table EV_Candidaturas(
ID smallint not null CONSTRAINT PK_Candidaturas PRIMARY KEY
,IDFormacion smallint not null CONSTRAINT FK_Candidaturas_Formaciones FOREIGN KEY REFERENCES EV_Formaciones (ID)
,CodigoCircunscripcion smallint not null CONSTRAINT FK_Candidaturas_Circunscripciones FOREIGN KEY REFERENCES EV_Circunscripciones (Codigo)
,Nombre nvarchar (20) not null
,NombreRepresentante nvarchar (20) not null
,ApellidosRepresentante nvarchar (40) not null
,Teléfono nvarchar(9) not null
)
GO

Create table EV_Apoderados(
DNI nchar (9) not null CONSTRAINT PK_Apoderados PRIMARY KEY
,Nombre nvarchar (20) not null
,Apellidos nvarchar (40) not null
,FechaNacimiento date not null
)
GO



Create table EV_Candidatos(
DNI nchar (9) not null CONSTRAINT PK_Candidatos PRIMARY KEY
,Nombre nvarchar (20) not null
,Apellidos nvarchar (40) not null
,FechaNacimiento date not null
,IDCandidatura smallint not null CONSTRAINT FK_Candidatos_Candidaturas FOREIGN KEY REFERENCES EV_Candidaturas (ID)
,NumeroOrden smallint not null
,OrdenEleccion smallint null
)
GO



Create table EV_Mesas(
ID smallint not null CONSTRAINT PK_Mesas PRIMARY KEY
,Seccion smallint not null
,LetraMesa nchar (1) not null
,NumeroElectores int not null
)
GO

Create table EV_Interventores(
DNI nchar (9) not null CONSTRAINT PK_Interventores PRIMARY KEY
,Nombre nvarchar (20) not null
,Apellidos nvarchar (40) not null
,FechaNacimiento date not null
,IDCandidatura smallint not null CONSTRAINT FK_Interventores_Candidaturas FOREIGN KEY REFERENCES EV_Candidaturas (ID)
,IDMesa smallint not null CONSTRAINT FK_Interventores_Mesas FOREIGN KEY REFERENCES EV_Mesas (ID)
)
GO

Create table EV_Distritos(
NumeroDistrito int not null CONSTRAINT PK_Distritos PRIMARY KEY
,Direccion nvarchar (80) not null
,IDMesa smallint not null CONSTRAINT FK_Distritos_Mesas FOREIGN KEY REFERENCES EV_Mesas (ID)
)
GO



Create table EV_VotacionCongreso(
IDMesa smallint not null CONSTRAINT FK_VotacionCongreso_Mesas FOREIGN KEY REFERENCES EV_Mesas (ID)
,IDCandidatura smallint not null CONSTRAINT FK_VotacionCongreso_Candidaturas FOREIGN KEY REFERENCES EV_Candidaturas (ID)
,VotosCongreso int null
)
GO

Create table EV_VotacionSenado(
IDMesa smallint not null CONSTRAINT FK_VotacionSenado_Mesas FOREIGN KEY REFERENCES EV_Mesas (ID)
,CodigoCircunscripcion smallint not null CONSTRAINT FK_VotacionSenado_Circunscripciones FOREIGN KEY REFERENCES EV_Circunscripciones (Codigo)
,VotosSenado int null
)
GO

--1.-La fecha de fundacion del partido no puede ser mayor a la actual
ALTER TABLE EV_Formaciones ADD CONSTRAINT CK_FechaFundacion CHECK (FechaFundacion<CURRENT_TIMESTAMP)
--FinModificacionFechaFundacion

--2.-El numero de votos no puede ser negativo
ALTER TABLE EV_VotacionCongreso ADD CONSTRAINT CK_VotosCongreso CHECK (VotosCongreso>0)
ALTER TABLE EV_VotacionSenado ADD CONSTRAINT CK_VotosSenado CHECK (VotosSenado>0)
GO
--FinModificacionVotos

--3.-DNI formado por 8 numeros y una letra
ALTER TABLE EV_Apoderados ADD CONSTRAINT CK_DNIApoderados CHECK (DNI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
ALTER TABLE EV_Interventores ADD CONSTRAINT CK_DNIInterventores CHECK (DNI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
ALTER TABLE EV_Candidatos ADD CONSTRAINT CK_DNICandidatos CHECK (DNI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
GO
--FinModificacionDNIs

--4.-El numero de electores esta entre 10 y 1500
ALTER TABLE EV_Mesas ADD CONSTRAINT CK_ElectoresMesas CHECK (NumeroElectores between 10 and 1500)
GO
--FinModificacionElectores

--5.-El ambito de coaliciones tiene que ser Local, Provincial, Regional, Nacional o Europea
ALTER TABLE EV_Coaliciones ADD CONSTRAINT CK_AmbitoCoaliciones CHECK (Ámbito in ('Local', 'Provincial', 'Regional', 'Nacional', 'Europea'))
--FinModificacion


--EJERCICIO 4, crearemos la trabla REPRESENTANTES
--borraremos las columnas Nombre y Apellidos de Representante de la tabla candidatura
ALTER TABLE EV_Candidaturas DROP COLUMN NombreRepresentante
ALTER TABLE EV_Candidaturas DROP COLUMN ApellidosRepresentante

Create table EV_Representantes(
DNI nchar (9) not null CONSTRAINT CK_DNIRepresentantes CHECK (DNI like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
,IDCandidatura smallint not null CONSTRAINT FK_Representantes_Candidaturas FOREIGN KEY REFERENCES EV_Candidaturas (ID)
,NombreRepresentante nvarchar (20) not null
,ApellidosRepresentante nvarchar (40) not null
)
GO
--FinModificacionesEjercicio4






