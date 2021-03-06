USE [master]
GO
/****** Object:  Database [AirLeo]    Script Date: 30/03/2017 14:33:13 ******/
CREATE DATABASE [AirLeo]

GO
USE [AirLeo]
SET DateFormat ymd
GO

/****** Object:  Table [dbo].[AL_Aeropuertos]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Aeropuertos](
	[Codigo] [char](3) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Ciudad] [varchar](30) NOT NULL,
	[Pais] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Aeropuerto] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Aviones]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Aviones](
	[Matricula] [char](10) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[ID_Fabricante] [tinyint] NOT NULL,
	[Modelo] [varchar](25) NOT NULL,
	[Fecha_Fabricacion] [date] NULL,
	[Fecha_Entrada] [date] NULL,
	[Filas] [smallint] NOT NULL,
	[Asientos_x_Fila] [tinyint] NOT NULL,
	[Autonomia] [int] NULL,
 CONSTRAINT [PK_Aviones] PRIMARY KEY CLUSTERED 
(
	[Matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Distancias]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Distancias](
	[Origen] [char](3) NOT NULL,
	[Destino] [char](3) NOT NULL,
	[Distancia] [decimal](7, 2) NOT NULL,
 CONSTRAINT [PK_Distancias] PRIMARY KEY CLUSTERED 
(
	[Origen] ASC,
	[Destino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Fabricantes]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Fabricantes](
	[ID_Fabricante] [tinyint] NOT NULL,
	[Nombre] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Fabricantes] PRIMARY KEY CLUSTERED 
(
	[ID_Fabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Pasajeros]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Pasajeros](
	[ID] [char](9) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[Direccion] [varchar](60) NOT NULL,
	[Fecha_Nacimiento] [date] NOT NULL,
	[Nacionalidad] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Pasajes]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Pasajes](
	[Numero] [int] IDENTITY(1,1) NOT NULL,
	[ID_Pasajero] [char](9) NOT NULL,
 CONSTRAINT [PK_Pasajes] PRIMARY KEY CLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Tarjetas]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Tarjetas](
	[Codigo_Vuelo] [int] NOT NULL,
	[Fila_Asiento] [smallint] NOT NULL,
	[Letra_Asiento] [char](1) NOT NULL,
	[Numero_Pasaje] [int] NULL,
	[Peso_Equipaje] [decimal](3, 1) NULL,
 CONSTRAINT [PK_Tarjetas] PRIMARY KEY CLUSTERED 
(
	[Codigo_Vuelo] ASC,
	[Fila_Asiento] ASC,
	[Letra_Asiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Vuelos]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Vuelos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Aeropuerto_Salida] [char](3) NOT NULL,
	[Aeropuerto_Llegada] [char](3) NOT NULL,
	[Salida] [smalldatetime] NOT NULL,
	[Llegada] [smalldatetime] NOT NULL,
	[Matricula_Avion] [char](10) NOT NULL,
	[Precio_Pasaje] [smallmoney] NULL,
 CONSTRAINT [PK_Vuelos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AL_Vuelos_Pasajes]    Script Date: 30/03/2017 14:33:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_Vuelos_Pasajes](
	[Codigo_Vuelo] [int] NOT NULL,
	[Numero_Pasaje] [int] NOT NULL,
	[Embarcado] [char](1) NOT NULL DEFAULT ('N'),
 CONSTRAINT [PK_VuelosPasajes] PRIMARY KEY CLUSTERED 
(
	[Codigo_Vuelo] ASC,
	[Numero_Pasaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'AGP', N'Pablo Ruiz Picasso', N'Málaga', N'España')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'APA', N'Centennial', N'Denver', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'BCN', N'El Prat', N'Barcelona', N'España')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'CAI', N'El Cairo', N'El Cairo', N'Egipto')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'CDG', N'Charles de Gaulle', N'Paris', N'Francia')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'CVG', N'Cincinnati/Kentucky Norte', N'Cincinnati', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'FCO', N'Leonardo da Vinci', N'Roma', N'Italia')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'JFK', N'John F. Kennedy', N'New York', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'LGA', N'La Guardia', N'New York', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'LHR', N'Heathrow', N'Londres', N'Reino Unido')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'MAD', N'Barajas', N'Madrid', N'España')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'MIA', N'Miami', N'Miami', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'NRT', N'Narita', N'Tokio', N'Japón')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'PMI', N'Son San Joan', N'Palma de Mallorca', N'España')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'SDF', N'Louisville', N'Louisville', N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'SVQ', N'San Pablo', N'Sevilla', N'España')
GO
INSERT [dbo].[AL_Aeropuertos] ([Codigo], [Nombre], [Ciudad], [Pais]) VALUES (N'TXL', N'Otto Lilienthal', N'Berlin', N'Alemania')
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'ESP2345   ', N'Rayo', 2, N'A320', CAST(N'2001-03-20' AS Date), CAST(N'2001-04-15' AS Date), 25, 6, 3500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'ESP4502   ', N'Argonauta', 2, N'A320', CAST(N'2002-05-20' AS Date), CAST(N'2002-08-15' AS Date), 25, 6, 2500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'ESP5077   ', N'Plus Ultra', 3, N'B747', CAST(N'2001-09-27' AS Date), CAST(N'2002-03-25' AS Date), 42, 10, 6500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'ESP8067   ', N'Santísima Trinidad', 3, N'B737', CAST(N'2001-01-24' AS Date), CAST(N'2001-02-18' AS Date), 22, 6, 3200)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'FRA0955   ', N'Bucentaure', 3, N'B747', CAST(N'2005-09-27' AS Date), CAST(N'2005-11-25' AS Date), 42, 10, 6500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'FRA4502   ', N'Acheron', 2, N'A320', CAST(N'2002-05-24' AS Date), CAST(N'2002-07-11' AS Date), 25, 6, 2500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'FRA5021   ', N'Redoutable', 2, N'A320', CAST(N'2002-05-20' AS Date), CAST(N'2002-08-15' AS Date), 25, 6, 2500)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'GBR2574   ', N'God save the Queen', 13, N'YAK-42', NULL, NULL, 25, 4, NULL)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA174136 ', N'Montana', 3, N'B737', CAST(N'2010-05-02' AS Date), CAST(N'2010-06-20' AS Date), 24, 6, 3300)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA174137 ', N'Idaho', 3, N'B737', CAST(N'2010-05-03' AS Date), CAST(N'2010-06-20' AS Date), 24, 6, 3300)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA174138 ', N'Arkansas', 3, N'B737', CAST(N'2010-05-04' AS Date), CAST(N'2010-06-20' AS Date), 24, 6, 3300)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA174139 ', N'Nebraska', 3, N'B737', CAST(N'2010-05-05' AS Date), CAST(N'2010-06-20' AS Date), 24, 6, 3300)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA174140 ', N'North Carolina', 3, N'B737', CAST(N'2010-05-03' AS Date), CAST(N'2010-06-20' AS Date), 24, 6, 3300)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA5068   ', N'Enola Gay', 3, N'B737', CAST(N'2004-03-20' AS Date), CAST(N'2004-04-15' AS Date), 24, 6, 2700)
GO
INSERT [dbo].[AL_Aviones] ([Matricula], [Nombre], [ID_Fabricante], [Modelo], [Fecha_Fabricacion], [Fecha_Entrada], [Filas], [Asientos_x_Fila], [Autonomia]) VALUES (N'USA5077   ', N'Spirit of St Louis', 3, N'B747', CAST(N'2002-01-27' AS Date), CAST(N'2002-03-15' AS Date), 42, 10, 6500)
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'APA', CAST(5138.35 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'BCN', CAST(6573.60 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'CAI', CAST(2100.45 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'CDG', CAST(1641.66 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'CVG', CAST(3651.31 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'FCO', CAST(540.02 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'JFK', CAST(3650.06 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'LGA', CAST(3651.08 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'LHR', CAST(7062.16 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'MAD', CAST(267.35 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'MIA', CAST(4426.90 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'NRT', CAST(6946.65 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'PMI', CAST(440.63 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'SDF', CAST(9160.50 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'SVQ', CAST(93.62 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'AGP', N'TXL', CAST(8362.38 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'BCN', CAST(251.80 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'CAI', CAST(6861.38 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'CDG', CAST(414.73 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'CVG', CAST(8327.06 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'FCO', CAST(10160.73 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'JFK', CAST(1634.15 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'LGA', CAST(1628.63 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'LHR', CAST(8478.24 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'MAD', CAST(5017.13 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'MIA', CAST(1706.40 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'NRT', CAST(5784.31 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'PMI', CAST(5315.16 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'SDF', CAST(5392.58 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'SVQ', CAST(5044.87 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'APA', N'TXL', CAST(7490.01 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'CAI', CAST(8525.93 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'CDG', CAST(6663.45 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'CVG', CAST(5225.61 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'FCO', CAST(5492.03 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'JFK', CAST(4948.15 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'LGA', CAST(9878.39 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'LHR', CAST(9204.50 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'MAD', CAST(8664.64 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'MIA', CAST(4754.19 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'NRT', CAST(8716.76 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'PMI', CAST(7255.93 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'SDF', CAST(10034.51 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'SVQ', CAST(5441.38 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'BCN', N'TXL', CAST(4912.26 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'CDG', CAST(3459.35 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'CVG', CAST(2542.17 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'FCO', CAST(1052.12 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'JFK', CAST(5599.47 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'LGA', CAST(5598.25 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'LHR', CAST(4418.35 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'MAD', CAST(2075.93 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'MIA', CAST(6488.21 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'NRT', CAST(5967.87 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'PMI', CAST(1736.64 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'SDF', CAST(7463.53 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'SVQ', CAST(2179.63 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CAI', N'TXL', CAST(9431.89 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'CVG', CAST(3650.87 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'FCO', CAST(7146.62 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'JFK', CAST(563.12 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'LGA', CAST(2445.73 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'LHR', CAST(4701.46 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'MAD', CAST(4992.77 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'MIA', CAST(871.15 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'NRT', CAST(4294.27 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'PMI', CAST(9008.56 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'SDF', CAST(1128.54 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'SVQ', CAST(9520.43 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CDG', N'TXL', CAST(1139.65 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'FCO', CAST(4928.85 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'JFK', CAST(3443.10 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'LGA', CAST(925.12 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'LHR', CAST(4707.87 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'MAD', CAST(8033.30 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'MIA', CAST(4920.93 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'NRT', CAST(904.63 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'PMI', CAST(1668.63 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'SDF', CAST(3945.25 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'SVQ', CAST(649.41 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'CVG', N'TXL', CAST(4989.88 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'JFK', CAST(9404.46 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'LGA', CAST(5610.33 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'LHR', CAST(9662.40 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'MAD', CAST(1457.22 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'MIA', CAST(1801.15 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'NRT', CAST(8828.20 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'PMI', CAST(3191.06 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'SDF', CAST(1874.51 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'SVQ', CAST(3721.67 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'FCO', N'TXL', CAST(2440.18 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'LGA', CAST(10.19 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'LHR', CAST(8752.90 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'MAD', CAST(3580.83 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'MIA', CAST(1090.74 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'NRT', CAST(6731.61 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'PMI', CAST(3907.77 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'SDF', CAST(9031.10 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'SVQ', CAST(3557.33 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'JFK', N'TXL', CAST(5674.93 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'LHR', CAST(6504.47 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'MAD', CAST(3581.00 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'MIA', CAST(1097.67 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'NRT', CAST(6721.42 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'PMI', CAST(3907.65 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'SDF', CAST(5572.84 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'SVQ', CAST(3558.30 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LGA', N'TXL', CAST(4177.01 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'MAD', CAST(8762.49 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'MIA', CAST(6142.12 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'NRT', CAST(8673.13 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'PMI', CAST(10033.56 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'SDF', CAST(5517.23 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'SVQ', CAST(9858.69 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'LHR', N'TXL', CAST(2260.36 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'MIA', CAST(4415.50 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'NRT', CAST(6691.98 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'PMI', CAST(339.29 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'SDF', CAST(8822.14 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'SVQ', CAST(244.20 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MAD', N'TXL', CAST(1626.71 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MIA', N'NRT', CAST(7425.80 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MIA', N'PMI', CAST(4754.02 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MIA', N'SDF', CAST(9765.05 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MIA', N'SVQ', CAST(4339.50 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'MIA', N'TXL', CAST(1051.26 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'NRT', N'PMI', CAST(6574.09 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'NRT', N'SDF', CAST(9179.19 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'NRT', N'SVQ', CAST(6935.88 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'NRT', N'TXL', CAST(9779.75 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'PMI', N'SDF', CAST(7898.57 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'PMI', N'SVQ', CAST(489.01 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'PMI', N'TXL', CAST(375.96 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'SDF', N'SVQ', CAST(1231.68 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'SDF', N'TXL', CAST(10025.43 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Distancias] ([Origen], [Destino], [Distancia]) VALUES (N'SVQ', N'TXL', CAST(8422.95 AS Decimal(7, 2)))
GO
INSERT [dbo].[AL_Fabricantes] ([ID_Fabricante], [Nombre]) VALUES (2, N'Airbus')
GO
INSERT [dbo].[AL_Fabricantes] ([ID_Fabricante], [Nombre]) VALUES (3, N'Boeing')
GO
INSERT [dbo].[AL_Fabricantes] ([ID_Fabricante], [Nombre]) VALUES (13, N'Yakolev')
GO
INSERT [dbo].[AL_Fabricantes] ([ID_Fabricante], [Nombre]) VALUES (16, N'Flying bricks')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A003     ', N'Alberto', N'Benítez', N'Un sitio cualquiera', CAST(N'1985-04-01' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A007     ', N'Rafael', N'Pi', N'Un sitio cualquiera', CAST(N'1980-04-15' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A008     ', N'Walter', N'Smith', N'Un sitio cualquiera', CAST(N'1978-02-14' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A011     ', N'Jean', N'Dulac', N'Un sitio cualquiera', CAST(N'1984-03-30' AS Date), N'Francia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A013     ', N'Drazen', N'Tontolculic', N'Un sitio cualquiera', CAST(N'1970-02-10' AS Date), N'Yugoslavia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A015     ', N'Justo', N'Gamarra', N'Un sitio cualquiera', CAST(N'1972-05-31' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A017     ', N'Rafael', N'García', N'Un sitio cualquiera', CAST(N'1968-04-05' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A018     ', N'Michael', N'De Luna', N'Un sitio cualquiera', CAST(N'1984-09-14' AS Date), N'Alemania')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A023     ', N'Esteban', N'López', N'Un sitio cualquiera', CAST(N'1985-12-04' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A029     ', N'Justiniano', N'Gama', N'Un sitio cualquiera', CAST(N'1971-04-06' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A055     ', N'Daniel', N'Cruz', N'Un sitio cualquiera', CAST(N'1985-08-25' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'A081     ', N'Roberto', N'Guterres', N'Un sitio cualquiera', CAST(N'1977-09-05' AS Date), N'Portugal')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B003     ', N'Antonio', N'Rodríguez', N'Un sitio cualquiera', CAST(N'1981-09-30' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B007     ', N'Juan', N'López', N'Un sitio cualquiera', CAST(N'1990-02-24' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B008     ', N'Michael', N'Smith', N'Un sitio cualquiera', CAST(N'1973-10-04' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B011     ', N'Marc', N'Dubois', N'Un sitio cualquiera', CAST(N'1989-03-26' AS Date), N'Francia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B019     ', N'Justiniano', N'Gamarra', N'Un sitio cualquiera', CAST(N'1967-06-20' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'B028     ', N'Daniel', N'García', N'Un sitio cualquiera', CAST(N'1987-03-29' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C003     ', N'Antonio', N'Benítez', N'Un sitio cualquiera', CAST(N'1982-12-22' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C008     ', N'Joseph', N'Smith', N'Un sitio cualquiera', CAST(N'1992-08-23' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C011     ', N'René', N'Dubois', N'Un sitio cualquiera', CAST(N'1994-04-24' AS Date), N'Francia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C015     ', N'Justo', N'Pino', N'Un sitio cualquiera', CAST(N'1970-03-01' AS Date), N'Italia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C017     ', N'Rafael', N'García', N'Un sitio cualquiera', CAST(N'1975-03-13' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'C020     ', N'Rafael', N'López', N'Un sitio cualquiera', CAST(N'1970-08-27' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S011     ', N'Michael', N'Grün', N'Un sitio cualquiera', CAST(N'1994-01-16' AS Date), N'Alemania')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S013     ', N'Doran', N'Tracevic', N'Un sitio cualquiera', CAST(N'1971-04-22' AS Date), N'Yugoslavia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S019     ', N'Joao', N'Da Silva', N'Un sitio cualquiera', CAST(N'1981-11-28' AS Date), N'Portugal')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S058     ', N'Ariel', N'Muñoz', N'Un sitio cualquiera', CAST(N'1994-04-28' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S069     ', N'Stephen', N'King', N'Un sitio cualquiera', CAST(N'1983-10-17' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'S087     ', N'Esteban', N'López', N'Un sitio cualquiera', CAST(N'1970-03-26' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T002     ', N'André', N'Galois', N'Un sitio cualquiera', CAST(N'1992-12-19' AS Date), N'Francia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T003     ', N'Antonio', N'Benítez', N'Un sitio cualquiera', CAST(N'1980-02-12' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T007     ', N'Rafael', N'López', N'Un sitio cualquiera', CAST(N'1979-09-18' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T008     ', N'Walter', N'Smith', N'Un sitio cualquiera', CAST(N'1993-06-11' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T011     ', N'Alain', N'Dubois', N'Un sitio cualquiera', CAST(N'1971-01-09' AS Date), N'Francia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T015     ', N'Justo', N'Gamarra', N'Un sitio cualquiera', CAST(N'1988-07-08' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T017     ', N'Rafael', N'García', N'Un sitio cualquiera', CAST(N'1981-10-18' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T107     ', N'Esteban', N'López', N'Un sitio cualquiera', CAST(N'1986-03-18' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T113     ', N'Andro', N'Tontolculic', N'Un sitio cualquiera', CAST(N'1991-02-09' AS Date), N'Yugoslavia')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T118     ', N'Michael', N'Portillo', N'Un sitio cualquiera', CAST(N'1979-09-25' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T131     ', N'Pedro', N'Da Silva', N'Un sitio cualquiera', CAST(N'1991-02-06' AS Date), N'Portugal')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T139     ', N'Justiniano', N'Gamarra', N'Un sitio cualquiera', CAST(N'1981-10-13' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T158     ', N'Daniel', N'Muñoz', N'Un sitio cualquiera', CAST(N'1978-08-06' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T215     ', N'Justin', N'Garrafeichon', N'Un sitio cualquiera', CAST(N'1991-11-27' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T217     ', N'José', N'Da Silva', N'Un sitio cualquiera', CAST(N'1980-05-17' AS Date), N'Portugal')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T225     ', N'Rafael', N'Navarro', N'Un sitio cualquiera', CAST(N'1983-11-29' AS Date), N'España')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T228     ', N'Andrew', N'Smith', N'Un sitio cualquiera', CAST(N'1984-08-29' AS Date), N'Estados Unidos de América')
GO
INSERT [dbo].[AL_Pasajeros] ([ID], [Nombre], [Apellidos], [Direccion], [Fecha_Nacimiento], [Nacionalidad]) VALUES (N'T261     ', N'Alain', N'Dubois', N'Un sitio cualquiera', CAST(N'1982-03-04' AS Date), N'Canadá')
GO
SET IDENTITY_INSERT [dbo].[AL_Pasajes] ON 

GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (1, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (2, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (3, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (4, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (5, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (6, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (7, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (8, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (9, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (10, N'A003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (11, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (12, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (13, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (14, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (15, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (16, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (17, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (18, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (19, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (20, N'A007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (21, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (22, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (23, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (24, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (25, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (26, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (27, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (28, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (29, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (30, N'A008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (31, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (32, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (33, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (34, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (35, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (36, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (37, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (38, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (39, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (40, N'A011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (41, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (42, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (43, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (44, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (45, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (46, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (47, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (48, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (49, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (50, N'A013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (51, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (52, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (53, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (54, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (55, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (56, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (57, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (58, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (59, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (60, N'A015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (61, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (62, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (63, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (64, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (65, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (66, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (67, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (68, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (69, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (70, N'A017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (71, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (72, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (73, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (74, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (75, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (76, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (77, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (78, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (79, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (80, N'A018     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (81, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (82, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (83, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (84, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (85, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (86, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (87, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (88, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (89, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (90, N'A023     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (91, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (92, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (93, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (94, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (95, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (96, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (97, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (98, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (99, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (100, N'A029     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (101, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (102, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (103, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (104, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (105, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (106, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (107, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (108, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (109, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (110, N'A055     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (111, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (112, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (113, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (114, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (115, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (116, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (117, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (118, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (119, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (120, N'A081     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (121, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (122, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (123, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (124, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (125, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (126, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (127, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (128, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (129, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (130, N'B003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (131, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (132, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (133, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (134, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (135, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (136, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (137, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (138, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (139, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (140, N'B007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (141, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (142, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (143, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (144, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (145, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (146, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (147, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (148, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (149, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (150, N'B008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (151, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (152, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (153, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (154, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (155, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (156, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (157, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (158, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (159, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (160, N'B011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (161, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (162, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (163, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (164, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (165, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (166, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (167, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (168, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (169, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (170, N'B019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (171, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (172, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (173, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (174, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (175, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (176, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (177, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (178, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (179, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (180, N'B028     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (181, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (182, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (183, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (184, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (185, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (186, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (187, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (188, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (189, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (190, N'C003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (191, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (192, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (193, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (194, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (195, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (196, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (197, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (198, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (199, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (200, N'C008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (201, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (202, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (203, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (204, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (205, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (206, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (207, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (208, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (209, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (210, N'C011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (211, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (212, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (213, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (214, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (215, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (216, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (217, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (218, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (219, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (220, N'C015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (221, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (222, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (223, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (224, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (225, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (226, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (227, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (228, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (229, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (230, N'C017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (231, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (232, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (233, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (234, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (235, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (236, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (237, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (238, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (239, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (240, N'C020     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (241, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (242, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (243, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (244, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (245, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (246, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (247, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (248, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (249, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (250, N'S011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (251, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (252, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (253, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (254, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (255, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (256, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (257, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (258, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (259, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (260, N'S013     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (261, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (262, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (263, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (264, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (265, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (266, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (267, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (268, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (269, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (270, N'S019     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (271, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (272, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (273, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (274, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (275, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (276, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (277, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (278, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (279, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (280, N'S058     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (281, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (282, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (283, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (284, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (285, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (286, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (287, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (288, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (289, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (290, N'S069     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (291, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (292, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (293, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (294, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (295, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (296, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (297, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (298, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (299, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (300, N'S087     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (301, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (302, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (303, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (304, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (305, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (306, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (307, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (308, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (309, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (310, N'T002     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (311, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (312, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (313, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (314, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (315, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (316, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (317, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (318, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (319, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (320, N'T003     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (321, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (322, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (323, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (324, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (325, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (326, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (327, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (328, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (329, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (330, N'T007     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (331, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (332, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (333, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (334, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (335, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (336, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (337, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (338, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (339, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (340, N'T008     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (341, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (342, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (343, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (344, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (345, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (346, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (347, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (348, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (349, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (350, N'T011     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (351, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (352, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (353, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (354, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (355, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (356, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (357, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (358, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (359, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (360, N'T015     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (361, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (362, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (363, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (364, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (365, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (366, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (367, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (368, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (369, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (370, N'T017     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (371, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (372, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (373, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (374, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (375, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (376, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (377, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (378, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (379, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (380, N'T107     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (381, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (382, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (383, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (384, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (385, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (386, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (387, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (388, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (389, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (390, N'T113     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (391, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (392, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (393, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (394, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (395, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (396, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (397, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (398, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (399, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (400, N'T118     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (401, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (402, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (403, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (404, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (405, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (406, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (407, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (408, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (409, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (410, N'T131     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (411, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (412, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (413, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (414, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (415, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (416, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (417, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (418, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (419, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (420, N'T139     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (421, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (422, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (423, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (424, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (425, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (426, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (427, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (428, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (429, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (430, N'T158     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (431, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (432, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (433, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (434, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (435, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (436, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (437, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (438, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (439, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (440, N'T215     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (441, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (442, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (443, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (444, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (445, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (446, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (447, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (448, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (449, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (450, N'T217     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (451, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (452, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (453, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (454, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (455, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (456, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (457, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (458, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (459, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (460, N'T225     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (461, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (462, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (463, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (464, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (465, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (466, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (467, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (468, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (469, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (470, N'T228     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (471, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (472, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (473, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (474, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (475, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (476, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (477, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (478, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (479, N'T261     ')
GO
INSERT [dbo].[AL_Pasajes] ([Numero], [ID_Pasajero]) VALUES (480, N'T261     ')
GO
SET IDENTITY_INSERT [dbo].[AL_Pasajes] OFF
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 1, N'F', 209, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 2, N'A', 96, CAST(16.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 2, N'C', 278, CAST(19.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 3, N'F', 80, CAST(15.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 4, N'F', 160, CAST(12.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 5, N'B', 62, CAST(10.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 6, N'A', 180, CAST(17.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 6, N'B', 78, CAST(28.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 6, N'C', 265, CAST(22.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 6, N'E', 300, CAST(17.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 8, N'F', 22, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 9, N'E', 31, CAST(23.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 9, N'F', 118, CAST(10.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 11, N'E', 46, CAST(10.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 14, N'B', 44, CAST(24.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 18, N'A', 258, CAST(23.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 19, N'F', 15, CAST(17.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 20, N'C', 341, CAST(12.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 20, N'D', 36, CAST(19.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 22, N'E', 444, CAST(18.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 23, N'C', 428, CAST(18.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 23, N'E', 75, CAST(13.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (1, 23, N'F', 273, CAST(19.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 1, N'B', 237, CAST(28.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 2, N'D', 430, CAST(22.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 2, N'F', 467, CAST(29.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 4, N'A', 23, CAST(13.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 4, N'E', 234, CAST(24.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 5, N'A', 383, CAST(15.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 5, N'B', 356, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 5, N'F', 373, CAST(11.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 7, N'D', 293, CAST(21.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 7, N'E', 314, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 12, N'B', 292, CAST(18.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 12, N'E', 129, CAST(20.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 13, N'F', 267, CAST(21.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 17, N'B', 38, CAST(29.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 17, N'D', 185, CAST(25.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 17, N'F', 125, CAST(21.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 19, N'A', 156, CAST(13.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 19, N'D', 171, CAST(24.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 21, N'A', 342, CAST(11.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 22, N'E', 358, CAST(20.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 22, N'F', 26, CAST(12.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 23, N'C', 98, CAST(24.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (2, 23, N'D', 352, CAST(16.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 3, N'D', 332, CAST(28.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 5, N'B', 193, CAST(23.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 5, N'E', 187, CAST(20.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 6, N'B', 446, CAST(14.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 7, N'J', 10, CAST(29.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 8, N'E', 266, CAST(18.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 11, N'F', 475, CAST(26.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 11, N'H', 434, CAST(21.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 15, N'A', 302, CAST(29.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 15, N'D', 396, CAST(29.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 15, N'H', 466, CAST(26.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 19, N'I', 220, CAST(23.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 22, N'C', 459, CAST(22.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 23, N'A', 122, CAST(20.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 23, N'D', 165, CAST(25.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 30, N'I', 37, CAST(19.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 31, N'E', 426, CAST(15.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 32, N'F', 146, CAST(19.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 41, N'I', 222, CAST(14.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (3, 42, N'H', 349, CAST(13.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 1, N'A', 145, CAST(18.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 2, N'B', 59, CAST(18.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 3, N'C', 452, CAST(19.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 5, N'C', 81, CAST(14.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 8, N'E', 277, CAST(29.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 8, N'F', 54, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 10, N'E', 367, CAST(21.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 11, N'A', 291, CAST(14.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 12, N'A', 8, CAST(29.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 13, N'B', 19, CAST(21.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 14, N'D', 205, CAST(23.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 17, N'A', 83, CAST(17.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 17, N'F', 326, CAST(24.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 18, N'D', 346, CAST(15.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 19, N'B', 20, CAST(27.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 20, N'B', 161, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 20, N'E', 413, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 22, N'D', 106, CAST(23.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 22, N'E', 422, CAST(12.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 23, N'A', 214, CAST(21.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (4, 24, N'F', 119, CAST(18.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 1, N'B', 79, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 2, N'A', 24, CAST(24.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 2, N'D', 94, CAST(25.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 4, N'C', 405, CAST(19.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 5, N'F', 202, CAST(24.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 7, N'E', 179, CAST(22.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 8, N'D', 89, CAST(10.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 11, N'C', 372, CAST(16.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 12, N'D', 162, CAST(15.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 12, N'E', 70, CAST(14.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 13, N'B', 360, CAST(21.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 15, N'A', 113, CAST(22.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 15, N'F', 262, CAST(11.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 17, N'F', 414, CAST(19.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 18, N'C', 43, CAST(28.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 20, N'B', 53, CAST(13.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 21, N'D', 436, CAST(20.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 22, N'A', 307, CAST(28.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 22, N'E', 418, CAST(16.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (5, 23, N'E', 283, CAST(27.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 1, N'B', 13, CAST(14.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 1, N'D', 295, CAST(17.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 2, N'B', 315, CAST(29.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 2, N'E', 305, CAST(22.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 3, N'C', 441, CAST(29.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 3, N'E', 390, CAST(13.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 5, N'E', 355, CAST(13.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 6, N'E', 223, CAST(19.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 6, N'F', 478, CAST(11.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 9, N'A', 435, CAST(12.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 9, N'F', 250, CAST(19.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 10, N'A', 2, CAST(14.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 10, N'D', 270, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 10, N'E', 387, CAST(22.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 12, N'D', 317, CAST(26.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 12, N'F', 261, CAST(18.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 14, N'A', 294, CAST(22.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 14, N'C', 164, CAST(25.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 14, N'F', 381, CAST(15.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 16, N'D', 142, CAST(13.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 18, N'A', 327, CAST(20.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 18, N'C', 64, CAST(16.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 19, N'B', 14, CAST(27.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 19, N'F', 285, CAST(12.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 20, N'C', 114, CAST(24.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (6, 21, N'C', 248, CAST(14.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 2, N'C', 296, CAST(11.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 4, N'A', 334, CAST(15.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 7, N'A', 192, CAST(17.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 9, N'C', 325, CAST(19.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 12, N'A', 279, CAST(27.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 12, N'B', 45, CAST(22.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 12, N'E', 56, CAST(14.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 13, N'B', 421, CAST(23.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 14, N'D', 402, CAST(20.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 15, N'A', 191, CAST(25.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 16, N'D', 27, CAST(17.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 16, N'F', 183, CAST(19.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 17, N'A', 176, CAST(19.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 17, N'B', 69, CAST(14.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 18, N'A', 379, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 18, N'D', 154, CAST(14.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 18, N'E', 82, CAST(24.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 20, N'A', 107, CAST(29.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 21, N'A', 456, CAST(27.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 21, N'B', 167, CAST(17.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 21, N'C', 16, CAST(21.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 22, N'B', 361, CAST(10.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 24, N'A', 260, CAST(27.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (7, 24, N'B', 110, CAST(20.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 2, N'A', 239, CAST(23.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 2, N'B', 149, CAST(16.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 4, N'D', 309, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 6, N'A', 101, CAST(20.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 7, N'D', 84, CAST(28.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 7, N'F', 377, CAST(22.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 8, N'D', 310, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 11, N'C', 458, CAST(23.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 12, N'A', 199, CAST(19.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 13, N'F', 11, CAST(19.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 14, N'B', 177, CAST(29.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 14, N'F', 90, CAST(28.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 18, N'A', 303, CAST(19.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 20, N'E', 41, CAST(16.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 22, N'E', 39, CAST(27.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (8, 23, N'F', 423, CAST(19.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 5, N'F', 17, CAST(21.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 6, N'E', 374, CAST(17.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 7, N'D', 76, CAST(24.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 7, N'E', 393, CAST(15.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 8, N'F', 233, CAST(13.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 9, N'A', 51, CAST(26.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 11, N'A', 200, CAST(14.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 12, N'A', 195, CAST(26.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 12, N'C', 461, CAST(17.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 13, N'A', 21, CAST(29.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 14, N'A', 139, CAST(14.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 14, N'B', 472, CAST(11.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 14, N'E', 333, CAST(29.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 21, N'B', 449, CAST(18.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (9, 22, N'D', 138, CAST(20.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 1, N'A', 289, CAST(26.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 2, N'C', 280, CAST(22.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 3, N'D', 144, CAST(25.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 4, N'A', 228, CAST(19.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 6, N'C', 120, CAST(22.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 7, N'C', 284, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 10, N'A', 97, CAST(17.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 10, N'B', 272, CAST(23.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 11, N'B', 394, CAST(20.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 11, N'D', 340, CAST(20.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 11, N'E', 1, CAST(23.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 12, N'B', 25, CAST(12.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 13, N'C', 134, CAST(29.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 15, N'B', 420, CAST(27.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 15, N'F', 477, CAST(26.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 16, N'C', 52, CAST(25.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 17, N'A', 204, CAST(10.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 17, N'B', 335, CAST(14.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 17, N'E', 432, CAST(20.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 18, N'A', 344, CAST(23.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 18, N'C', 363, CAST(26.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 18, N'D', 247, CAST(14.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 18, N'E', 304, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 19, N'D', 454, CAST(19.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 20, N'A', 203, CAST(11.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 21, N'B', 172, CAST(25.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 22, N'A', 286, CAST(24.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (10, 22, N'B', 365, CAST(20.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 4, N'G', 313, CAST(19.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 9, N'D', 175, CAST(24.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 11, N'C', 306, CAST(28.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 12, N'D', 32, CAST(29.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 12, N'G', 457, CAST(27.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 13, N'B', 271, CAST(16.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 13, N'H', 213, CAST(23.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 14, N'H', 181, CAST(21.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 15, N'E', 221, CAST(15.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 17, N'G', 211, CAST(11.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 19, N'C', 242, CAST(27.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 21, N'I', 126, CAST(23.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 23, N'D', 319, CAST(24.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 27, N'C', 115, CAST(11.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 27, N'D', 103, CAST(14.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 32, N'F', 375, CAST(13.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 36, N'E', 65, CAST(23.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (11, 38, N'E', 18, CAST(14.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 1, N'B', 121, CAST(28.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 6, N'A', 419, CAST(26.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 8, N'H', 282, CAST(29.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 10, N'J', 391, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 14, N'A', 215, CAST(17.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 16, N'I', 157, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 26, N'B', 321, CAST(19.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 28, N'D', 198, CAST(24.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 28, N'F', 364, CAST(24.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 31, N'E', 201, CAST(24.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 33, N'E', 112, CAST(10.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 35, N'A', 58, CAST(23.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 35, N'C', 116, CAST(10.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 39, N'A', 216, CAST(27.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 41, N'I', 311, CAST(13.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (12, 42, N'I', 61, CAST(24.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 1, N'A', 464, CAST(25.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 2, N'B', 318, CAST(24.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 2, N'C', 370, CAST(27.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 2, N'F', 366, CAST(15.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 3, N'C', 415, CAST(17.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 3, N'D', 225, CAST(17.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 5, N'C', 55, CAST(27.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 5, N'D', 236, CAST(24.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 5, N'F', 281, CAST(22.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 6, N'A', 33, CAST(16.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 7, N'B', 299, CAST(11.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 8, N'B', 411, CAST(11.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 8, N'D', 329, CAST(15.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 9, N'D', 123, CAST(16.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 9, N'F', 440, CAST(28.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 11, N'D', 275, CAST(15.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 12, N'F', 150, CAST(15.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 13, N'B', 240, CAST(18.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 13, N'C', 443, CAST(19.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 13, N'E', 92, CAST(12.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 13, N'F', 400, CAST(21.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 16, N'B', 194, CAST(18.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 17, N'F', 67, CAST(28.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 18, N'B', 320, CAST(16.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 20, N'D', 409, CAST(21.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 20, N'E', 254, CAST(17.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 23, N'A', 57, CAST(29.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 23, N'C', 376, CAST(10.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 24, N'A', 354, CAST(22.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 24, N'C', 128, CAST(23.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (13, 25, N'B', 196, CAST(29.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 2, N'F', 276, CAST(20.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 3, N'C', 455, CAST(22.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 4, N'A', 108, CAST(16.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 4, N'B', 476, CAST(23.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 6, N'A', 159, CAST(12.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 7, N'A', 447, CAST(19.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 9, N'A', 416, CAST(27.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 9, N'F', 169, CAST(26.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 10, N'D', 348, CAST(26.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 12, N'E', 232, CAST(14.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 13, N'C', 336, CAST(17.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 14, N'B', 257, CAST(15.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 15, N'C', 389, CAST(29.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 15, N'F', 480, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 17, N'D', 424, CAST(24.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 18, N'F', 207, CAST(21.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 19, N'D', 224, CAST(21.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 19, N'F', 158, CAST(14.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 20, N'A', 147, CAST(17.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 21, N'F', 249, CAST(17.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 22, N'F', 437, CAST(29.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 23, N'F', 190, CAST(22.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 24, N'D', 324, CAST(17.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (14, 24, N'E', 431, CAST(14.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 1, N'A', 132, CAST(12.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 2, N'F', 401, CAST(23.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 4, N'F', 406, CAST(12.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 5, N'D', 427, CAST(13.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 6, N'C', 168, CAST(29.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 7, N'B', 5, CAST(23.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 7, N'D', 208, CAST(24.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 7, N'E', 462, CAST(21.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 8, N'B', 328, CAST(11.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 8, N'F', 100, CAST(20.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 9, N'C', 102, CAST(10.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 10, N'F', 88, CAST(10.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 11, N'A', 9, CAST(11.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 11, N'B', 140, CAST(22.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 11, N'F', 231, CAST(10.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 12, N'B', 288, CAST(16.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 12, N'C', 73, CAST(17.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 13, N'A', 392, CAST(26.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 13, N'E', 412, CAST(14.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 15, N'B', 244, CAST(23.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 16, N'F', 468, CAST(13.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 17, N'E', 170, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 18, N'F', 127, CAST(20.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 19, N'B', 353, CAST(20.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 20, N'A', 174, CAST(10.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 21, N'D', 439, CAST(20.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 22, N'A', 397, CAST(19.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (15, 22, N'F', 143, CAST(13.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 2, N'D', 474, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 2, N'E', 245, CAST(20.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 6, N'C', 357, CAST(21.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 7, N'C', 87, CAST(20.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 8, N'D', 312, CAST(25.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 9, N'B', 433, CAST(18.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 9, N'D', 268, CAST(18.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 11, N'C', 210, CAST(10.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 12, N'F', 241, CAST(21.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 13, N'E', 141, CAST(21.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 17, N'F', 42, CAST(10.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 20, N'C', 471, CAST(14.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 21, N'C', 438, CAST(24.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (16, 22, N'B', 109, CAST(27.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 7, N'F', 63, CAST(11.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 10, N'F', 264, CAST(25.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 17, N'H', 417, CAST(10.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 18, N'E', 212, CAST(12.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 18, N'I', 469, CAST(17.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 21, N'D', 182, CAST(14.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 22, N'D', 152, CAST(11.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 24, N'C', 48, CAST(29.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 24, N'H', 451, CAST(10.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 27, N'E', 298, CAST(22.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 32, N'E', 259, CAST(23.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 33, N'F', 384, CAST(25.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 39, N'B', 111, CAST(12.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 39, N'D', 93, CAST(14.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 41, N'D', 347, CAST(11.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 42, N'E', 350, CAST(28.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (17, 42, N'J', 173, CAST(14.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 1, N'F', 359, CAST(21.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 1, N'G', 68, CAST(15.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 6, N'E', 297, CAST(24.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 8, N'E', 479, CAST(11.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 14, N'I', 408, CAST(16.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 16, N'A', 330, CAST(10.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 16, N'C', 425, CAST(27.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 16, N'D', 410, CAST(23.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 17, N'D', 322, CAST(20.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 17, N'H', 155, CAST(13.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 18, N'H', 404, CAST(22.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 29, N'H', 246, CAST(14.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 31, N'E', 136, CAST(17.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 32, N'C', 7, CAST(25.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 36, N'C', 28, CAST(12.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 39, N'B', 47, CAST(15.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 39, N'H', 362, CAST(21.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (18, 40, N'I', 66, CAST(29.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 1, N'A', 137, CAST(21.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 1, N'C', 351, CAST(22.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 1, N'E', 301, CAST(29.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 2, N'C', 388, CAST(17.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 4, N'F', 274, CAST(18.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 5, N'A', 369, CAST(16.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 6, N'A', 117, CAST(16.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 7, N'B', 71, CAST(27.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 7, N'C', 398, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 11, N'A', 189, CAST(15.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 13, N'B', 407, CAST(20.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 13, N'E', 442, CAST(14.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 14, N'C', 6, CAST(23.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 15, N'B', 230, CAST(16.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 16, N'D', 99, CAST(27.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 24, N'B', 219, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 25, N'B', 238, CAST(25.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (19, 25, N'D', 263, CAST(27.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 1, N'D', 378, CAST(17.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 3, N'D', 34, CAST(17.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 4, N'E', 450, CAST(17.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 5, N'C', 3, CAST(20.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 7, N'C', 338, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 8, N'D', 217, CAST(24.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 8, N'F', 86, CAST(29.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 9, N'D', 130, CAST(10.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 10, N'F', 339, CAST(17.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 11, N'F', 153, CAST(27.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 14, N'A', 227, CAST(19.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 15, N'B', 345, CAST(29.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 16, N'E', 445, CAST(29.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 17, N'F', 395, CAST(24.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 18, N'A', 399, CAST(18.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 19, N'B', 226, CAST(14.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 21, N'C', 124, CAST(29.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 22, N'A', 243, CAST(21.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 22, N'E', 316, CAST(28.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 24, N'E', 74, CAST(23.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (20, 25, N'E', 148, CAST(23.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 1, N'A', 252, CAST(28.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 1, N'E', 253, CAST(24.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 1, N'F', 186, CAST(23.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 3, N'B', 403, CAST(20.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 5, N'F', 151, CAST(26.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 15, N'D', 251, CAST(27.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 16, N'B', 131, CAST(17.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 16, N'C', 470, CAST(19.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 16, N'E', 380, CAST(11.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 20, N'D', 40, CAST(29.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 20, N'F', 382, CAST(22.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 21, N'F', 473, CAST(12.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 22, N'F', 385, CAST(21.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 24, N'D', 463, CAST(11.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (21, 24, N'F', 133, CAST(25.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 1, N'A', 235, CAST(28.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 1, N'F', 50, CAST(22.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 3, N'A', 460, CAST(27.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 5, N'A', 166, CAST(10.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 5, N'E', 448, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 6, N'D', 453, CAST(10.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 7, N'A', 184, CAST(24.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 9, N'B', 29, CAST(15.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 9, N'D', 105, CAST(10.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 11, N'B', 135, CAST(12.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 16, N'A', 60, CAST(14.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 16, N'C', 290, CAST(22.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 18, N'F', 465, CAST(19.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 19, N'B', 49, CAST(29.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 21, N'D', 218, CAST(16.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 21, N'E', 206, CAST(11.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (22, 21, N'F', 178, CAST(27.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 1, N'D', 163, CAST(29.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 1, N'F', 337, CAST(19.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 3, N'B', 323, CAST(22.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 5, N'B', 287, CAST(29.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 7, N'I', 35, CAST(24.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 11, N'B', 72, CAST(22.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 12, N'I', 308, CAST(29.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 13, N'G', 269, CAST(24.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 21, N'I', 188, CAST(14.1 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 25, N'D', 331, CAST(11.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 27, N'G', 429, CAST(18.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 28, N'F', 229, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 31, N'D', 91, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (23, 36, N'F', 371, CAST(12.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 1, N'C', 30, CAST(20.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 2, N'E', 85, CAST(17.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 4, N'G', 343, CAST(19.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 10, N'B', 386, CAST(20.4 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 12, N'H', 77, CAST(29.5 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 13, N'J', 255, CAST(29.6 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 17, N'G', 95, CAST(20.2 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 17, N'J', 104, CAST(14.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 18, N'G', 256, CAST(12.9 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 19, N'G', 368, CAST(11.7 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 22, N'C', 12, CAST(24.8 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 31, N'D', 4, CAST(29.3 AS Decimal(3, 1)))
GO
INSERT [dbo].[AL_Tarjetas] ([Codigo_Vuelo], [Fila_Asiento], [Letra_Asiento], [Numero_Pasaje], [Peso_Equipaje]) VALUES (24, 32, N'B', 197, CAST(19.6 AS Decimal(3, 1)))
GO
SET IDENTITY_INSERT [dbo].[AL_Vuelos] ON 

GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (1, N'APA', N'JFK', CAST(N'2008-01-14 14:05:00' AS SmallDateTime), CAST(N'2008-01-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (2, N'MIA', N'JFK', CAST(N'2008-03-16 14:45:00' AS SmallDateTime), CAST(N'2008-03-16 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (3, N'APA', N'MIA', CAST(N'2008-05-14 07:05:00' AS SmallDateTime), CAST(N'2008-05-14 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (4, N'APA', N'JFK', CAST(N'2008-02-14 14:05:00' AS SmallDateTime), CAST(N'2008-02-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (5, N'APA', N'JFK', CAST(N'2008-03-14 14:05:00' AS SmallDateTime), CAST(N'2008-03-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (6, N'CVG', N'JFK', CAST(N'2008-01-18 14:05:00' AS SmallDateTime), CAST(N'2008-01-18 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (7, N'APA', N'AGP', CAST(N'2010-11-14 14:05:00' AS SmallDateTime), CAST(N'2010-11-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (8, N'MAD', N'SVQ', CAST(N'2010-09-14 14:45:00' AS SmallDateTime), CAST(N'2010-09-14 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (9, N'APA', N'MAD', CAST(N'2010-05-14 07:05:00' AS SmallDateTime), CAST(N'2010-05-14 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (10, N'AGP', N'SVQ', CAST(N'2010-02-14 14:05:00' AS SmallDateTime), CAST(N'2010-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (11, N'SVQ', N'JFK', CAST(N'2010-03-14 14:05:00' AS SmallDateTime), CAST(N'2010-03-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (12, N'PMI', N'NRT', CAST(N'2010-01-18 14:05:00' AS SmallDateTime), CAST(N'2010-01-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (13, N'APA', N'AGP', CAST(N'2010-11-14 14:05:00' AS SmallDateTime), CAST(N'2010-11-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (14, N'MAD', N'SVQ', CAST(N'2010-01-16 14:45:00' AS SmallDateTime), CAST(N'2010-01-16 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (15, N'APA', N'MAD', CAST(N'2010-05-10 07:05:00' AS SmallDateTime), CAST(N'2010-05-10 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (16, N'AGP', N'FCO', CAST(N'2010-02-14 14:05:00' AS SmallDateTime), CAST(N'2010-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (17, N'SVQ', N'JFK', CAST(N'2010-03-14 14:05:00' AS SmallDateTime), CAST(N'2010-03-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (18, N'PMI', N'NRT', CAST(N'2010-01-18 14:05:00' AS SmallDateTime), CAST(N'2010-01-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (19, N'LGA', N'AGP', CAST(N'2010-11-16 14:05:00' AS SmallDateTime), CAST(N'2010-11-17 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (20, N'MAD', N'LGA', CAST(N'2010-01-16 14:45:00' AS SmallDateTime), CAST(N'2010-01-16 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (21, N'CAI', N'MAD', CAST(N'2010-05-17 07:05:00' AS SmallDateTime), CAST(N'2010-05-17 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (22, N'PMI', N'SVQ', CAST(N'2010-02-14 14:05:00' AS SmallDateTime), CAST(N'2010-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (23, N'SVQ', N'CAI', CAST(N'2010-06-14 14:05:00' AS SmallDateTime), CAST(N'2010-06-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (24, N'LGA', N'NRT', CAST(N'2010-01-12 14:05:00' AS SmallDateTime), CAST(N'2010-01-12 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (25, N'APA', N'JFK', CAST(N'2008-01-21 14:05:00' AS SmallDateTime), CAST(N'2008-01-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (26, N'MIA', N'JFK', CAST(N'2008-03-23 14:45:00' AS SmallDateTime), CAST(N'2008-03-23 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (27, N'APA', N'MIA', CAST(N'2008-05-21 07:05:00' AS SmallDateTime), CAST(N'2008-05-21 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (28, N'APA', N'JFK', CAST(N'2008-02-21 14:05:00' AS SmallDateTime), CAST(N'2008-02-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (29, N'APA', N'JFK', CAST(N'2008-03-21 14:05:00' AS SmallDateTime), CAST(N'2008-03-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (30, N'CVG', N'JFK', CAST(N'2008-01-25 14:05:00' AS SmallDateTime), CAST(N'2008-01-25 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (31, N'APA', N'AGP', CAST(N'2010-11-21 14:05:00' AS SmallDateTime), CAST(N'2010-11-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (32, N'MAD', N'SVQ', CAST(N'2010-09-21 14:45:00' AS SmallDateTime), CAST(N'2010-09-21 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (33, N'APA', N'MAD', CAST(N'2010-05-21 07:05:00' AS SmallDateTime), CAST(N'2010-05-21 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (34, N'AGP', N'SVQ', CAST(N'2010-02-21 14:05:00' AS SmallDateTime), CAST(N'2010-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (35, N'SVQ', N'JFK', CAST(N'2010-03-21 14:05:00' AS SmallDateTime), CAST(N'2010-03-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (36, N'PMI', N'NRT', CAST(N'2010-01-25 14:05:00' AS SmallDateTime), CAST(N'2010-01-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (37, N'APA', N'AGP', CAST(N'2010-11-21 14:05:00' AS SmallDateTime), CAST(N'2010-11-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (38, N'MAD', N'SVQ', CAST(N'2010-01-23 14:45:00' AS SmallDateTime), CAST(N'2010-01-23 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (39, N'APA', N'MAD', CAST(N'2010-05-17 07:05:00' AS SmallDateTime), CAST(N'2010-05-17 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (40, N'AGP', N'FCO', CAST(N'2010-02-21 14:05:00' AS SmallDateTime), CAST(N'2010-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (41, N'SVQ', N'JFK', CAST(N'2010-03-21 14:05:00' AS SmallDateTime), CAST(N'2010-03-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (42, N'PMI', N'NRT', CAST(N'2010-01-25 14:05:00' AS SmallDateTime), CAST(N'2010-01-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (43, N'LGA', N'AGP', CAST(N'2010-11-23 14:05:00' AS SmallDateTime), CAST(N'2010-11-24 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (44, N'MAD', N'LGA', CAST(N'2010-01-23 14:45:00' AS SmallDateTime), CAST(N'2010-01-23 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (45, N'CAI', N'MAD', CAST(N'2010-05-24 07:05:00' AS SmallDateTime), CAST(N'2010-05-24 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (46, N'PMI', N'SVQ', CAST(N'2010-02-21 14:05:00' AS SmallDateTime), CAST(N'2010-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (47, N'SVQ', N'CAI', CAST(N'2010-06-21 14:05:00' AS SmallDateTime), CAST(N'2010-06-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (48, N'LGA', N'NRT', CAST(N'2010-01-19 14:05:00' AS SmallDateTime), CAST(N'2010-01-19 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (49, N'AGP', N'SVQ', CAST(N'2010-04-14 14:05:00' AS SmallDateTime), CAST(N'2010-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (50, N'AGP', N'FCO', CAST(N'2010-04-14 14:05:00' AS SmallDateTime), CAST(N'2010-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (51, N'AGP', N'SVQ', CAST(N'2010-04-21 14:05:00' AS SmallDateTime), CAST(N'2010-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (52, N'AGP', N'FCO', CAST(N'2010-04-21 14:05:00' AS SmallDateTime), CAST(N'2010-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (53, N'APA', N'MAD', CAST(N'2010-07-17 07:05:00' AS SmallDateTime), CAST(N'2010-07-17 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (54, N'APA', N'AGP', CAST(N'2011-01-21 14:05:00' AS SmallDateTime), CAST(N'2011-01-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (55, N'APA', N'AGP', CAST(N'2011-01-14 14:05:00' AS SmallDateTime), CAST(N'2011-01-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (56, N'APA', N'MAD', CAST(N'2010-07-14 07:05:00' AS SmallDateTime), CAST(N'2010-07-14 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (57, N'APA', N'MIA', CAST(N'2008-07-14 07:05:00' AS SmallDateTime), CAST(N'2008-07-14 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (58, N'APA', N'JFK', CAST(N'2008-04-14 14:05:00' AS SmallDateTime), CAST(N'2008-04-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (59, N'APA', N'JFK', CAST(N'2008-05-14 14:05:00' AS SmallDateTime), CAST(N'2008-05-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (60, N'APA', N'JFK', CAST(N'2008-03-14 14:05:00' AS SmallDateTime), CAST(N'2008-03-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (61, N'APA', N'AGP', CAST(N'2011-01-14 14:05:00' AS SmallDateTime), CAST(N'2011-01-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (62, N'APA', N'MAD', CAST(N'2010-07-10 07:05:00' AS SmallDateTime), CAST(N'2010-07-10 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (63, N'APA', N'JFK', CAST(N'2008-03-21 14:05:00' AS SmallDateTime), CAST(N'2008-03-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (64, N'APA', N'MIA', CAST(N'2008-07-21 07:05:00' AS SmallDateTime), CAST(N'2008-07-21 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (65, N'APA', N'JFK', CAST(N'2008-04-21 14:05:00' AS SmallDateTime), CAST(N'2008-04-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (66, N'APA', N'JFK', CAST(N'2008-05-21 14:05:00' AS SmallDateTime), CAST(N'2008-05-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (67, N'APA', N'AGP', CAST(N'2011-01-21 14:05:00' AS SmallDateTime), CAST(N'2011-01-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (68, N'APA', N'MAD', CAST(N'2010-07-21 07:05:00' AS SmallDateTime), CAST(N'2010-07-21 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (69, N'CAI', N'MAD', CAST(N'2010-07-17 07:05:00' AS SmallDateTime), CAST(N'2010-07-17 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (70, N'CAI', N'MAD', CAST(N'2010-07-24 07:05:00' AS SmallDateTime), CAST(N'2010-07-24 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (71, N'CVG', N'JFK', CAST(N'2008-03-25 14:05:00' AS SmallDateTime), CAST(N'2008-03-25 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (72, N'CVG', N'JFK', CAST(N'2008-03-18 14:05:00' AS SmallDateTime), CAST(N'2008-03-18 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (73, N'LGA', N'NRT', CAST(N'2010-03-12 14:05:00' AS SmallDateTime), CAST(N'2010-03-12 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (74, N'LGA', N'AGP', CAST(N'2011-01-16 14:05:00' AS SmallDateTime), CAST(N'2011-01-17 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (75, N'LGA', N'AGP', CAST(N'2011-01-23 14:05:00' AS SmallDateTime), CAST(N'2011-01-24 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (76, N'LGA', N'NRT', CAST(N'2010-03-19 14:05:00' AS SmallDateTime), CAST(N'2010-03-19 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (77, N'MAD', N'LGA', CAST(N'2010-03-23 14:45:00' AS SmallDateTime), CAST(N'2010-03-23 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (78, N'MAD', N'SVQ', CAST(N'2010-03-23 14:45:00' AS SmallDateTime), CAST(N'2010-03-23 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (79, N'MAD', N'LGA', CAST(N'2010-03-16 14:45:00' AS SmallDateTime), CAST(N'2010-03-16 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (80, N'MAD', N'SVQ', CAST(N'2010-11-21 14:45:00' AS SmallDateTime), CAST(N'2010-11-21 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (81, N'MAD', N'SVQ', CAST(N'2010-11-14 14:45:00' AS SmallDateTime), CAST(N'2010-11-14 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (82, N'MAD', N'SVQ', CAST(N'2010-03-16 14:45:00' AS SmallDateTime), CAST(N'2010-03-16 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (83, N'MIA', N'JFK', CAST(N'2008-05-16 14:45:00' AS SmallDateTime), CAST(N'2008-05-16 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (84, N'MIA', N'JFK', CAST(N'2008-05-23 14:45:00' AS SmallDateTime), CAST(N'2008-05-23 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (85, N'PMI', N'SVQ', CAST(N'2010-04-14 14:05:00' AS SmallDateTime), CAST(N'2010-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (86, N'PMI', N'NRT', CAST(N'2010-03-18 14:05:00' AS SmallDateTime), CAST(N'2010-03-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (87, N'PMI', N'NRT', CAST(N'2010-03-18 14:05:00' AS SmallDateTime), CAST(N'2010-03-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (88, N'PMI', N'NRT', CAST(N'2010-03-25 14:05:00' AS SmallDateTime), CAST(N'2010-03-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (89, N'PMI', N'SVQ', CAST(N'2010-04-21 14:05:00' AS SmallDateTime), CAST(N'2010-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (90, N'PMI', N'NRT', CAST(N'2010-03-25 14:05:00' AS SmallDateTime), CAST(N'2010-03-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (91, N'SVQ', N'CAI', CAST(N'2010-08-21 14:05:00' AS SmallDateTime), CAST(N'2010-08-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (92, N'SVQ', N'JFK', CAST(N'2010-05-21 14:05:00' AS SmallDateTime), CAST(N'2010-05-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (93, N'SVQ', N'JFK', CAST(N'2010-05-21 14:05:00' AS SmallDateTime), CAST(N'2010-05-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (94, N'SVQ', N'JFK', CAST(N'2010-05-14 14:05:00' AS SmallDateTime), CAST(N'2010-05-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (95, N'SVQ', N'JFK', CAST(N'2010-05-14 14:05:00' AS SmallDateTime), CAST(N'2010-05-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (96, N'SVQ', N'CAI', CAST(N'2010-08-14 14:05:00' AS SmallDateTime), CAST(N'2010-08-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (97, N'AGP', N'SVQ', CAST(N'2011-02-14 14:05:00' AS SmallDateTime), CAST(N'2011-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (98, N'AGP', N'FCO', CAST(N'2011-02-14 14:05:00' AS SmallDateTime), CAST(N'2011-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (99, N'AGP', N'SVQ', CAST(N'2011-04-14 14:05:00' AS SmallDateTime), CAST(N'2011-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (100, N'AGP', N'FCO', CAST(N'2011-04-14 14:05:00' AS SmallDateTime), CAST(N'2011-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (101, N'AGP', N'SVQ', CAST(N'2011-04-21 14:05:00' AS SmallDateTime), CAST(N'2011-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (102, N'AGP', N'FCO', CAST(N'2011-04-21 14:05:00' AS SmallDateTime), CAST(N'2011-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (103, N'AGP', N'SVQ', CAST(N'2011-02-21 14:05:00' AS SmallDateTime), CAST(N'2011-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (104, N'AGP', N'FCO', CAST(N'2011-02-21 14:05:00' AS SmallDateTime), CAST(N'2011-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 50.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (105, N'APA', N'MAD', CAST(N'2011-05-17 07:05:00' AS SmallDateTime), CAST(N'2011-05-17 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (106, N'APA', N'AGP', CAST(N'2011-11-21 14:05:00' AS SmallDateTime), CAST(N'2011-11-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (107, N'APA', N'MAD', CAST(N'2011-07-17 07:05:00' AS SmallDateTime), CAST(N'2011-07-17 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (108, N'APA', N'AGP', CAST(N'2012-01-21 14:05:00' AS SmallDateTime), CAST(N'2012-01-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (109, N'APA', N'AGP', CAST(N'2012-01-14 14:05:00' AS SmallDateTime), CAST(N'2012-01-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (110, N'APA', N'MAD', CAST(N'2011-07-14 07:05:00' AS SmallDateTime), CAST(N'2011-07-14 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (111, N'APA', N'MIA', CAST(N'2009-07-14 07:05:00' AS SmallDateTime), CAST(N'2009-07-14 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (112, N'APA', N'JFK', CAST(N'2009-04-14 14:05:00' AS SmallDateTime), CAST(N'2009-04-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (113, N'APA', N'JFK', CAST(N'2009-05-14 14:05:00' AS SmallDateTime), CAST(N'2009-05-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (114, N'APA', N'JFK', CAST(N'2009-03-14 14:05:00' AS SmallDateTime), CAST(N'2009-03-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (115, N'APA', N'AGP', CAST(N'2012-01-14 14:05:00' AS SmallDateTime), CAST(N'2012-01-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (116, N'APA', N'MAD', CAST(N'2011-07-10 07:05:00' AS SmallDateTime), CAST(N'2011-07-10 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (117, N'APA', N'JFK', CAST(N'2009-03-21 14:05:00' AS SmallDateTime), CAST(N'2009-03-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (118, N'APA', N'MIA', CAST(N'2009-07-21 07:05:00' AS SmallDateTime), CAST(N'2009-07-21 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (119, N'APA', N'JFK', CAST(N'2009-04-21 14:05:00' AS SmallDateTime), CAST(N'2009-04-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (120, N'APA', N'JFK', CAST(N'2009-05-21 14:05:00' AS SmallDateTime), CAST(N'2009-05-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (121, N'APA', N'AGP', CAST(N'2012-01-21 14:05:00' AS SmallDateTime), CAST(N'2012-01-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (122, N'APA', N'MAD', CAST(N'2011-07-21 07:05:00' AS SmallDateTime), CAST(N'2011-07-21 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (123, N'APA', N'AGP', CAST(N'2011-11-14 14:05:00' AS SmallDateTime), CAST(N'2011-11-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (124, N'APA', N'MAD', CAST(N'2011-05-14 07:05:00' AS SmallDateTime), CAST(N'2011-05-14 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (125, N'APA', N'MIA', CAST(N'2009-05-14 07:05:00' AS SmallDateTime), CAST(N'2009-05-14 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (126, N'APA', N'JFK', CAST(N'2009-02-14 14:05:00' AS SmallDateTime), CAST(N'2009-02-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (127, N'APA', N'JFK', CAST(N'2009-03-14 14:05:00' AS SmallDateTime), CAST(N'2009-03-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (128, N'APA', N'JFK', CAST(N'2009-01-14 14:05:00' AS SmallDateTime), CAST(N'2009-01-14 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (129, N'APA', N'AGP', CAST(N'2011-11-14 14:05:00' AS SmallDateTime), CAST(N'2011-11-14 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (130, N'APA', N'MAD', CAST(N'2011-05-10 07:05:00' AS SmallDateTime), CAST(N'2011-05-10 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (131, N'APA', N'JFK', CAST(N'2009-01-21 14:05:00' AS SmallDateTime), CAST(N'2009-01-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (132, N'APA', N'MIA', CAST(N'2009-05-21 07:05:00' AS SmallDateTime), CAST(N'2009-05-21 14:30:00' AS SmallDateTime), N'USA5077   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (133, N'APA', N'JFK', CAST(N'2009-02-21 14:05:00' AS SmallDateTime), CAST(N'2009-02-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (134, N'APA', N'JFK', CAST(N'2009-03-21 14:05:00' AS SmallDateTime), CAST(N'2009-03-21 17:30:00' AS SmallDateTime), N'USA5068   ', 150.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (135, N'APA', N'AGP', CAST(N'2011-11-21 14:05:00' AS SmallDateTime), CAST(N'2011-11-21 17:30:00' AS SmallDateTime), N'ESP4502   ', 850.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (136, N'APA', N'MAD', CAST(N'2011-05-21 07:05:00' AS SmallDateTime), CAST(N'2011-05-21 14:30:00' AS SmallDateTime), N'ESP8067   ', 450.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (137, N'CAI', N'MAD', CAST(N'2011-05-17 07:05:00' AS SmallDateTime), CAST(N'2011-05-17 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (138, N'CAI', N'MAD', CAST(N'2011-07-17 07:05:00' AS SmallDateTime), CAST(N'2011-07-17 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (139, N'CAI', N'MAD', CAST(N'2011-07-24 07:05:00' AS SmallDateTime), CAST(N'2011-07-24 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (140, N'CAI', N'MAD', CAST(N'2011-05-24 07:05:00' AS SmallDateTime), CAST(N'2011-05-24 14:30:00' AS SmallDateTime), N'FRA4502   ', 550.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (141, N'CVG', N'JFK', CAST(N'2009-03-25 14:05:00' AS SmallDateTime), CAST(N'2009-03-25 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (142, N'CVG', N'JFK', CAST(N'2009-03-18 14:05:00' AS SmallDateTime), CAST(N'2009-03-18 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (143, N'CVG', N'JFK', CAST(N'2009-01-25 14:05:00' AS SmallDateTime), CAST(N'2009-01-25 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (144, N'CVG', N'JFK', CAST(N'2009-01-18 14:05:00' AS SmallDateTime), CAST(N'2009-01-18 17:30:00' AS SmallDateTime), N'USA5068   ', 155.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (145, N'LGA', N'NRT', CAST(N'2011-01-12 14:05:00' AS SmallDateTime), CAST(N'2011-01-12 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (146, N'LGA', N'AGP', CAST(N'2011-11-16 14:05:00' AS SmallDateTime), CAST(N'2011-11-17 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (147, N'LGA', N'NRT', CAST(N'2011-03-12 14:05:00' AS SmallDateTime), CAST(N'2011-03-12 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (148, N'LGA', N'AGP', CAST(N'2012-01-16 14:05:00' AS SmallDateTime), CAST(N'2012-01-17 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (149, N'LGA', N'AGP', CAST(N'2012-01-23 14:05:00' AS SmallDateTime), CAST(N'2012-01-24 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (150, N'LGA', N'NRT', CAST(N'2011-03-19 14:05:00' AS SmallDateTime), CAST(N'2011-03-19 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (151, N'LGA', N'AGP', CAST(N'2011-11-23 14:05:00' AS SmallDateTime), CAST(N'2011-11-24 07:30:00' AS SmallDateTime), N'ESP4502   ', 650.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (152, N'LGA', N'NRT', CAST(N'2011-01-19 14:05:00' AS SmallDateTime), CAST(N'2011-01-19 17:30:00' AS SmallDateTime), N'FRA0955   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (153, N'MAD', N'LGA', CAST(N'2011-01-23 14:45:00' AS SmallDateTime), CAST(N'2011-01-23 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (154, N'MAD', N'SVQ', CAST(N'2011-01-23 14:45:00' AS SmallDateTime), CAST(N'2011-01-23 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (155, N'MAD', N'LGA', CAST(N'2011-03-23 14:45:00' AS SmallDateTime), CAST(N'2011-03-23 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (156, N'MAD', N'SVQ', CAST(N'2011-03-23 14:45:00' AS SmallDateTime), CAST(N'2011-03-23 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (157, N'MAD', N'LGA', CAST(N'2011-03-16 14:45:00' AS SmallDateTime), CAST(N'2011-03-16 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (158, N'MAD', N'SVQ', CAST(N'2011-11-21 14:45:00' AS SmallDateTime), CAST(N'2011-11-21 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (159, N'MAD', N'SVQ', CAST(N'2011-11-14 14:45:00' AS SmallDateTime), CAST(N'2011-11-14 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (160, N'MAD', N'SVQ', CAST(N'2011-03-16 14:45:00' AS SmallDateTime), CAST(N'2011-03-16 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (161, N'MAD', N'LGA', CAST(N'2011-01-16 14:45:00' AS SmallDateTime), CAST(N'2011-01-16 22:30:00' AS SmallDateTime), N'FRA5021   ', 474.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (162, N'MAD', N'SVQ', CAST(N'2011-09-21 14:45:00' AS SmallDateTime), CAST(N'2011-09-21 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (163, N'MAD', N'SVQ', CAST(N'2011-09-14 14:45:00' AS SmallDateTime), CAST(N'2011-09-14 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (164, N'MAD', N'SVQ', CAST(N'2011-01-16 14:45:00' AS SmallDateTime), CAST(N'2011-01-16 18:30:00' AS SmallDateTime), N'ESP4502   ', 90.8500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (165, N'MIA', N'JFK', CAST(N'2009-03-16 14:45:00' AS SmallDateTime), CAST(N'2009-03-16 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (166, N'MIA', N'JFK', CAST(N'2009-03-23 14:45:00' AS SmallDateTime), CAST(N'2009-03-23 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (167, N'MIA', N'JFK', CAST(N'2009-05-16 14:45:00' AS SmallDateTime), CAST(N'2009-05-16 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (168, N'MIA', N'JFK', CAST(N'2009-05-23 14:45:00' AS SmallDateTime), CAST(N'2009-05-23 18:30:00' AS SmallDateTime), N'USA5068   ', 290.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (169, N'PMI', N'SVQ', CAST(N'2011-04-14 14:05:00' AS SmallDateTime), CAST(N'2011-04-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (170, N'PMI', N'NRT', CAST(N'2011-03-18 14:05:00' AS SmallDateTime), CAST(N'2011-03-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (171, N'PMI', N'NRT', CAST(N'2011-03-18 14:05:00' AS SmallDateTime), CAST(N'2011-03-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (172, N'PMI', N'NRT', CAST(N'2011-03-25 14:05:00' AS SmallDateTime), CAST(N'2011-03-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (173, N'PMI', N'SVQ', CAST(N'2011-04-21 14:05:00' AS SmallDateTime), CAST(N'2011-04-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (174, N'PMI', N'NRT', CAST(N'2011-03-25 14:05:00' AS SmallDateTime), CAST(N'2011-03-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (175, N'PMI', N'SVQ', CAST(N'2011-02-14 14:05:00' AS SmallDateTime), CAST(N'2011-02-14 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (176, N'PMI', N'NRT', CAST(N'2011-01-18 14:05:00' AS SmallDateTime), CAST(N'2011-01-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (177, N'PMI', N'NRT', CAST(N'2011-01-18 14:05:00' AS SmallDateTime), CAST(N'2011-01-18 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (178, N'PMI', N'NRT', CAST(N'2011-01-25 14:05:00' AS SmallDateTime), CAST(N'2011-01-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (179, N'PMI', N'SVQ', CAST(N'2011-02-21 14:05:00' AS SmallDateTime), CAST(N'2011-02-21 17:30:00' AS SmallDateTime), N'ESP8067   ', 80.5500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (180, N'PMI', N'NRT', CAST(N'2011-01-25 14:05:00' AS SmallDateTime), CAST(N'2011-01-25 17:30:00' AS SmallDateTime), N'ESP5077   ', 1255.9500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (181, N'SVQ', N'CAI', CAST(N'2011-06-21 14:05:00' AS SmallDateTime), CAST(N'2011-06-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (182, N'SVQ', N'JFK', CAST(N'2011-03-21 14:05:00' AS SmallDateTime), CAST(N'2011-03-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (183, N'SVQ', N'JFK', CAST(N'2011-03-21 14:05:00' AS SmallDateTime), CAST(N'2011-03-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (184, N'SVQ', N'JFK', CAST(N'2011-03-14 14:05:00' AS SmallDateTime), CAST(N'2011-03-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (185, N'SVQ', N'JFK', CAST(N'2011-03-14 14:05:00' AS SmallDateTime), CAST(N'2011-03-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (186, N'SVQ', N'CAI', CAST(N'2011-06-14 14:05:00' AS SmallDateTime), CAST(N'2011-06-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (187, N'SVQ', N'CAI', CAST(N'2011-08-21 14:05:00' AS SmallDateTime), CAST(N'2011-08-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (188, N'SVQ', N'JFK', CAST(N'2011-05-21 14:05:00' AS SmallDateTime), CAST(N'2011-05-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (189, N'SVQ', N'JFK', CAST(N'2011-05-21 14:05:00' AS SmallDateTime), CAST(N'2011-05-21 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (190, N'SVQ', N'JFK', CAST(N'2011-05-14 14:05:00' AS SmallDateTime), CAST(N'2011-05-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (191, N'SVQ', N'JFK', CAST(N'2011-05-14 14:05:00' AS SmallDateTime), CAST(N'2011-05-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
INSERT [dbo].[AL_Vuelos] ([Codigo], [Aeropuerto_Salida], [Aeropuerto_Llegada], [Salida], [Llegada], [Matricula_Avion], [Precio_Pasaje]) VALUES (192, N'SVQ', N'CAI', CAST(N'2011-08-14 14:05:00' AS SmallDateTime), CAST(N'2011-08-14 17:30:00' AS SmallDateTime), N'ESP5077   ', 450.7500)
GO
SET IDENTITY_INSERT [dbo].[AL_Vuelos] OFF
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 15, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 22, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 31, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 36, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 44, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 46, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 62, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 75, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 78, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 80, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 96, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 118, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 160, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 180, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 209, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 258, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 265, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 273, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 278, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 300, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 341, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 428, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (1, 444, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 23, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 26, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 38, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 98, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 125, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 129, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 156, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 171, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 185, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 234, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 237, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 267, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 292, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 293, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 314, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 342, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 352, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 356, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 358, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 373, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 383, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 430, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (2, 467, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 10, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 37, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 122, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 146, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 165, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 187, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 193, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 220, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 222, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 266, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 302, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 332, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 349, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 396, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 426, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 434, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 446, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 459, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 466, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (3, 475, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 8, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 19, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 20, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 54, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 59, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 81, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 83, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 106, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 119, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 145, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 161, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 205, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 214, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 277, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 291, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 326, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 346, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 367, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 413, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 422, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (4, 452, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 24, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 43, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 53, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 70, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 79, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 89, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 94, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 113, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 162, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 179, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 202, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 262, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 283, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 307, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 360, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 372, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 405, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 414, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 418, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (5, 436, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 2, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 13, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 14, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 64, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 114, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 142, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 164, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 223, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 248, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 250, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 261, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 270, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 285, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 294, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 295, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 305, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 315, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 317, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 327, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 355, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 381, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 387, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 390, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 435, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 441, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (6, 478, N'S')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 16, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 27, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 45, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 56, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 69, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 82, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 107, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 110, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 154, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 167, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 176, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 183, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 191, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 192, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 260, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 279, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 296, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 325, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 334, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 361, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 379, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 402, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 421, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (7, 456, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 11, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 39, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 41, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 84, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 90, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 101, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 149, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 177, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 199, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 239, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 303, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 309, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 310, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 377, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 423, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (8, 458, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 17, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 21, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 51, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 76, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 138, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 139, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 195, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 200, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 233, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 333, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 374, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 393, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 449, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 461, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (9, 472, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 1, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 25, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 52, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 97, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 120, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 134, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 144, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 172, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 203, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 204, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 228, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 247, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 272, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 280, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 284, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 286, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 289, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 304, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 335, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 340, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 344, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 363, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 365, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 394, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 420, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 432, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 454, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (10, 477, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 18, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 32, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 65, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 103, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 115, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 126, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 175, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 181, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 211, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 213, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 221, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 242, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 271, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 306, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 313, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 319, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 375, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (11, 457, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 58, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 61, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 112, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 116, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 121, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 157, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 198, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 201, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 215, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 216, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 282, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 311, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 321, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 364, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 391, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (12, 419, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 33, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 55, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 57, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 67, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 92, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 123, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 128, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 150, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 194, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 196, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 225, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 236, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 240, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 254, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 275, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 281, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 299, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 318, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 320, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 329, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 354, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 366, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 370, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 376, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 400, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 409, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 411, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 415, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 440, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 443, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (13, 464, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 108, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 147, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 158, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 159, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 169, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 190, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 207, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 224, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 232, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 249, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 257, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 276, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 324, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 336, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 348, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 389, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 416, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 424, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 431, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 437, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 447, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 455, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 476, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (14, 480, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 5, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 9, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 73, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 88, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 100, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 102, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 127, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 132, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 140, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 143, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 168, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 170, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 174, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 208, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 231, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 244, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 288, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 328, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 353, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 392, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 397, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 401, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 406, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 412, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 427, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 439, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 462, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (15, 468, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 42, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 87, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 109, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 141, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 210, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 241, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 245, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 268, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 312, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 357, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 433, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 438, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 471, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (16, 474, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 48, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 63, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 93, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 111, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 152, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 173, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 182, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 212, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 259, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 264, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 298, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 347, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 350, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 384, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 417, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 451, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (17, 469, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 7, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 28, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 47, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 66, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 68, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 136, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 155, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 246, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 297, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 322, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 330, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 359, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 362, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 404, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 408, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 410, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 425, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (18, 479, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 6, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 71, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 99, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 117, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 137, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 189, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 219, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 230, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 238, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 263, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 274, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 301, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 351, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 369, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 388, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 398, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 407, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (19, 442, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 3, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 34, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 74, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 86, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 124, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 130, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 148, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 153, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 217, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 226, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 227, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 243, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 316, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 338, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 339, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 345, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 378, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 395, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 399, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 445, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (20, 450, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 40, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 131, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 133, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 151, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 186, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 251, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 252, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 253, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 380, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 382, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 385, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 403, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 463, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 470, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (21, 473, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 29, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 49, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 50, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 60, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 105, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 135, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 166, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 178, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 184, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 206, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 218, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 235, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 290, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 448, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 453, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 460, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (22, 465, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 35, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 72, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 91, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 163, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 188, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 229, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 269, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 287, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 308, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 323, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 331, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 337, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 371, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (23, 429, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 4, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 12, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 30, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 77, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 85, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 95, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 104, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 197, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 255, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 256, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 343, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 368, N'N')
GO
INSERT [dbo].[AL_Vuelos_Pasajes] ([Codigo_Vuelo], [Numero_Pasaje], [Embarcado]) VALUES (24, 386, N'N')
GO
ALTER TABLE [dbo].[AL_Aviones]  WITH CHECK ADD  CONSTRAINT [FK_Aviones_Fabricantes] FOREIGN KEY([ID_Fabricante])
REFERENCES [dbo].[AL_Fabricantes] ([ID_Fabricante])
GO
ALTER TABLE [dbo].[AL_Aviones] CHECK CONSTRAINT [FK_Aviones_Fabricantes]
GO
ALTER TABLE [dbo].[AL_Distancias]  WITH CHECK ADD  CONSTRAINT [FK_DistanciaDestino] FOREIGN KEY([Destino])
REFERENCES [dbo].[AL_Aeropuertos] ([Codigo])
GO
ALTER TABLE [dbo].[AL_Distancias] CHECK CONSTRAINT [FK_DistanciaDestino]
GO
ALTER TABLE [dbo].[AL_Distancias]  WITH CHECK ADD  CONSTRAINT [FK_DistanciaOrigen] FOREIGN KEY([Origen])
REFERENCES [dbo].[AL_Aeropuertos] ([Codigo])
GO
ALTER TABLE [dbo].[AL_Distancias] CHECK CONSTRAINT [FK_DistanciaOrigen]
GO
ALTER TABLE [dbo].[AL_Pasajes]  WITH CHECK ADD  CONSTRAINT [FK_Pasajes_Pasajeros] FOREIGN KEY([ID_Pasajero])
REFERENCES [dbo].[AL_Pasajeros] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Pasajes] CHECK CONSTRAINT [FK_Pasajes_Pasajeros]
GO
ALTER TABLE [dbo].[AL_Tarjetas]  WITH CHECK ADD  CONSTRAINT [FK_Tarjetas_Pasajes] FOREIGN KEY([Numero_Pasaje])
REFERENCES [dbo].[AL_Pasajes] ([Numero])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Tarjetas] CHECK CONSTRAINT [FK_Tarjetas_Pasajes]
GO
ALTER TABLE [dbo].[AL_Tarjetas]  WITH CHECK ADD  CONSTRAINT [FK_Tarjetas_Vuelos] FOREIGN KEY([Codigo_Vuelo])
REFERENCES [dbo].[AL_Vuelos] ([Codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Tarjetas] CHECK CONSTRAINT [FK_Tarjetas_Vuelos]
GO
ALTER TABLE [dbo].[AL_Vuelos]  WITH CHECK ADD  CONSTRAINT [FK_Vuelos_AerLlegada] FOREIGN KEY([Aeropuerto_Llegada])
REFERENCES [dbo].[AL_Aeropuertos] ([Codigo])
GO
ALTER TABLE [dbo].[AL_Vuelos] CHECK CONSTRAINT [FK_Vuelos_AerLlegada]
GO
ALTER TABLE [dbo].[AL_Vuelos]  WITH CHECK ADD  CONSTRAINT [FK_Vuelos_AerSalida] FOREIGN KEY([Aeropuerto_Salida])
REFERENCES [dbo].[AL_Aeropuertos] ([Codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Vuelos] CHECK CONSTRAINT [FK_Vuelos_AerSalida]
GO
ALTER TABLE [dbo].[AL_Vuelos]  WITH CHECK ADD  CONSTRAINT [FK_Vuelos_Aviones] FOREIGN KEY([Matricula_Avion])
REFERENCES [dbo].[AL_Aviones] ([Matricula])
GO
ALTER TABLE [dbo].[AL_Vuelos] CHECK CONSTRAINT [FK_Vuelos_Aviones]
GO
ALTER TABLE [dbo].[AL_Vuelos_Pasajes]  WITH CHECK ADD  CONSTRAINT [FK_VuelosPasajes_Pasajes] FOREIGN KEY([Numero_Pasaje])
REFERENCES [dbo].[AL_Pasajes] ([Numero])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Vuelos_Pasajes] CHECK CONSTRAINT [FK_VuelosPasajes_Pasajes]
GO
ALTER TABLE [dbo].[AL_Vuelos_Pasajes]  WITH CHECK ADD  CONSTRAINT [FK_VuelosPasajes_Vuelos] FOREIGN KEY([Codigo_Vuelo])
REFERENCES [dbo].[AL_Vuelos] ([Codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AL_Vuelos_Pasajes] CHECK CONSTRAINT [FK_VuelosPasajes_Vuelos]
GO
ALTER TABLE [dbo].[AL_Aviones]  WITH CHECK ADD  CONSTRAINT [CK_Fechas] CHECK  (([Fecha_Fabricacion]<=[Fecha_Entrada]))
GO
ALTER TABLE [dbo].[AL_Aviones] CHECK CONSTRAINT [CK_Fechas]
GO
ALTER TABLE [dbo].[AL_Distancias]  WITH CHECK ADD  CONSTRAINT [ck_oRDEN] CHECK  (([Origen]<[Destino]))
GO
ALTER TABLE [dbo].[AL_Distancias] CHECK CONSTRAINT [ck_oRDEN]
GO
ALTER TABLE [dbo].[AL_Vuelos]  WITH CHECK ADD  CONSTRAINT [CK_AeropuertosDistIntos] CHECK  (([Aeropuerto_Salida]<>[Aeropuerto_Llegada]))
GO
ALTER TABLE [dbo].[AL_Vuelos] CHECK CONSTRAINT [CK_AeropuertosDistIntos]
GO
ALTER TABLE [dbo].[AL_Vuelos]  WITH CHECK ADD  CONSTRAINT [CK_Einstein] CHECK  (([Salida]<[Llegada]))
GO
ALTER TABLE [dbo].[AL_Vuelos] CHECK CONSTRAINT [CK_Einstein]
GO
USE [master]
GO

GO
