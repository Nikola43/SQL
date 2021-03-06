Create database LeoSailingBeta
Go
USE [LeoSailingBeta]
GO
/****** Object:  Table [dbo].[LS_Barcos]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Barcos](
	[n_vela] [int] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[f_adquisicion] [date] NOT NULL CONSTRAINT [DFBarcos_fecha]  DEFAULT (getdate()),
	[color] [varchar](10) NOT NULL CONSTRAINT [DFBarcos_color]  DEFAULT ('blanco'),
	[material] [varchar](20) NOT NULL CONSTRAINT [DFBarcos_material]  DEFAULT ('PRFV'),
	[estado_conservacion] [smallint] NULL,
	[nombre_clase] [char](15) NULL,
 CONSTRAINT [PKBarcos] PRIMARY KEY CLUSTERED 
(
	[n_vela] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Campo_Regatas]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Campo_Regatas](
	[nombre_campo] [char](20) NOT NULL,
	[puerto] [nvarchar](30) NOT NULL,
	[longitud] [float] NOT NULL,
	[latitud_llegada] [decimal](7, 4) NOT NULL,
	[longitud_llegada] [decimal](7, 4) NOT NULL,
 CONSTRAINT [PKCampoRegatas] PRIMARY KEY CLUSTERED 
(
	[nombre_campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Clases]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Clases](
	[nombre] [char](15) NOT NULL,
	[eslora] [float] NULL,
	[manga] [float] NULL,
	[mastil] [float] NULL,
	[tripulantes] [tinyint] NOT NULL,
 CONSTRAINT [PKClases] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Cursos]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Cursos](
	[codigo_curso] [int] NOT NULL,
	[denominacion] [varchar](40) NOT NULL,
	[f_inicio] [date] NOT NULL,
	[duracion] [smallint] NOT NULL,
	[licencia] [int] NOT NULL,
 CONSTRAINT [PKCursos] PRIMARY KEY CLUSTERED 
(
	[codigo_curso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Miembros]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Miembros](
	[licencia_federativa] [int] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[apellidos] [varchar](30) NOT NULL,
	[direccion] [varchar](40) NULL,
	[f_nacimiento] [smalldatetime] NULL,
 CONSTRAINT [PKMiembros] PRIMARY KEY CLUSTERED 
(
	[licencia_federativa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Miembros_Barcos_Regatas]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Miembros_Barcos_Regatas](
	[licencia_miembro] [int] NOT NULL,
	[n_vela] [int] NOT NULL,
	[f_inicio_regata] [date] NOT NULL,
	[patron] [char](1) NOT NULL,
	[Campo] [char](20) NOT NULL,
 CONSTRAINT [PKMiembrosBarcosRegatas] PRIMARY KEY CLUSTERED 
(
	[licencia_miembro] ASC,
	[n_vela] ASC,
	[f_inicio_regata] ASC,
	[Campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Miembros_Cursos]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LS_Miembros_Cursos](
	[licencia_federativa] [int] NOT NULL,
	[codigo_curso] [int] NOT NULL,
 CONSTRAINT [PKMiembrosCursos] PRIMARY KEY CLUSTERED 
(
	[licencia_federativa] ASC,
	[codigo_curso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LS_Monitores]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Monitores](
	[licencia_federativa] [int] NOT NULL,
	[SS] [char](12) NOT NULL,
	[DI] [char](9) NOT NULL,
	[tel_f] [char](12) NULL,
	[tel_m] [char](12) NULL,
	[categoria] [char](1) NOT NULL,
 CONSTRAINT [PKMonitores] PRIMARY KEY CLUSTERED 
(
	[licencia_federativa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LS_Regatas]    Script Date: 13/06/2017 22:14:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LS_Regatas](
	[nombre] [char](25) NOT NULL,
	[f_inicio] [date] NOT NULL,
	[intensidad_v] [smallint] NULL,
	[direccion_v] [smallint] NULL,
	[altura_olas] [decimal](2, 1) NULL,
	[temp_max] [smallint] NULL,
	[nombre_campo] [char](20) NOT NULL,
 CONSTRAINT [PKRegatas] PRIMARY KEY CLUSTERED 
(
	[f_inicio] ASC,
	[nombre_campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[LS_Barcos]  WITH CHECK ADD  CONSTRAINT [FKBarcosClases] FOREIGN KEY([nombre_clase])
REFERENCES [dbo].[LS_Clases] ([nombre])
GO
ALTER TABLE [dbo].[LS_Barcos] CHECK CONSTRAINT [FKBarcosClases]
GO
ALTER TABLE [dbo].[LS_Cursos]  WITH CHECK ADD  CONSTRAINT [FKCursosMonitores] FOREIGN KEY([licencia])
REFERENCES [dbo].[LS_Monitores] ([licencia_federativa])
GO
ALTER TABLE [dbo].[LS_Cursos] CHECK CONSTRAINT [FKCursosMonitores]
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas]  WITH CHECK ADD  CONSTRAINT [FKMiembrosBarcosRegatas_Barcos] FOREIGN KEY([n_vela])
REFERENCES [dbo].[LS_Barcos] ([n_vela])
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas] CHECK CONSTRAINT [FKMiembrosBarcosRegatas_Barcos]
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas]  WITH CHECK ADD  CONSTRAINT [FKMiembrosBarcosRegatas_Miembros] FOREIGN KEY([licencia_miembro])
REFERENCES [dbo].[LS_Miembros] ([licencia_federativa])
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas] CHECK CONSTRAINT [FKMiembrosBarcosRegatas_Miembros]
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas]  WITH CHECK ADD  CONSTRAINT [FKMiembrosBarcosRegatas_Regatas] FOREIGN KEY([f_inicio_regata], [Campo])
REFERENCES [dbo].[LS_Regatas] ([f_inicio], [nombre_campo])
GO
ALTER TABLE [dbo].[LS_Miembros_Barcos_Regatas] CHECK CONSTRAINT [FKMiembrosBarcosRegatas_Regatas]
GO
ALTER TABLE [dbo].[LS_Miembros_Cursos]  WITH CHECK ADD  CONSTRAINT [FKMiembrosCursos_Cursos] FOREIGN KEY([codigo_curso])
REFERENCES [dbo].[LS_Cursos] ([codigo_curso])
GO
ALTER TABLE [dbo].[LS_Miembros_Cursos] CHECK CONSTRAINT [FKMiembrosCursos_Cursos]
GO
ALTER TABLE [dbo].[LS_Miembros_Cursos]  WITH CHECK ADD  CONSTRAINT [FKMiembrosCursos_Miembros] FOREIGN KEY([licencia_federativa])
REFERENCES [dbo].[LS_Miembros] ([licencia_federativa])
GO
ALTER TABLE [dbo].[LS_Miembros_Cursos] CHECK CONSTRAINT [FKMiembrosCursos_Miembros]
GO
ALTER TABLE [dbo].[LS_Monitores]  WITH CHECK ADD  CONSTRAINT [FKMonitoresMiembros] FOREIGN KEY([licencia_federativa])
REFERENCES [dbo].[LS_Miembros] ([licencia_federativa])
GO
ALTER TABLE [dbo].[LS_Monitores] CHECK CONSTRAINT [FKMonitoresMiembros]
GO
ALTER TABLE [dbo].[LS_Regatas]  WITH CHECK ADD  CONSTRAINT [FK_Regatas_CampoRegatas] FOREIGN KEY([nombre_campo])
REFERENCES [dbo].[LS_Campo_Regatas] ([nombre_campo])
GO
ALTER TABLE [dbo].[LS_Regatas] CHECK CONSTRAINT [FK_Regatas_CampoRegatas]
GO
ALTER TABLE [dbo].[LS_Barcos]  WITH CHECK ADD  CONSTRAINT [CKBarcos__estado] CHECK  (([estado_conservacion]>=(0) AND [estado_conservacion]<=(10)))
GO
ALTER TABLE [dbo].[LS_Barcos] CHECK CONSTRAINT [CKBarcos__estado]
GO
ALTER TABLE [dbo].[LS_Barcos]  WITH CHECK ADD  CONSTRAINT [CKBarcos__f_adq] CHECK  (([f_adquisicion]<getdate()))
GO
ALTER TABLE [dbo].[LS_Barcos] CHECK CONSTRAINT [CKBarcos__f_adq]
GO
ALTER TABLE [dbo].[LS_Campo_Regatas]  WITH CHECK ADD  CONSTRAINT [CK_Longitud] CHECK  (([longitud]>=(1.5) AND [longitud]<=(150.5)))
GO
ALTER TABLE [dbo].[LS_Campo_Regatas] CHECK CONSTRAINT [CK_Longitud]
GO
ALTER TABLE [dbo].[LS_Cursos]  WITH CHECK ADD  CONSTRAINT [CK_Duracion] CHECK  (([duracion]>=(5) AND [duracion]<=(300)))
GO
ALTER TABLE [dbo].[LS_Cursos] CHECK CONSTRAINT [CK_Duracion]
GO
ALTER TABLE [dbo].[LS_Miembros]  WITH CHECK ADD  CONSTRAINT [CKMiembroEdad] CHECK  (([f_nacimiento]<getdate()))
GO
ALTER TABLE [dbo].[LS_Miembros] CHECK CONSTRAINT [CKMiembroEdad]
GO
ALTER TABLE [dbo].[LS_Monitores]  WITH CHECK ADD  CONSTRAINT [CKMonitoresCategorias] CHECK  (([categoria]='A' OR [categoria]='B' OR [categoria]='C'))
GO
ALTER TABLE [dbo].[LS_Monitores] CHECK CONSTRAINT [CKMonitoresCategorias]
GO
