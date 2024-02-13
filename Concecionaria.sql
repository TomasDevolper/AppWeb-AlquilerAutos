Create database ConcesionariaAutos3;

Use ConcesionariaAutos3;
--------------------------------------------------------------------
create table Rol(
	ID_Rol int primary key IDENTITY (1, 1) NOT NULL,
	Descripcion varchar(20)
);
insert into Rol values ('Empleado');
insert into Rol values ('Administrador');

UPDATE ROL
SET Descripcion = 'Usuario'
WHERE ID_Rol = 1;

select Nombre,Email,Contraseña,ID_Rol from Usuarios where Email = 'Tomas@gmail.com' and Contraseña = '123';
select * from Rol
---------------------------------------------------------------------
create table Usuarios(
	ID_Usuario int primary key IDENTITY (1, 1) NOT NULL,
	Nombre varchar(50)not null,
	Email varchar(100)not null,
	Contraseña varchar(50)not null,
	ID_Rol int default '1',
	FOREIGN KEY(ID_Rol) REFERENCES Rol(ID_Rol)
);
insert into Usuarios values('Admin','Admin@gmail.com','admin',2);
INSERT INTO Usuarios (Nombre, Email, Contraseña) VALUES ('Tomas', 'Tomas@gmail.com', '123');
INSERT INTO Usuarios (Nombre, Email, Contraseña) VALUES ('Antonio', 'Antonio@gmail.com', '987');
select * from Usuarios;
----------------------------------------------------------------------
create table Autos(
	ID_Autos int primary key IDENTITY (1, 1) NOT NULL,
	Matricula varchar(6) not null,
	Marca varchar(50) not null,
	Modelo varchar(50) not null,
	Año char(4)not null,
	Color varchar(30)not null,
	Precio decimal(8,2)not null,
	Imag varchar(250)not null,
	Disponibilidad bit not null,
);
insert into Autos values('A8Z763','Porsche','GTR3','2005','Gris','500','/Recursos/porsche.jpg',1);

-- Audi RS
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('ABC123', 'Audi', 'RS', '2022', 'Rojo', '1000', '/Recursos/AudiRS.jpg', 1);

-- Audi R8 Coupe
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('XYZ789', 'Audi', 'R8 Coupe', '2023', 'Azul', '1100', '/Recursos/audiR8Coupe.jpg', 1);

-- BMW M8
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('DEF456', 'BMW', 'M8', '2021', 'Negro', '1200', '/Recursos/bmwM8.jpg', 1);

-- BMW Z4
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('GHI789', 'BMW', 'Z4', '2022', 'Blanco', '1300', '/Recursos/bmwZ4.jpg', 1);

-- Nissan GTR
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('JKL012', 'Nissan', 'GTR', '2022', 'Amarillo', '1400', '/Recursos/nissanGTR.jpg', 1);

-- Toyota Supra
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('MNO345', 'Toyota', 'Supra', '2023', 'Verde', '1500', '/Recursos/toyotaSupra.jpg', 1);

-- Porsche 911
insert into Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad)
values ('PQR678', 'Porsche', '911', '2022', 'Gris', '1600', '/Recursos/porsche911.jpg', 1);

-- Verificar los datos insertados
select * from Autos;


----------------------------------------------------------------------
create table Tipo_Documento(
	ID_TipoDocumento int primary key IDENTITY (1,1) NOT NULL,
	Descripcion varchar(20)
);
insert into Tipo_Documento values('DNI');
insert into Tipo_Documento values('CARNET EXT');
insert into Tipo_Documento values('RUC');
insert into Tipo_Documento values('PASAPORTE');
insert into Tipo_Documento values('P.NAC');
select * from Tipo_Documento;
----------------------------------------------------------------------
create table Tipo_Brevete(
	ID_TipoBrevete int primary key IDENTITY (1,1) NOT NULL,
	Descripcion char(4)not null
);
insert into Tipo_Brevete values('A1');
insert into Tipo_Brevete values('A2A');
insert into Tipo_Brevete values('A2B');
select * from Tipo_Brevete;
---------------------------------------------------------------------
create table Alquiler(
	ID_Alquiler int primary key IDENTITY (1, 1) NOT NULL,
	ID_Usuario int, --fk
	ID_TipoDocumento int, --FK
	Documento char(15)Not null,
	ID_TipoBrevete int, --FK
	Brevete char(9),
	ID_Auto int, --FK	
	Dias int,
	Precio decimal(8,2),--Se generara automaticamnete con un procedimiento almacenado(se multiplicara con el precio de la tabla Autos)
	FOREIGN KEY(ID_Usuario) REFERENCES Usuarios(ID_Usuario),
	FOREIGN KEY(ID_TipoDocumento) REFERENCES Tipo_Documento(ID_TipoDocumento),
	FOREIGN KEY(ID_TipoBrevete) REFERENCES Tipo_Brevete(ID_TipoBrevete),
	FOREIGN KEY(ID_Auto) REFERENCES Autos(ID_Autos)
);
select * from Alquiler;
insert into Alquiler values(2,1,'74397537',2,'Q74397537',1,'1','500');
--------------------------------------------------------------------

--INER JOIN CON 4 TABLAS PARA EL HISTORIAL DE ALQUILERES
SELECT a.ID_Alquiler as 'Codigo', u.Nombre as 'Nombre', d.Descripcion as 'Tipo Documento', a.Documento as 'Documento', b.Descripcion as 'Tipo Brevete',
a.Brevete as 'Brevete', l.Marca as 'Marca', l.Modelo as 'Modelo', a.Dias as 'Dias' ,a.Precio as 'Precio'
FROM Alquiler a
INNER JOIN Tipo_Documento d ON a.ID_TipoDocumento = d.ID_TipoDocumento
INNER JOIN Tipo_Brevete b ON a.ID_TipoBrevete = b.ID_TipoBrevete
INNER JOIN Usuarios u ON a.ID_Usuario = u.ID_Usuario
INNER JOIN Autos l ON a.ID_Auto = l.ID_Autos;
---------------------------------------------------------------------------
-- METODO PARA PONER UN VALOR AL TIPO BOOL
/*SELECT
    Disponibilidad,
    CASE WHEN Disponibilidad = 1 THEN 'Verdadero' ELSE 'Falso' END AS Dispo_texto
FROM
    Autos;*/
-----------------------------------------------------------------------------------------
-- APLICAMOS LA SENTENCIA PARA LISTAR LOS AUTOS CON EL VALOR BOOL CAMBIADO A PALABRAS XD
SELECT ID_Autos , Matricula , Marca ,Modelo , Año , Color, Precio,
    CASE WHEN Disponibilidad = 1 THEN 'Si' ELSE 'No' END as 'Disponibilidad'
FROM Autos; 
-----------------------------------------------------------------------------------------
--PROCEDIMIENTO ALMACENADO QUE INGRESA ALQUILER Y CALCULA EL PRECIO DEL AQLUILER (PRECIO DEL AUTO POR LOS DIAS DE ALQUILER)+
/*CREATE PROCEDURE InsertarAlquilerYCalcularPrecio
    @NombreUsuario varchar(100),
    @ID_TipoDocumento int,
    @Documento char(15),
    @ID_TipoBrevete int,
    @Brevete char(9),
    @ID_Auto int,
    @Dias int
AS
BEGIN
    -- Declarar variables para almacenar el precio del auto y el precio total del alquiler
    DECLARE @PrecioAuto decimal(8, 2)
    DECLARE @PrecioTotal decimal(8, 2)

    -- Obtener el precio del auto para el ID_Auto proporcionado
    SELECT @PrecioAuto = Precio
    FROM Autos
    WHERE ID_Autos = @ID_Auto

    -- Calcular el precio total del alquiler
    SET @PrecioTotal = @Dias * @PrecioAuto

    -- Insertar los datos en la tabla Alquiler
    INSERT INTO Alquiler (NombreUsuario, ID_TipoDocumento, Documento, ID_TipoBrevete, Brevete, ID_Auto, Dias, Precio)
    VALUES (@NombreUsuario, @ID_TipoDocumento, @Documento, @ID_TipoBrevete, @Brevete, @ID_Auto, @Dias, @PrecioTotal)
END*/

----------------------------------------------------------------------------------------------------------------------------
SELECT ID_Autos , CONCAT(Marca, ' ', Modelo) AS 'Auto', Imag FROM Autos;
----------------------------------------------------------------------------------------------------------------------------
select Precio from Autos where ID_Autos = 1;

delete from Autos where ID_Autos = 2;
delete from Alquiler where ID_Alquiler = 2;
SELECT * FROM Alquiler
