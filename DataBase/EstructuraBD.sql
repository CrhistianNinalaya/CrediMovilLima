USE MASTER
GO

IF DB_ID('BD_BANKOFLIMA') IS NOT NULL
BEGIN
	DROP DATABASE BD_BANKOFLIMA
END
GO

CREATE DATABASE BD_BANKOFLIMA
GO

USE BD_BANKOFLIMA
GO

--En SQL Server, un schema es una forma de organizar y asegurar objetos de base de datos como tablas, vistas, procedimientos almacenados, entre otros1. Sirve para:

--Organizar los objetos de la base de datos en grupos l�gicos, lo que facilita su gesti�n.
--Controlar el acceso a los datos, ya que puedes asignar permisos a nivel de schema.
--Simplificar las referencias a objetos, ya que no necesitas especificar el propietario individualmente.
--Para un proyecto de banca m�vil, podr�as considerar crear schemas que reflejen las diferentes �reas funcionales de tu aplicaci�n, por ejemplo:

--Clientes: Para manejar informaci�n de los usuarios de la banca m�vil.
--Cuentas: Para gestionar los diferentes tipos de cuentas bancarias.
--Transacciones: Para registrar todas las operaciones realizadas.
--Seguridad: Para controlar el acceso y la autenticaci�n de los usuarios.
--Auditor�a: Para llevar un registro de las actividades para prop�sitos de seguridad y cumplimiento.
--Cada schema puede contener las tablas y objetos necesarios para manejar la informaci�n y la l�gica de negocio relacionada con esa �rea espec�fica2. Adem�s, es importante considerar las tendencias y caracter�sticas que debe tener una aplicaci�n de banca m�vil, como la seguridad, la usabilidad y la integraci�n con otros servicios3.

--Recuerda que la estructura exacta de los schemas depender� de los requisitos espec�ficos de tu proyecto y de las mejores pr�cticas de dise�o de bases de datos. �Espero que esta informaci�n te sea �til para tu proyecto de banca m�vil!

IF OBJECT_ID('USUARIOS') IS NOT NULL
BEGIN
	DROP TABLE USUARIOS
END
GO
CREATE TABLE USUARIOS
(
	DOCIDENTIDAD	VARCHAR(8)	PRIMARY KEY	NOT NULL,
	APEPATERNO		VARCHAR(30)	NOT NULL,
	APEMATERNO		VARCHAR(30)	NOT NULL,
	NOMBRES			VARCHAR(60)	NOT NULL,
	EDAD			INT			NOT NULL,
	CONTRASENIA		VARCHAR(20)	NOT NULL
)
GO

IF OBJECT_ID('CUENTAS') IS NOT NULL
BEGIN
	DROP TABLE CUENTAS
END
GO
CREATE TABLE CUENTAS
(
	NUMERO			CHAR(20)	NOT NULL PRIMARY KEY,
	DOCIDENTIDAD	VARCHAR(8)		NOT NULL REFERENCES USUARIOS,
	SALDO			MONEY		NOT NULL,
	MONEDA			VARCHAR(10)	NOT NULL
)
GO

IF OBJECT_ID('CUENTAAHORRO') IS NOT NULL
BEGIN
	DROP TABLE CUENTAAHORRO
END
CREATE TABLE CUENTAAHORRO
(
	NUMERO			CHAR(20)		NOT NULL REFERENCES CUENTAS,
	TASAINTERES		DECIMAL(10,2)	NOT NULL,
	OPERACIONESGRATIS	INT				NOT NULL
)
GO

IF OBJECT_ID('CUENTACORRIENTE')	IS NOT NULL
BEGIN
	DROP TABLE CUENTACORRIENTE
END
GO
CREATE TABLE CUENTACORRIENTE
(
	NUMERO			CHAR(20)		NOT NULL REFERENCES CUENTAS,
	COSTMANTENI		DECIMAL(10,2)	NOT NULL,
	SOBREGIRO		DECIMAL(10,2)	NOT NULL
)
GO