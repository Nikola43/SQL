CREATE DATABASE LeoSailing
GO
USE LeoSailing
GO
/****** Object:  Table [dbo].[EV_Miembros]    Script Date: 03/05/2015 13:43:32 ******/
CREATE TABLE EV_Miembros(
	licencia_federativa int NOT NULL,
	nombre varchar(20) NOT NULL,
	apellidos varchar(30) NOT NULL,
	direccion varchar(40) NULL,
	f_nacimiento smalldatetime NULL,
	CONSTRAINT PK__EV_Miembros PRIMARY KEY (licencia_federativa),
	CONSTRAINT CK__EV_MiembroEdad CHECK  (f_nacimiento < getdate())
)

GO
INSERT EV_Miembros (licencia_federativa, nombre, apellidos, direccion, f_nacimiento) VALUES (100, 'Juan', 'Tanamera', 'Sevilla', CAST(0x80CC0000 AS SmallDateTime))
, (101, 'Ana', 'Vegante', N'Cádiz', CAST(0x78910000 AS SmallDateTime))
, (200, 'Esteban', 'Dido', 'Sevilla', CAST(0x834B0000 AS SmallDateTime))
, (207, 'Fernando', 'Minguero', 'Málaga', CAST(0x7C700000 AS SmallDateTime))
, (214, 'Elisa', 'Ladita', N'Sevilla', CAST(0x808A0000 AS SmallDateTime))
, (220, 'Paco', 'Merselo', N'Cádiz', CAST(0x7E020000 AS SmallDateTime))
, (234, 'Simon', 'Toncito', N'Granada', CAST(0x867C0000 AS SmallDateTime))
, (245, 'Aitor', 'Menta', N'Bilbao', CAST(0x89D20000 AS SmallDateTime))
, (307, 'Olga', 'Llinero', N'Madrid', CAST(0x6CD70000 AS SmallDateTime))
INSERT EV_Miembros (licencia_federativa, nombre, apellidos, direccion, f_nacimiento) VALUES (407, N'Jeremias', N'Mas', N'Sevilla', CAST(0x724E0000 AS SmallDateTime))
, (440, 'Juan Luis', 'Guerra', N'Cádiz', CAST(0x81300000 AS SmallDateTime))
, (507, 'Salud', 'Itos', N'Barcelona', CAST(0x71300000 AS SmallDateTime))
, (516, 'Ramon', 'Tañero', N'Málaga', CAST(0x7DAD0000 AS SmallDateTime))
, (607, 'Susana', 'Tillas', N'Cáceres', CAST(0x726C0000 AS SmallDateTime))
, (736, 'Pedro', 'Medario', N'Huelva', CAST(0x79C40000 AS SmallDateTime))

/****** Object:  Table [dbo].[EV_Clases]    Script Date: 03/05/2015 13:43:32 ******/

CREATE TABLE EV_Clases(
	nombre char(15) NOT NULL,
	eslora float NULL,
	manga float NULL,
	mastil float NULL,
	tripulantes tinyint NOT NULL,
	CONSTRAINT PK__EV_Clases PRIMARY KEY (nombre)
) 
GO
INSERT EV_Clases (nombre, eslora, manga, mastil, tripulantes) VALUES (N'470            ', 4.7, 1.6, 5.2, 2)
, (N'49er           ', 4.99, 1.69, 8.1, 2)
, (N'Laser          ', 4.23, 1.37, 4.15, 1)
, (N'Tornado        ', 6.09, 3.02, NULL, 2)
, (N'Yngling        ', 6.35, 1.73, NULL, 3)
/****** Object:  Table [dbo].[EV_Campo_Regatas]    Script Date: 03/05/2015 13:43:32 ******/

CREATE TABLE EV_Campo_Regatas(
	nombre_campo char(20) NOT NULL,
	puerto NVarChar(30) NOT NULL,
	longitud float NOT NULL,
	latitud_llegada DECIMAL (7,4) NOT NULL,
	longitud_llegada DECIMAL (7,4) NOT NULL,
	CONSTRAINT PK_EV_CampoRegatas PRIMARY KEY (nombre_campo),
	CONSTRAINT CK_Longitud CHECK  (longitud BETWEEN 1.5 and 150.5)
)
/****** Object:  Table [dbo].[EV_Regatas]    Script Date: 03/05/2015 13:43:32 ******/
GO

INSERT INTO EV_Campo_Regatas (nombre_campo,puerto,longitud,latitud_llegada,longitud_llegada)
     VALUES ('Bahia de Cádiz',N'Puerto Sherry',30.0,36.54,-6.25)
	 , ('Bahía de Palma',N'Real Club Nautico de Palma',22.0,39.50,2.63)
	 , ('Ría de Vigo',N'Monte Real Club de Yates',27.1,42.1697,-8.6568)
	 , ('Txapela feliz',N'Getxo',17.5,43.336706, -3.017360)
	 , ('Golfo de Roses',N'L''Escala',74.8,42.1496936,3.151496)


CREATE TABLE EV_Regatas(
	nombre char(25) NOT NULL,
	f_inicio date NOT NULL,
	intensidad_v smallint NULL,
	direccion_v smallint NULL,
	altura_olas DECIMAL (2,1) NULL,
	temp_max smallint NULL,
	nombre_campo char(20) NOT NULL,
	CONSTRAINT PK_EV_Regatas PRIMARY KEY (f_inicio),
	CONSTRAINT FK_Regatas_CampoRegatas FOREIGN KEY(nombre_campo) REFERENCES EV_Campo_Regatas (nombre_campo)
)
GO
INSERT INTO EV_Regatas (nombre,f_inicio,intensidad_v,direccion_v,altura_olas,temp_max,nombre_campo)
     VALUES ('Sherry', DATEFROMPARTS(2014,5,6),10,150,1.4,28,'Bahia de Cádiz')
	 , ('Sherry', DATEFROMPARTS(2013,5,6),10,150,1.2,32,'Bahia de Cádiz')
	 , ('Sherry', DATEFROMPARTS(2015,5,6),10,150,1.2,32,'Bahia de Cádiz')
	 , ('Halloween', DATEFROMPARTS(2014,11,1),18,80,1.0,14,'Bahia de Cádiz')
INSERT INTO EV_Regatas (nombre,f_inicio,intensidad_v,direccion_v,altura_olas,temp_max,nombre_campo)
     VALUES ('Copa del Rey', DATEFROMPARTS(2014,8,6),10,150,1.4,28,'Bahía de Palma')
	 , ('Copa del Rey', DATEFROMPARTS(2013,8,6),10,150,1.2,32,'Bahía de Palma')
	 , ('Copa del Rey', DATEFROMPARTS(2015,8,6),10,150,1.2,32,'Bahía de Palma')
	 , ('Christmas race', DATEFROMPARTS(2014,12,15),18,80,1.0,14,'Bahía de Palma')
INSERT INTO EV_Regatas (nombre,f_inicio,intensidad_v,direccion_v,altura_olas,temp_max,nombre_campo)
     VALUES ('Albarinho', DATEFROMPARTS(2014,6,26),10,150,1.4,28,'Ría de Vigo')
	 , ('Albarinho', DATEFROMPARTS(2013,6,26),10,150,1.2,32,'Ría de Vigo')
	 , ('Albarinho', DATEFROMPARTS(2015,6,26),10,150,1.2,32,'Ría de Vigo')
	 , ('Pulpo a feira', DATEFROMPARTS(2014,12,1),18,80,1.0,14,'Ría de Vigo')
INSERT INTO EV_Regatas (nombre,f_inicio,intensidad_v,direccion_v,altura_olas,temp_max,nombre_campo)
     VALUES ('Txakoli', DATEFROMPARTS(2014,6,6),16,10,1.4,28,'Txapela feliz')
	 , ('Txakoli', DATEFROMPARTS(2013,6,6),17,15,2.2,25,'Txapela feliz')
	 , ('Txakoli', DATEFROMPARTS(2015,6,6),21,330,1.8,30,'Txapela feliz')
	 , ('Antxoa', DATEFROMPARTS(2014,10,1),18,80,1.0,10,'Txapela feliz')
INSERT INTO EV_Regatas (nombre,f_inicio,intensidad_v,direccion_v,altura_olas,temp_max,nombre_campo)
     VALUES ('Freixenet', DATEFROMPARTS(2014,7,6),16,10,0.4,38,'Golfo de Roses')
	 , ('Freixenet', DATEFROMPARTS(2013,7,6),17,15,1.2,32,'Golfo de Roses')
	 , ('Freixenet', DATEFROMPARTS(2015,7,6),21,100,0.8,35,'Golfo de Roses')
	 , ('Caganet', DATEFROMPARTS(2015,1,12),18,80,1.0,14,'Golfo de Roses')
GO



/****** Object:  Table [dbo].[EV_Monitores]    Script Date: 03/05/2015 13:43:32 ******/

CREATE TABLE EV_Monitores(
	licencia_federativa int NOT NULL,
	SS char(12) NOT NULL,
	DI char(9) NOT NULL,
	tel_f char(12) NULL,
	tel_m char(12) NULL,
	categoria char(1) NOT NULL,
	CONSTRAINT PK__EV_Monitores PRIMARY KEY (licencia_federativa),
	CONSTRAINT CK__EV_MonitoresCategorias CHECK  (categoria IN ('C','B','A'))
)

GO
INSERT EV_Monitores (licencia_federativa, SS, DI, tel_f, tel_m, categoria) VALUES (207, '111         ', '111      ', '954123654   ', '654789654   ', 'A')
, (307, '222         ', '222      ', '954789852   ', '666444789   ', 'B')
, (407, '123         ', '123      ', '987451235   ', '658741123   ', 'C')
, (507, '456         ', '456      ', '958741233   ', '665444178   ', 'B')
, (607, '333         ', '333      ', '998748875   ', '655441778   ', 'A')

/****** Object:  Table [dbo].[EV_Barcos]    Script Date: 03/05/2015 13:43:32 ******/

CREATE TABLE EV_Barcos(
	n_vela int NOT NULL,
	nombre varchar(20) NOT NULL,
	f_adquisicion Smalldatetime NOT NULL CONSTRAINT DF_EV_Barcos_fecha  DEFAULT (getdate()) ,
	color varchar(10) NOT NULL CONSTRAINT [DF_EV_Barcos_color]  DEFAULT ('blanco'),
	material varchar(20) NOT NULL CONSTRAINT DF_EV_Barcos_material  DEFAULT ('PRFV'),
	estado_conservacion smallint NULL,
	nombre_clase char(15) NULL,
	CONSTRAINT PK__EV_Barco PRIMARY KEY (n_vela),
	CONSTRAINT CK__EV_Barcos__estado CHECK  (estado_conservacion BETWEEN 0 and 10),
	CONSTRAINT CK__EV_Barcos__f_adq CHECK  (([f_adquisicion] < getdate())),
	CONSTRAINT FK__EV_BarcosClases FOREIGN KEY(nombre_clase) REFERENCES EV_Clases (nombre)
)

GO
INSERT EV_Barcos (n_vela, nombre, f_adquisicion, color, material, estado_conservacion, nombre_clase) VALUES (1001, N'Txipiron', CAST(0x94B10000 AS SmallDateTime), 'blanco', N'PRFV', 7, N'470            ')
, (1002, 'Breca', CAST(0x92220000 AS SmallDateTime), 'blanco', 'PRFV', 5, N'470            ')
, (1004, 'Mojarra', CAST(0x94280000 AS SmallDateTime), 'blanco', 'PRFV', 6, N'470            ')
, (1101, 'Libertad', CAST(0x91220000 AS SmallDateTime), 'blanco', 'PRFV', 7, N'Laser          ')
, (1102, 'Igualdad', CAST(0x8F900000 AS SmallDateTime), 'Azul', 'PRFV', 4, N'Laser          ')
, (1103, 'Fraternidad', CAST(0x970C0000 AS SmallDateTime), 'blanco', 'PRFV', 9, N'Laser          ')
, (1200, 'Dumbledore', CAST(0x86800000 AS SmallDateTime), 'blanco', 'PRFV', 4, NULL)
INSERT EV_Barcos (n_vela, nombre, f_adquisicion, color, material, estado_conservacion, nombre_clase) VALUES (1201, 'Cohete', CAST(0x86C90000 AS SmallDateTime), 'blanco', 'PRFV', 6, NULL)
, (1300, 'Hermione', CAST(0x945D0000 AS SmallDateTime), 'Rojo', 'Madera', 3, NULL)
, (1301, 'Peach', CAST(0x7CF50000 AS SmallDateTime), 'Gris', 'Madera', 3, NULL)
, (1400, 'Pikachu', CAST(0x90C50000 AS SmallDateTime), 'Amarillo', 'PRFV', 8, N'Yngling        ')
, (1401, 'Harry Potter', CAST(0x91CF0000 AS SmallDateTime), 'Verde', 'PRFV', 9, N'Yngling        ')
, (1500, 'Super Mario', CAST(0x93740000 AS SmallDateTime), 'blanco', 'PRFV', 7, N'Tornado        ')
, (1600, 'Azur de puagg', CAST(0x918C0000 AS SmallDateTime), 'blanco', 'PRFV', 8, N'49er           ')

/****** Object:  Table [dbo].[EV_Cursos]    Script Date: 03/05/2015 13:43:32 ******/

CREATE TABLE EV_Cursos(
	codigo_curso int NOT NULL,
	denominacion varchar(20) NOT NULL,
	f_inicio date NOT NULL,
	duracion smallint NOT NULL,
	licencia int NOT NULL,
	CONSTRAINT PK_EV_Cursos PRIMARY KEY (codigo_curso),
	CONSTRAINT CK_Duracion CHECK  (duracion BETWEEN 5 and 300),
	CONSTRAINT FK__EV_CursosMonitores FOREIGN KEY(licencia) REFERENCES EV_Monitores (licencia_federativa)
)
GO
INSERT INTO EV_Cursos (codigo_curso,denominacion,f_inicio,duracion,licencia)
     VALUES (1,'Nudos marineros',DATEFROMPARTS(2015,4,1),10,407)
	 , (2,'Roles y nubes',DATEFROMPARTS(2014,10,11),30,207)
	 , (3,'Viradas',DATEFROMPARTS(2014,9,20),30,307)
	 , (4,'Roles y nubes II',DATEFROMPARTS(2014,3,12),30,207)
	 , (5,'Trasluchadas',DATEFROMPARTS(2015,1,17),30,407)
	 , (6,'Planear las olas',DATEFROMPARTS(2013,11,21),25,207)
	 , (7,'Supervivencia',DATEFROMPARTS(2015,9,26),45,307)
	 , (8,'Match race',DATEFROMPARTS(2015,2,20),90,407)
	 , (9,'Evitar el marcaje',DATEFROMPARTS(2014,10,13),30,607)
	 , (10,'Alimentación',DATEFROMPARTS(2015,3,22),40,307)
	 , (11,'Redes sociales',DATEFROMPARTS(2015,04,10),50,207)
	 , (12,'Uso del GPS',DATEFROMPARTS(2015,3,3),20,207)
GO



CREATE TABLE EV_Miembros_Barcos_Regatas(
	licencia_miembro int NOT NULL,
	n_vela int NOT NULL,
	f_inicio_regata date NOT NULL,
	patron Char(1) NOT NULL,
	CONSTRAINT PK_EV_MiembrosBarcosRegatas PRIMARY KEY (licencia_miembro,n_vela,f_inicio_regata) ,
	CONSTRAINT FK_MiembrosBarcosRegatas_Regatas FOREIGN KEY (f_inicio_regata) REFERENCES EV_Regatas (f_inicio),
	CONSTRAINT FK__EV_MiembrosBarcosRegatas_Miembros FOREIGN KEY(licencia_miembro) REFERENCES EV_Miembros (licencia_federativa),
	CONSTRAINT FK__EV_MiembrosBarcosRegatas_Barcos FOREIGN KEY(n_vela) REFERENCES EV_Barcos (n_vela)
) 
GO
INSERT INTO [dbo].[EV_Miembros_Barcos_Regatas]
           ([licencia_miembro]
           ,[n_vela]
           ,[f_inicio_regata]
           ,[patron])
SELECT M.licencia_federativa, B.n_vela, R.f_inicio, 'N' FROM EV_Barcos AS B CROSS JOIN EV_Miembros AS M CROSS JOIN EV_Regatas AS R

GO
-- Esta vista nos dice cuántos tripolantes van en cada barco
CREATE VIEW VTripulacion As 
	SELECT f_inicio_regata,n_vela,COUNT (*) As Tripulantes FROM EV_Miembros_Barcos_Regatas
		GROUP BY f_inicio_regata,n_vela 

GO

DECLARE CMBR CURSOR FOR SELECT licencia_miembro,n_vela,f_inicio_regata, NEWID() As ID
  FROM EV_Miembros_Barcos_Regatas
  ORDER By ID
DECLARE @Licencia int, @Vela int, @Fecha DATE, @TripuActual TinyInt, @TripuOficial TinyInt, @id uniqueidentifier
Open CMBR
FETCH NEXT FROM CMBR INTO @Licencia , @Vela, @Fecha, @id
WHILE @@FETCH_STATUS <> -1
BEGIN
	IF @@FETCH_STATUS = 0
	BEGIN
	-- Con esto evitamos que un barco lleve más tripulantes de lo que le corresponde
		SELECT @TripuActual = Tripulantes FROM VTripulacion WHERE f_inicio_regata = @Fecha AND n_vela = @Vela
		SELECT @TripuOficial = Tripulantes FROM EV_Clases AS C JOIN EV_Barcos AS B ON C.nombre = B.nombre_clase Where n_vela = @Vela
		IF @TripuActual > @TripuOficial
			DELETE EV_Miembros_Barcos_Regatas WHERE Current Of CMBR
	END
	FETCH NEXT FROM CMBR INTO @Licencia , @Vela, @Fecha, @id
END
CLOSE CMBR
DEALLOCATE CMBR
GO

CREATE TABLE EV_Miembros_Cursos(
	licencia_federativa int NOT NULL,
	codigo_curso int NOT NULL,
	CONSTRAINT PK_EV_MiembrosCursos PRIMARY KEY (licencia_federativa,codigo_curso),
	CONSTRAINT FK_MiembrosCursos_Cursos FOREIGN KEY(codigo_curso) REFERENCES EV_Cursos (codigo_curso),
	CONSTRAINT FK__EV_MiembrosCursos_Miembros FOREIGN KEY(licencia_federativa) REFERENCES EV_Miembros (licencia_federativa)
)
GO
INSERT INTO EV_Miembros_Cursos (licencia_federativa,codigo_curso)
     VALUES (101,1), (101,2), (101,4), (101,6), (101,8), (101,9), (101,10)
	 , (200,1), (200,2), (200,3), (200,7), (200,8), (200,9), (200,10)
	 , (207,3), (207,5),(207,10)
	 , (214,2), (214,3), (214,5), (214,6), (214,9), (214,10), (214,11), (214,12)
INSERT INTO EV_Miembros_Cursos (licencia_federativa,codigo_curso) 
	VALUES (220,1), (220,4), (220,6), (220,7), (220,8), (220,9), (220,11), (220,12)
	 , (234,1), (234,2), (234,5), (234,6), (234,8), (234,11), (234,9), (234,12)
	 , (245,2), (245,3), (245,4), (245,6), (245,8), (245,10), (245,11), (245,12)
INSERT INTO EV_Miembros_Cursos (licencia_federativa,codigo_curso) 
	VALUES (440,1), (440,2), (440,3), (440,4), (440,5), (440,6), (440,7), (440,8)
	 , (516,5), (516,6), (516,7), (516,8), (516,9), (516,10), (516,11), (516,12)
	 , (736,2), (736,4), (736,6), (736,8), (736,9), (736,10), (736,11), (736,12)
	 , (407,9), (407,10), (407,11), (407,12)


ALTER TABLE EV_Monitores ADD  CONSTRAINT FK__EV_MonitoresMiembros FOREIGN KEY(licencia_federativa)
REFERENCES EV_Miembros (licencia_federativa)
GO
USE master
