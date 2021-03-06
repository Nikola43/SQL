IF DB_ID('TransLeo') IS NULL
	CREATE DATABASE TransLeo
GO
USE TransLeo
/****** Object:  Table [dbo].[TL_PaquetesNormales]    Script Date: 03/05/2016 14:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TL_PaquetesNormales(
	Codigo int NOT NULL CONSTRAINT PK_Codigo PRIMARY KEY,
	Alto int NOT NULL,
	Ancho int NOT NULL,
	Largo int NOT NULL,
	codigoFregoneta int NULL,
	fechaEntrega smalldatetime NULL,
)

GO
SET DateFormat YMD
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (600, 30, 12, 34, 1, CAST(N'2012-01-20 14:50:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (601, 10, 6, 39, 3, CAST(N'2013-03-14 08:00:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (602, 30, 120, 60, 8, CAST(N'2014-07-31 12:30:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (603, 46, 58, 96, 9, CAST(N'2015-09-06 13:40:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (1001, 15, 20, 70, 6, CAST(N'2015-04-03 08:40:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (1002, 25, 40, 40, 6, CAST(N'2015-04-01 11:50:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (1003, 20, 140, 140, 6, CAST(N'2015-04-01 11:30:00' AS SmallDateTime))
INSERT [dbo].[TL_PaquetesNormales] ([Codigo], [Alto], [Ancho], [Largo], [codigoFregoneta], [fechaEntrega]) VALUES (1004, 50, 85, 60, 6, CAST(N'2015-04-01 11:20:00' AS SmallDateTime))
