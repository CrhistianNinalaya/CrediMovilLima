use master
--Inserciones
USE BD_CrediMovilLima
GO

--Schema General
INSERT INTO General.Moneda values
('M001','Soles'),
('M002','Dolares')
GO

--Schema Clientes
INSERT INTO Clientes.Cliente values
('Crhistian Daniel', 'Ninalaya Saenz', '77043719','crhistian@gmail.com','997226748'),
('Javier Alejandro', 'Santaolalla', '99725819','santaolalla@gmail.com','225778963')
GO

/*****************************************************/
INSERT INTO Clientes.Cuenta_InfoGeneral (IdCliente,IdMoneda) VALUES
(1001,'M001'),
(1002,'M002'),
(1002,'M002')
GO
INSERT INTO CONFIDENCIAL.Cuenta_CLV VALUES 
(1001, '377409'),
(1002,'698752')
GO

INSERT INTO Clientes.Cuenta_Digital (IdCuenta) values
(1001)
GO

INSERT INTO Clientes.Cuenta_Ilimitada (IdCuenta) values
(1002)
GO
/*****************************************************/




INSERT INTO CONFIDENCIAL.Cuenta_Numero (IdCuenta, NumCuenta, CCI) VALUES 
(1001, '001158759878954123', '01158758987895412365'),
(1002, '001112359875841258', '01112359875841258365')
GO

/**********************************************************/
--Tarjeta PSW Y CVV
INSERT INTO Credito.Tarjeta (IdCuenta,NumTarjeta) values
(1001,'4557883296854455'),
(1002,'4557883296854558'),
(1003,'4557883268544558')
go

INSERT INTO CONFIDENCIAL.PSW VALUES 
(3001,'3598'),
(3002,'3598'),
(3003,'3598')
go

INSERT INTO CONFIDENCIAL.CVV VALUES 
(3001,'378'),
(3002,'981'),
(3003,'385')
go

INSERT INTO CONFIDENCIAL.FecExpira (IdTarjeta) VALUES 
(3001),
(3002),
(3003)
GO

SELECT 
	IdTarjeta = tar.IdTarjeta,
	[Clave 4 Digitos]= PSW.Clave,
	CVV = CVV.CVV,
	[Fecha de Expiracion] = fec.FecExpiracion
FROM Credito.Tarjeta as TAR
	INNER JOIN CONFIDENCIAL.PSW as PSW ON TAR.IdTarjeta = PSW.IdTarjeta
	INNER JOIN CONFIDENCIAL.CVV AS CVV ON TAR.IdTarjeta = CVV.IdTarjeta
	INNER JOIN CONFIDENCIAL.FecExpira FEC ON TAR.IdTarjeta = FEC.IdTarjeta
ORDER BY TAR.IdTarjeta
GO
/**********************************************************/

select * from Clientes.Cuenta_InfoGeneral

SELECT* FROM Credito.Tarjeta

INSERT INTO Credito.LineaDeCredito 
(IdTarjeta,IdCliente,LineaCredito) VALUES
(3001,1002,4800)
GO

SELECT * FROM General.Moneda
SELECT * FROM Clientes.Cliente
SELECT * FROM Clientes.Cuenta_InfoGeneral




--FORMA EN QUE HAREMOS EL REGISTRO DE USUARIOS Y DEMAS INSERCIONES
--QUE REQUIERA INSERTAR EN MAS DE UNA TABLA A LA VEZ
--BEGIN TRANSACTION;

---- Insertar datos en la tabla de datos personales (Cuenta)
--INSERT INTO Cuenta (IdCuenta, Nombre, Apellido, Email) VALUES (1, 'Juan', 'Pérez', 'juan@example.com');

---- Insertar datos en la tabla de contraseñas
--INSERT INTO Contraseñas (IdCuenta, Contraseña) VALUES (1, 'mi_contraseña_secreta');

--COMMIT;