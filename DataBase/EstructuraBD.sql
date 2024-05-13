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

--Recuerda que la estructura exacta de los schemas dependerá de los requisitos específicos de tu proyecto y de las mejores prácticas de diseño de bases de datos. ¡Espero que esta información te sea útil para tu proyecto de banca móvil!

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