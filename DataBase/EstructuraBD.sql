USE MASTER
GO

IF DB_ID('BD_CrediMovilLima') IS NOT NULL
BEGIN
	DROP DATABASE BD_CrediMovilLima
END
GO

CREATE DATABASE BD_CrediMovilLima
GO

USE BD_CrediMovilLima
GO

--En SQL Server, un schema es una forma de organizar y asegurar objetos de base de datos como tablas, vistas, procedimientos almacenados, entre otros1. 
--Sirve para:

--Organizar los objetos de la base de datos en grupos lógicos, lo que facilita su gestión.
--Controlar el acceso a los datos, ya que puedes asignar permisos a nivel de schema.
--Simplificar las referencias a objetos, ya que no necesitas especificar el propietario individualmente.
--Para un proyecto de banca móvil, podrías considerar crear schemas que reflejen las diferentes áreas funcionales de tu aplicación, por ejemplo:

--Clientes: Para manejar información de los usuarios de la banca móvil.
--Cuentas: Para gestionar los diferentes tipos de cuentas bancarias.
--Transacciones: Para registrar todas las operaciones realizadas.
--Seguridad: Para controlar el acceso y la autenticación de los usuarios.
--Auditoría: Para llevar un registro de las actividades para propósitos de seguridad y cumplimiento.
--Cada schema puede contener las tablas y objetos necesarios para manejar la información y la lógica de negocio relacionada con esa área específica2. Además, es importante considerar las tendencias y características que debe tener una aplicación de banca móvil, como la seguridad, la usabilidad y la integración con otros servicios3.

IF SCHEMA_ID('Clientes') IS NOT NULL
BEGIN
	DROP SCHEMA Clientes
END
GO
CREATE SCHEMA Clientes AUTHORIZATION dbo
GO

IF SCHEMA_ID('Credito') IS NOT NULL
BEGIN
	DROP SCHEMA Credito
END
GO
CREATE SCHEMA Credito AUTHORIZATION dbo
GO

IF SCHEMA_ID('General') IS NOT NULL
BEGIN
	DROP SCHEMA General
END
GO
CREATE SCHEMA General AUTHORIZATION dbo
GO

IF SCHEMA_ID('CONFIDENCIAL') IS NOT NULL
BEGIN
	DROP SCHEMA CONFIDENCIAL
END
GO
CREATE SCHEMA CONFIDENCIAL AUTHORIZATION dbo
GO


IF OBJECT_ID('General.Moneda', 'U') IS NOT NULL
BEGIN
	DROP TABLE General.Moneda
END
GO
CREATE TABLE General.Moneda
(
	IdMoneda	CHAR(4)  primary key,
	TipoMoneda	varchar(50),

	--CONSTRAINT CHK_TipoMoneda CHECK (TipoMoneda IN ('Soles', 'Dolares')),
	CONSTRAINT CHK_IdMoneda CHECK (IdMoneda like 'M[0-9]%')
)
GO

IF OBJECT_ID('Clientes.Cliente', 'U') IS NOT NULL
BEGIN
	DROP TABLE Clientes.Cliente
END
GO
CREATE TABLE Clientes.Cliente
(
	IdCliente	INT Identity(1001,1)	PRIMARY KEY,
	Nombres		VARCHAR(50)	NOT NULL,
	Apellidos	VARCHAR(50)	NOT NULL,
	DNI	VARCHAR(8)			NOT NULL,
	Correo		VARCHAR(50)	NOT NULL,
	Celular		VARCHAR(9)	NULL,

	CONSTRAINT UQ_DNI UNIQUE(DNI),
	CONSTRAINT UQ_CORREO	UNIQUE(Correo)

)
GO

IF OBJECT_ID('Clientes.Cuenta_InfoGeneral', 'U') IS NOT NULL
BEGIN
	DROP TABLE Clientes.Cuenta_InfoGeneral
END
GO
CREATE TABLE Clientes.Cuenta_InfoGeneral
(
	IdCuenta INT Identity(1001,1)  PRIMARY KEY,
	IdCliente	INT ,
	IdMoneda CHAR(4) NOT NULL,
	Saldo MONEY NOT NULL DEFAULT 0,
	FecApertura DATE NOT NULL DEFAULT GETDATE(),

	CONSTRAINT FK_Cuenta_Moneda FOREIGN KEY (IdMoneda) REFERENCES General.Moneda(IdMoneda),
	CONSTRAINT FK_Cuenta_Usuario FOREIGN KEY (IdCliente) REFERENCES Clientes.Cliente(IdCliente)
)
GO

IF OBJECT_ID('CONFIDENCIAL.Cuenta_CLV', 'U') IS NOT NULL
BEGIN
	DROP TABLE CONFIDENCIAL.Cuenta_CLV
END
GO
CREATE TABLE CONFIDENCIAL.Cuenta_CLV
(
	IdCuenta	INT primary key,
	ClaveSeisDigitos	char(6)

	FOREIGN KEY (IdCuenta) REFERENCES Clientes.Cuenta_InfoGeneral(IdCuenta),
	CONSTRAINT CHK_CLV CHECK (ClaveSeisDigitos like '[0-9]%')
)
GO

IF OBJECT_ID('CONFIDENCIAL.Cuenta_Numero', 'U') IS NOT NULL
BEGIN
	DROP TABLE CONFIDENCIAL.Cuenta_Numero
END
GO
CREATE TABLE CONFIDENCIAL.Cuenta_Numero
(
	IdCuenta	INT primary key,
	NumCuenta	char(18) NOT NULL,
	CCI			char(20) NOT NULL

	FOREIGN KEY (IdCuenta) REFERENCES Clientes.Cuenta_InfoGeneral(IdCuenta),

	CONSTRAINT CHK_NumCuenta CHECK (NumCuenta Like '0011[0-9]%'),
	CONSTRAINT CHK_CCI CHECK (CCI Like '[0-9]%'),
	CONSTRAINT UQ_NumCuenta UNIQUE (NumCuenta),
	CONSTRAINT UQ_CCI UNIQUE (CCI)
)
GO



IF OBJECT_ID('Clientes.Cuenta_Digital', 'U') IS NOT NULL
BEGIN
	DROP TABLE Clientes.Cuenta_Digital
END
GO
CREATE TABLE Clientes.Cuenta_Digital
(
	IdCuenta	INT primary key,	
	CostoMantenimiento MONEY DEFAULT 10,
	--Falta ver que atributos especificos tendrá
	NumOperaciones INT NOT NULL DEFAULT 2

	FOREIGN KEY (IdCuenta) REFERENCES Clientes.Cuenta_InfoGeneral(IdCuenta)
)
GO

IF OBJECT_ID('Clientes.Cuenta_Ilimitada', 'U') IS NOT NULL
BEGIN
	DROP TABLE Clientes.Cuenta_Ilimitada
END
GO
CREATE TABLE Clientes.Cuenta_Ilimitada
(
	IdCuenta	INT  primary key,	
	CostoMantenimiento MONEY DEFAULT 12,
	NumOperaciones INT NULL
	--Falta ver que atributos especificos tendrá
	FOREIGN KEY (IdCuenta) REFERENCES Clientes.Cuenta_InfoGeneral(IdCuenta)
)
GO



IF OBJECT_ID('Credito.Tarjeta', 'U') IS NOT NULL
BEGIN
	DROP TABLE Credito.Tarjeta
END
GO
CREATE TABLE Credito.Tarjeta
(
	IdTarjeta	INT Identity(3001,1) PRIMARY KEY,
	IdCuenta	INT ,		
	NumTarjeta	CHAR(16),
	/*Queremos la posibilidad de dar tarjeta adicional a otra persona en caso de 
	ser una tarjeta de credito y compartan la LineaDeCredito*/
	EsPrincipal	BIT DEFAULT 1, 

	FOREIGN KEY (IdCuenta) REFERENCES Clientes.Cuenta_InfoGeneral(IdCuenta),
	CONSTRAINT CHK_NumTarjeta CHECK (NumTarjeta like '455788[0-9]%'),
	CONSTRAINT UQ_NumTarjeta UNIQUE(NumTarjeta)
)
GO


IF OBJECT_ID('Confidencial.PSW', 'U') IS NOT NULL
BEGIN
	DROP TABLE Confidencial.PSW
END
GO
CREATE TABLE Confidencial.PSW
(
	IdTarjeta	INT PRIMARY KEY,
	Clave		CHAR(4)

	FOREIGN KEY (IdTarjeta) REFERENCES Credito.Tarjeta(IdTarjeta),
	CONSTRAINT CHK_Clave CHECK (Clave like '[0-9]%')
)
GO

IF OBJECT_ID('Confidencial.CVV', 'U') IS NOT NULL
BEGIN
	DROP TABLE Confidencial.CVV
END
GO
CREATE TABLE Confidencial.CVV
(
	IdTarjeta	INT PRIMARY KEY,
	CVV			CHAR(3)

	FOREIGN KEY (IdTarjeta) REFERENCES Credito.Tarjeta(IdTarjeta),
	CONSTRAINT CHK_CVV CHECK (CVV like '[0-9]%')
)
GO

IF OBJECT_ID('Confidencial.FecExpira', 'U') IS NOT NULL
BEGIN
	DROP TABLE Confidencial.FecExpira
END
GO
CREATE TABLE Confidencial.FecExpira
(
	IdTarjeta		INT PRIMARY KEY,

	--Agrega 5 años al actual para la FecExpiracion
	FecExpiracion	DATE DEFAULT DATEADD(YEAR,5,GETDATE())
	FOREIGN KEY (IdTarjeta) REFERENCES Credito.Tarjeta(IdTarjeta)
)
GO

IF OBJECT_ID('Credito.LineaDeCredito', 'U') IS NOT NULL
BEGIN
	DROP TABLE Credito.LineaDeCredito
END
GO
CREATE TABLE Credito.LineaDeCredito
(
	IdTarjeta		INT PRIMARY KEY,
	IdCliente		INT,
	LineaCredito	MONEY,
	TasaInteres		DECIMAL(5,2) DEFAULT 4.5,
	FechaAprobacion DATE DEFAULT GETDATE(),
	FechaVencimiento	DATE DEFAULT DATEADD(YEAR,5,GETDATE()),
	Estado			BIT DEFAULT 1,
	SaldoUsado		MONEY DEFAULT 0,

	FOREIGN KEY (IdTarjeta) REFERENCES Credito.Tarjeta(IdTarjeta),
	FOREIGN KEY (IdCliente) REFERENCES Clientes.Cliente(IdCliente)
)
GO


select * from Clientes.Cliente

select * from sys.schemas
select 
	[Tabla]=tab.name,
	[Schema]=sch.name 
from sys.tables as tab inner join sys.schemas as sch on sch.schema_id= tab.schema_id


