if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Centros_Empresas]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Centros] DROP CONSTRAINT FK_Centros_Empresas
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Plantilla_Empresas]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Plantilla] DROP CONSTRAINT FK_Plantilla_Empresas
GO

/****** Objeto: tabla [dbo].[Centros]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Centros]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Centros]
GO

/****** Objeto: tabla [dbo].[Plantilla]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Plantilla]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Plantilla]
GO

/****** Objeto: tabla [dbo].[Acucitas]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Acucitas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Acucitas]
GO

/****** Objeto: tabla [dbo].[Citas]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Citas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Citas]
GO

/****** Objeto: tabla [dbo].[Empresas]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Empresas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Empresas]
GO

/****** Objeto: tabla [dbo].[INICIO]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[INICIO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[INICIO]
GO

/****** Objeto: tabla [dbo].[TZONAS]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TZONAS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TZONAS]
GO

/****** Objeto: tabla [dbo].[Tipos_Combustibles]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tipos_Combustibles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tipos_Combustibles]
GO

/****** Objeto: tabla [dbo].[USUARIOS]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[USUARIOS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[USUARIOS]
GO

/****** Objeto: tabla [dbo].[calendario]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[calendario]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[calendario]
GO

/****** Objeto: tabla [dbo].[citasdia]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[citasdia]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[citasdia]
GO

/****** Objeto: tabla [dbo].[semaforo]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[semaforo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[semaforo]
GO

/****** Objeto: tabla [dbo].[tblUsers]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblUsers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblUsers]
GO

/****** Objeto: tabla [dbo].[zonas]    fecha de la secuencia de comandos: 21/03/2011 11:33:53 a.m. ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zonas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zonas]
GO

/****** Objeto: tabla [dbo].[Acucitas]    fecha de la secuencia de comandos: 21/03/2011 11:33:54 a.m. ******/
CREATE TABLE [dbo].[Acucitas] (
	[DP0600] [smallint] NOT NULL ,
	[DP0615] [smallint] NOT NULL ,
	[DP0630] [smallint] NOT NULL ,
	[DP0645] [smallint] NOT NULL ,
	[DP0700] [smallint] NOT NULL ,
	[DP0715] [smallint] NOT NULL ,
	[DP0730] [smallint] NOT NULL ,
	[DP0745] [smallint] NOT NULL ,
	[DP0800] [smallint] NOT NULL ,
	[DP0815] [smallint] NOT NULL ,
	[DP0830] [smallint] NOT NULL ,
	[DP0845] [smallint] NOT NULL ,
	[DP0900] [smallint] NOT NULL ,
	[DP0915] [smallint] NOT NULL ,
	[DP0930] [smallint] NOT NULL ,
	[DP0945] [smallint] NOT NULL ,
	[DP1000] [smallint] NOT NULL ,
	[DP1015] [smallint] NOT NULL ,
	[DP1030] [smallint] NOT NULL ,
	[DP1045] [smallint] NOT NULL ,
	[DP1100] [smallint] NOT NULL ,
	[DP1115] [smallint] NOT NULL ,
	[DP1130] [smallint] NOT NULL ,
	[DP1145] [smallint] NOT NULL ,
	[DP1200] [smallint] NOT NULL ,
	[DP1215] [smallint] NOT NULL ,
	[DP1230] [smallint] NOT NULL ,
	[DP1245] [smallint] NOT NULL ,
	[DP1300] [smallint] NOT NULL ,
	[DP1315] [smallint] NOT NULL ,
	[DP1330] [smallint] NOT NULL ,
	[DP1345] [smallint] NOT NULL ,
	[DP1400] [smallint] NOT NULL ,
	[DP1415] [smallint] NOT NULL ,
	[DP1430] [smallint] NOT NULL ,
	[DP1445] [smallint] NOT NULL ,
	[DP1500] [smallint] NOT NULL ,
	[DP1515] [smallint] NOT NULL ,
	[DP1530] [smallint] NOT NULL ,
	[DP1545] [smallint] NOT NULL ,
	[DP1600] [smallint] NOT NULL ,
	[DP1615] [smallint] NOT NULL ,
	[DP1630] [smallint] NOT NULL ,
	[DP1645] [smallint] NOT NULL ,
	[DP1700] [smallint] NOT NULL ,
	[DP1715] [smallint] NOT NULL ,
	[DP1730] [smallint] NOT NULL ,
	[DP1745] [smallint] NOT NULL ,
	[DP1800] [smallint] NOT NULL ,
	[DP1815] [smallint] NOT NULL ,
	[DP1830] [smallint] NOT NULL ,
	[DP1845] [smallint] NOT NULL ,
	[DP1900] [smallint] NOT NULL ,
	[DP1915] [smallint] NOT NULL ,
	[DP1930] [smallint] NOT NULL ,
	[DP1945] [smallint] NOT NULL ,
	[DP2000] [smallint] NOT NULL ,
	[DP2015] [smallint] NOT NULL ,
	[DP2030] [smallint] NOT NULL ,
	[DP2045] [smallint] NOT NULL ,
	[DP2100] [smallint] NOT NULL ,
	[DP2115] [smallint] NOT NULL ,
	[DP2130] [smallint] NOT NULL ,
	[DP2145] [smallint] NOT NULL ,
	[DP2200] [smallint] NOT NULL ,
	[DP2215] [smallint] NOT NULL ,
	[DP2230] [smallint] NOT NULL ,
	[DP2245] [smallint] NOT NULL ,
	[DR0600] [smallint] NOT NULL ,
	[DR0615] [smallint] NOT NULL ,
	[DR0630] [smallint] NOT NULL ,
	[DR0645] [smallint] NOT NULL ,
	[DR0700] [smallint] NOT NULL ,
	[DR0715] [smallint] NOT NULL ,
	[DR0730] [smallint] NOT NULL ,
	[DR0745] [smallint] NOT NULL ,
	[DR0800] [smallint] NOT NULL ,
	[DR0815] [smallint] NOT NULL ,
	[DR0830] [smallint] NOT NULL ,
	[DR0845] [smallint] NOT NULL ,
	[DR0900] [smallint] NOT NULL ,
	[DR0915] [smallint] NOT NULL ,
	[DR0930] [smallint] NOT NULL ,
	[DR0945] [smallint] NOT NULL ,
	[DR1000] [smallint] NOT NULL ,
	[DR1015] [smallint] NOT NULL ,
	[DR1030] [smallint] NOT NULL ,
	[DR1045] [smallint] NOT NULL ,
	[DR1100] [smallint] NOT NULL ,
	[DR1115] [smallint] NOT NULL ,
	[DR1130] [smallint] NOT NULL ,
	[DR1145] [smallint] NOT NULL ,
	[DR1200] [smallint] NOT NULL ,
	[DR1215] [smallint] NOT NULL ,
	[DR1230] [smallint] NOT NULL ,
	[DR1245] [smallint] NOT NULL ,
	[DR1300] [smallint] NOT NULL ,
	[DR1315] [smallint] NOT NULL ,
	[DR1330] [smallint] NOT NULL ,
	[DR1345] [smallint] NOT NULL ,
	[DR1400] [smallint] NOT NULL ,
	[DR1415] [smallint] NOT NULL ,
	[DR1430] [smallint] NOT NULL ,
	[DR1445] [smallint] NOT NULL ,
	[DR1500] [smallint] NOT NULL ,
	[DR1515] [smallint] NOT NULL ,
	[DR1530] [smallint] NOT NULL ,
	[DR1545] [smallint] NOT NULL ,
	[DR1600] [smallint] NOT NULL ,
	[DR1615] [smallint] NOT NULL ,
	[DR1630] [smallint] NOT NULL ,
	[DR1645] [smallint] NOT NULL ,
	[DR1700] [smallint] NOT NULL ,
	[DR1715] [smallint] NOT NULL ,
	[DR1730] [smallint] NOT NULL ,
	[DR1745] [smallint] NOT NULL ,
	[DR1800] [smallint] NOT NULL ,
	[DR1815] [smallint] NOT NULL ,
	[DR1830] [smallint] NOT NULL ,
	[DR1845] [smallint] NOT NULL ,
	[DR1900] [smallint] NOT NULL ,
	[DR1915] [smallint] NOT NULL ,
	[DR1930] [smallint] NOT NULL ,
	[DR1945] [smallint] NOT NULL ,
	[DR2000] [smallint] NOT NULL ,
	[DR2015] [smallint] NOT NULL ,
	[DR2030] [smallint] NOT NULL ,
	[DR2045] [smallint] NOT NULL ,
	[DR2100] [smallint] NOT NULL ,
	[DR2115] [smallint] NOT NULL ,
	[DR2130] [smallint] NOT NULL ,
	[DR2145] [smallint] NOT NULL ,
	[DR2200] [smallint] NOT NULL ,
	[DR2215] [smallint] NOT NULL ,
	[DR2230] [smallint] NOT NULL ,
	[DR2245] [smallint] NOT NULL ,
	[empresa] [char] (4) NOT NULL ,
	[centro] [char] (4) NOT NULL ,
	[Fecha] [smalldatetime] NOT NULL ,
	[tp] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[Citas]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[Citas] (
	[numero] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[Empresa] [char] (4) NOT NULL ,
	[centro] [char] (4) NOT NULL ,
	[fecha] [smalldatetime] NOT NULL ,
	[matricula] [char] (15) NOT NULL ,
	[telefono] [char] (15) NOT NULL ,
	[hora] [char] (4) NOT NULL ,
	[tiprec] [char] (1) NOT NULL ,
	[huecos] [smallint] NOT NULL ,
	[enviado] [char] (1) NULL ,
	[lista] [char] (1) NULL ,
	[usuario] [char] (10) NULL ,
	[grabado] [smalldatetime] NULL ,
	[origen] [char] (10) NULL ,
	[tp] [char] (1) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[Empresas]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[Empresas] (
	[Empresa] [char] (4) NOT NULL ,
	[Nombre] [char] (20) NOT NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[INICIO]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[INICIO] (
	[INICIO] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[TZONAS]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[TZONAS] (
	[CODIGO] [char] (2) NOT NULL ,
	[NOMBRE] [char] (60) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[Tipos_Combustibles]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[Tipos_Combustibles] (
	[Codigo] [varchar] (2) NOT NULL ,
	[descripcion] [varchar] (30) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[USUARIOS]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[USUARIOS] (
	[USUARIO] [char] (10) NOT NULL ,
	[NOMBRE] [char] (30) NOT NULL ,
	[CONTRASEÑA] [char] (10) NOT NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[calendario]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[calendario] (
	[clave] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[fecha] [smalldatetime] NULL ,
	[empresa] [char] (4) NULL ,
	[centro] [char] (4) NULL ,
	[FL] [char] (1) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[citasdia]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[citasdia] (
	[numero] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[Empresa] [char] (4) NOT NULL ,
	[centro] [char] (4) NOT NULL ,
	[fecha] [smalldatetime] NOT NULL ,
	[matricula] [char] (15) NOT NULL ,
	[telefono] [char] (15) NOT NULL ,
	[hora] [char] (4) NOT NULL ,
	[tiprec] [char] (1) NOT NULL ,
	[huecos] [smallint] NOT NULL ,
	[enviado] [char] (1) NULL ,
	[lista1] [char] (1) NULL ,
	[usuario] [char] (10) NULL ,
	[grabado] [smalldatetime] NULL ,
	[origen] [char] (10) NULL ,
	[atendido] [char] (1) NOT NULL ,
	[lista] [char] (1) NOT NULL ,
	[fallo] [char] (1) NOT NULL ,
	[horaatendido] [char] (4) NULL ,
	[listadirecta] [char] (1) NOT NULL ,
	[tp] [char] (1) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[semaforo]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[semaforo] (
	[color] [char] (1) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[tblUsers]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[tblUsers] (
	[UserId] [uniqueidentifier] NOT NULL ,
	[UserName] [varchar] (256) NOT NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[zonas]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[zonas] (
	[Zona] [char] (3) NOT NULL ,
	[empresa] [char] (4) NOT NULL ,
	[centro] [char] (4) NOT NULL ,
	[Nombre] [char] (100) NULL ,
	[direccion] [char] (100) NULL ,
	[cp] [char] (10) NULL ,
	[poblacion] [char] (60) NULL ,
	[provincia] [char] (60) NULL ,
	[tlf] [char] (10) NULL ,
	[foto] [char] (100) NULL ,
	[odbc] [char] (100) NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[Centros]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[Centros] (
	[Empresa] [char] (4) NOT NULL ,
	[Centro] [char] (4) NOT NULL ,
	[Nombre] [char] (30) NULL ,
	[Resumido] [char] (15) NULL ,
	[provincia] [smallint] NULL ,
	[Observacion] [char] (80) NULL ,
	[Mensaje] [char] (80) NULL ,
	[desde] [smalldatetime] NULL ,
	[hasta] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** Objeto: tabla [dbo].[Plantilla]    fecha de la secuencia de comandos: 21/03/2011 11:33:55 a.m. ******/
CREATE TABLE [dbo].[Plantilla] (
	[Numero] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[Empresa] [char] (4) NOT NULL ,
	[Centro] [char] (4) NOT NULL ,
	[Desde] [smalldatetime] NOT NULL ,
	[Hasta] [smalldatetime] NOT NULL ,
	[diferencia] [smallint] NOT NULL ,
	[Dias] [char] (7) NOT NULL ,
	[tp] [char] (1) NULL ,
	[D0600] [smallint] NOT NULL ,
	[D0615] [smallint] NOT NULL ,
	[D0630] [smallint] NOT NULL ,
	[D0645] [smallint] NOT NULL ,
	[D0700] [smallint] NOT NULL ,
	[D0715] [smallint] NOT NULL ,
	[D0730] [smallint] NOT NULL ,
	[D0745] [smallint] NOT NULL ,
	[D0800] [smallint] NOT NULL ,
	[D0815] [smallint] NOT NULL ,
	[D0830] [smallint] NOT NULL ,
	[D0845] [smallint] NOT NULL ,
	[D0900] [smallint] NOT NULL ,
	[D0915] [smallint] NOT NULL ,
	[D0930] [smallint] NOT NULL ,
	[D0945] [smallint] NOT NULL ,
	[D1000] [smallint] NOT NULL ,
	[D1015] [smallint] NOT NULL ,
	[D1030] [smallint] NOT NULL ,
	[D1045] [smallint] NOT NULL ,
	[D1100] [smallint] NOT NULL ,
	[D1115] [smallint] NOT NULL ,
	[D1130] [smallint] NOT NULL ,
	[D1145] [smallint] NOT NULL ,
	[D1200] [smallint] NOT NULL ,
	[D1215] [smallint] NOT NULL ,
	[D1230] [smallint] NOT NULL ,
	[D1245] [smallint] NOT NULL ,
	[D1300] [smallint] NOT NULL ,
	[D1315] [smallint] NOT NULL ,
	[D1330] [smallint] NOT NULL ,
	[D1345] [smallint] NOT NULL ,
	[D1400] [smallint] NOT NULL ,
	[D1415] [smallint] NOT NULL ,
	[D1430] [smallint] NOT NULL ,
	[D1445] [smallint] NOT NULL ,
	[D1500] [smallint] NOT NULL ,
	[D1515] [smallint] NOT NULL ,
	[D1530] [smallint] NOT NULL ,
	[D1545] [smallint] NOT NULL ,
	[D1600] [smallint] NOT NULL ,
	[D1615] [smallint] NOT NULL ,
	[D1630] [smallint] NOT NULL ,
	[D1645] [smallint] NOT NULL ,
	[D1700] [smallint] NOT NULL ,
	[D1715] [smallint] NOT NULL ,
	[D1730] [smallint] NOT NULL ,
	[D1745] [smallint] NOT NULL ,
	[D1800] [smallint] NOT NULL ,
	[D1815] [smallint] NOT NULL ,
	[D1830] [smallint] NOT NULL ,
	[D1845] [smallint] NOT NULL ,
	[D1900] [smallint] NOT NULL ,
	[D1915] [smallint] NOT NULL ,
	[D1930] [smallint] NOT NULL ,
	[D1945] [smallint] NOT NULL ,
	[D2000] [smallint] NOT NULL ,
	[D2015] [smallint] NOT NULL ,
	[D2030] [smallint] NOT NULL ,
	[D2045] [smallint] NOT NULL ,
	[D2100] [smallint] NOT NULL ,
	[D2115] [smallint] NOT NULL ,
	[D2130] [smallint] NOT NULL ,
	[D2145] [smallint] NOT NULL ,
	[D2200] [smallint] NOT NULL ,
	[D2215] [smallint] NOT NULL ,
	[D2230] [smallint] NOT NULL ,
	[D2245] [smallint] NOT NULL 
) ON [PRIMARY]
GO

