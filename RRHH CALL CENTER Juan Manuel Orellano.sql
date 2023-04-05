-- PRIMER PASO
-- Creación del esquema "Enterprise"

CREATE SCHEMA IF NOT EXISTS enterprise;

-- Uso del esquema

USE enterprise;

-- SEGUNDO PASO
-- Creación de las tablas

-- Tabla: ESTADOS

CREATE TABLE IF NOT EXISTS ESTADOS (
Id_Est_Func	Int Auto_increment Unique Not null PRIMARY KEY ,
Fec_Init_Est Date,
Fec_Fin_Est	Date,
Est_Func Varchar(30));

-- Tabla: DOMICILIO

CREATE TABLE IF NOT EXISTS DOMICILIO (
Id_Dom	Int Auto_increment Unique Not null PRIMARY KEY,
País_Dom Varchar(20),
Prov_Dom Varchar(20),
Loc_Dom Varchar(35),
Calle_Dom Varchar(25),
Num_Dom Int,
Piso_Dom Int,
Dep_Dom Varchar(4),
EC1_Dom Varchar(25),
EC2_Dom Varchar(25));

-- Tabla: FUNCION

CREATE TABLE IF NOT EXISTS FUNCION (
Id_Func Int Auto_increment Unique Not null PRIMARY KEY,
Fec_Alta_Func Date,
Cargo_Func Varchar(35),
Hor_Func Varchar(13),
Turno_Func Varchar(2),
Id_Est_Func Int,
FOREIGN KEY (Id_Est_Func) 
REFERENCES ESTADOS(Id_Est_Func),
Observ_Func Varchar(250),
Fec_Baja_Func Date);

-- Tabla: Área

CREATE TABLE IF NOT EXISTS AREA (
Id_A Int Auto_increment Unique Not null PRIMARY KEY,
Nomb_A Varchar(35),
Ger Varchar(35),
Dir_A Varchar(35),
Clase_A Varchar(3));

-- Tabla: Contacto

CREATE TABLE IF NOT EXISTS CONTACTO (
Id_Contact	Int Auto_increment Unique Not null PRIMARY KEY,
Tel_Contact Int,
Cel_Contact Int,
Mail_Contact Varchar(50),
MailC_Contact Varchar(50),
Red_Contact Varchar(50));

-- Tabla: Personal

CREATE TABLE IF NOT EXISTS PERSONAL(
Id_Pers Int Auto_increment Unique Not null PRIMARY KEY,
Id_A Int,
FOREIGN KEY (Id_A) 
REFERENCES AREA(Id_A),
Id_Func Int,
FOREIGN KEY (Id_Func) 
REFERENCES FUNCION(Id_Func),
Id_Dom Int,
FOREIGN KEY (Id_Dom) 
REFERENCES DOMICILIO(Id_Dom),
Id_Contact Int,
FOREIGN KEY (Id_Contact) 
REFERENCES CONTACTO(Id_Contact),
Nomb_Pers Varchar(50),
Ape_Pers Varchar(50),
DNI_Pers Int,
Fec_Nac Date,
Gen_Pers Varchar(1));

-- Tabla: CODIGO_PRESENTISMO

CREATE TABLE IF NOT EXISTS CODIGO_PRESENTISMO(  
    Id_Presentismo	Int Auto_increment Unique Not null PRIMARY KEY ,
    Presentismo	varchar(20));

-- Tabla: TABLA_PRESENTISMO

CREATE TABLE IF NOT EXISTS TABLA_PRESENTISMO(  
    Id_Pres	Int Auto_increment Unique Not null PRIMARY KEY ,
    Fecha date,
    Id_Presentismo int,
    FOREIGN KEY (Id_Presentismo) 
    REFERENCES CODIGO_PRESENTISMO(Id_Presentismo),
    Id_Pers	int,
    FOREIGN KEY (Id_Pers) 
    REFERENCES PERSONAL(Id_Pers));

-- Tabla: ARTICULOS

CREATE TABLE IF NOT EXISTS ARTICULOS(  
    Id_Art	Int Auto_increment Unique Not null PRIMARY KEY ,
    Articulo varchar(50),
    Prec_Art float(8,2),
    Stock_Disp int);

-- Tabla: TIPO_IVA

CREATE TABLE IF NOT EXISTS TIPO_IVA(  
    Id_TIVA	Int Auto_increment Unique Not null PRIMARY KEY ,
    Tipo_IVA varchar(10),
    Gravamen float(8,2));

-- Tabla: FACTURAS

CREATE TABLE IF NOT EXISTS FACTURAS(  
    Id_componente Int Auto_increment Unique Not null PRIMARY KEY ,
    Id_Art	int,
    FOREIGN KEY (Id_Art) 
    REFERENCES  ARTICULOS(Id_Art),    
    Q_Art int,
    Prec_Art float(8,2),
    Gravamen float(8,2),
    Id_Fc int);

-- Tabla: Clientes_fc

CREATE TABLE IF NOT EXISTS CLIENTES_FC(  
    Id_cliente	Int Auto_increment Unique Not null PRIMARY KEY ,
    Nomb_cliente	varchar(50),
    CUIT_cliente	int not null,
    DNI_cliente	int,
    IIBB_cliente	int);

-- Tabla: Direccion_entrega

CREATE TABLE IF NOT EXISTS DIRECCION_ENTREGA(  
    Id_dir_ent	Int Auto_increment Unique Not null PRIMARY KEY ,
    Id_cliente	int,
    FOREIGN KEY (Id_cliente) 
    REFERENCES  CLIENTES_FC(Id_cliente),
    País_Dom	varchar(20),
    Prov_Dom	varchar(20),
    Loc_Dom	varchar(35),
    Calle_Dom	varchar(25),
    Num_Dom	int,
    Piso_Dom	int,
    Dep_Dom	varchar(4),
    EC1_Dom	varchar(25),
    EC2_Dom	varchar(25));

-- Tabla: Clientes_contacto

CREATE TABLE IF NOT EXISTS CLIENTES_CONTACT(  
    Id_contacto_cliente
	Int Auto_increment Unique Not null PRIMARY KEY ,
    Id_cliente	int,
    FOREIGN KEY (Id_cliente) 
    REFERENCES  CLIENTES_FC(Id_cliente),
    Tel_Contact	varchar(50),
    Cel_Contact	varchar(50),
    Mail_Contact varchar(50));

-- Tabla: VENTAS

CREATE TABLE IF NOT EXISTS VENTAS(  
    Id_Vta	Int Auto_increment Unique Not null PRIMARY KEY ,
    Fecha	date,
    Id_Pers	int,
    FOREIGN KEY (Id_Pers) 
    REFERENCES PERSONAL(Id_Pers),
    Id_cliente	int,
    FOREIGN KEY (Id_cliente) 
    REFERENCES CLIENTES_FC(Id_cliente),
    Id_dir_ent	int,
    FOREIGN KEY (Id_dir_ent) 
    REFERENCES DIRECCION_ENTREGA(Id_dir_ent),
    Id_Fc	int);
    
-- TERCER PASO
-- ADICION DE DATOS A LAS TABLAS

-- Datos de Estados

INSERT INTO ESTADOS (Fec_Init_Est, Fec_Fin_Est, Est_Func) VALUES
('2022-01-01', '2032-01-01', 'ACTIVO'),
('2022-11-01', '2022-11-15', 'VACACIONES'),
('2022-11-16', '2022-11-30', 'VACACIONES'),
('2022-12-01', '2022-12-15', 'VACACIONES'),
('2022-12-16', '2022-12-31', 'VACACIONES');

-- Datos Domicilio

INSERT INTO DOMICILIO (País_Dom, Prov_Dom, Loc_Dom, Calle_Dom, Num_Dom, Piso_Dom, Dep_Dom, EC1_Dom, EC2_Dom) VALUES
('Argentina', 'Buenos Aires', 'Hurlingham', 'Guayra', 3123, 1, 'B', 'Tigre', 'Mar del Plata'),
('Argentina', 'Buenos Aires', 'Caseros', 'Avellaneda', 123, 2, 'A', 'Alsina', 'Yrigoyen'),
('Argentina', 'Buenos Aires', 'Quilmes', '25 de mayo', 2876, 1, 'C', 'Rosas', '9 de julio'),
('Argentina', 'CABA', 'CABA', 'Rivadavia', 456, 3, 'J', 'Esmeralda', 'Maipú'),
('Argentina', 'Buenos Aires', 'hurlingham', 'Vergara', 1237, 2, 'A', 'Bahia Blanca', 'Santiago');

-- Datos Función

INSERT INTO FUNCION (Fec_Alta_Func, Cargo_Func, Hor_Func, Turno_Func, Id_Est_Func) VALUES
('2022-01-01', 'SUPERVISOR', '10:00 - 15:00', 'TM', 1),
('2022-01-01', 'SUPERVISOR', '15:00 - 20:00', 'TT', 1),
('2022-01-01', 'SUPERVISOR', '10:00 - 18:00', 'SD', 1),
('2022-01-01', 'GERENTE', '09:00 - 17:00', 'GG', 1),
('2022-01-01', 'ADMINISTRATIVO', '10:00 - 18:00', 'AD', 1);

-- Datos Áreas

INSERT INTO AREA (Nomb_A, Ger, Dir_A, Clase_A) VALUES
('CALL CENTER', 'VENTAS', 'COMERCIAL', 'OP'),
('CALL CENTER', 'ATENCION AL CLIENTE', 'COMERCIAL', 'OP'),
('CAPITAL HUMANO', 'PERSONAL', 'ADMINISTRACION', 'ADM'),
('DISTRIBUCION', 'VENTAS', 'COMERCIAL', 'OP'),
('REPORTES Y CONTROL', 'MARKETING', 'COMERCIAL', 'ADM');

-- Datos Contacto

INSERT INTO CONTACTO (Tel_Contact, Cel_Contact, Mail_Contact, MailC_Contact, Red_Contact) VALUES
(1122345634, 11238974, 'CONEJOBLANCO@HOTMAIL.COM', 'JUAN_PEREZ@ENTERPRISE.COM', 'JP_SUP.ENTERPRISE.COM'),
(1164905634, 11730774, 'ELMASCAPO1986@HOTMAIL.COM', 'JOSE_GALLARDO@ENTERPRISE.COM', 'JG_SUP.ENTERPRISE.COM'),
(1122878734, 11278134, 'ROBERTOSANCHEZ@HOTMAIL.COM', 'ROBERTO_SANCHEZ@ENTERPRISE.COM', 'RS_SUP.ENTERPRISE.COM'),
(1167845631, 11776674, 'ESTELAMARIS@HOTMAIL.COM', 'MARIANA_SHAW@ENTERPRISE.COM', 'MS_LOG.ENTERPRISE.COM'),
(1120817634, 11736925, 'MUSICO456@GMAIL.COM', 'ADRIAN_CAVIGLIA@ENTERPRISE.COM', 'JP_RRHH.ENTERPRISE.COM'),
(1162391634, 11238974, 'ONECOLE123@GMAIL.COM', 'SUSANA_COLEMAN@ENTERPRISE.COM', 'SC_VENTAS.ENTERPRISE.COM');

-- Datos Personal

INSERT INTO PERSONAL (Id_A, Id_Func, Id_Dom, Id_Contact, Nomb_Pers, Ape_Pers, DNI_Pers, Fec_Nac, Gen_Pers) VALUES
(1, 1, 1, 1, 'JUAN', 'PEREZ', 12123434, '1960-01-22', 'M'),
(1, 2, 2, 2, 'JOSE', 'GALLARDO', 13103531, '1960-08-07', 'M'),
(1, 3, 3, 3, 'ROBERTO', 'SANCHEZ', 21183635, '1970-11-26', 'M'),
(4, 1, 4, 4, 'MARIANA', 'SHAW', 23453746, '1974-06-06', 'F'),
(3, 5, 5, 5, 'ADRIAN', 'CAVIGLIA', 28000004, '1980-01-12', 'M'),
(5, 4, 5, 6, 'SUSANA', 'COLEMAN', 34078954, '1986-05-18', 'F');

-- Datos Código de Presentismo

INSERT INTO CODIGO_PRESENTISMO (Presentismo) VALUES
('PRESENTE'),
('TARDE'),
('AUSENTE'),
('LICENCIA MEDICA'),
('DIA DE ESTUDIO'),
('FRANCO'),
('VACACIONES');

-- Datos Tabla Presentismo

INSERT INTO TABLA_PRESENTISMO (Fecha, Id_Presentismo, Id_Pers) VALUES
('2022-01-02', 1, 1),
('2022-01-03', 1, 1),
('2022-01-04', 1, 1),
('2022-01-05', 3, 1),
('2022-01-06', 1, 1),
('2022-01-07', 6, 1),
('2022-01-08', 6, 1),
('2022-01-02', 1, 2),
('2022-01-03', 1, 2),
('2022-01-04', 4, 2),
('2022-01-05', 1, 2),
('2022-01-06', 1, 2),
('2022-01-07', 6, 2),
('2022-01-08', 6, 2),
('2022-01-02', 1, 3),
('2022-01-03', 1, 3),
('2022-01-04', 2, 3),
('2022-01-05', 1, 3),
('2022-01-06', 1, 3),
('2022-01-07', 6, 3),
('2022-01-08', 6, 3),
('2022-01-02', 1, 4),
('2022-01-03', 1, 4),
('2022-01-04', 2, 4),
('2022-01-05', 1, 4),
('2022-01-06', 1, 4),
('2022-01-07', 6, 4),
('2022-01-08', 6, 4);

-- Datos Tabla Artículos

INSERT INTO ARTICULOS (Articulo, Prec_Art, Stock_Disp) VALUES
('Protector Hepatico', 245, 2300),
('Rejuvenecedor', 295, 3300),
('Potenciador', 195, 1300),
('Adelgazante', 205, 2300);

-- Datos Tabla TIPO_IVA

INSERT INTO TIPO_IVA (Tipo_IVA, Gravamen) VALUES
('Consumidor', 0.21),
('Empresa', 0.11),
('Excento', 0.05);

-- Datos Tabla FACTURAS

INSERT INTO FACTURAS (Id_Art, Q_Art, Prec_Art, Gravamen, Id_Fc) VALUES
(1, 3, 735, 154.35, 1),
(1, 3, 735,	154.35, 2),
(2, 3, 885,	185.85, 2),
(3, 3, 585,	122.85, 3),
(4, 3, 615,	129.15, 4),
(1, 6, 1470, 308.7, 5),
(2, 6, 1770, 371.7, 5),
(2, 5, 1475, 309.75, 6);

-- Datos Tabla CLIENTES_FC

INSERT INTO CLIENTES_FC (Nomb_cliente, CUIT_cliente, DNI_cliente, IIBB_cliente) VALUES
('Juan Ortiz', 2034567123, 34567123, 34567123),
('Sandra Bello', 2037562320, 37562320, 37562320),
('José Basualdo', 2020459671, 20459671, 20459671),
('Elena Gilbert', 2005123726, 05123726, 05123726);

-- Datos Dirección de entrega

INSERT INTO DIRECCION_ENTREGA (Id_cliente, País_Dom, Prov_Dom, Loc_Dom, Calle_Dom, NUm_Dom, Piso_Dom, Dep_Dom, EC1_Dom, Ec2_Dom) VALUES
(1,'Argentina', 'Buenos Aires', 'Hurlingham', 'Guayra', 3189, 1, 'B', 'Tigre', 'Mar del Plata'),
(2,'Argentina', 'Buenos Aires', 'Caseros', 'Avellaneda', 180, 2, 'A', 'Alsina', 'Yrigoyen'),
(3,'Argentina', 'Buenos Aires', 'Quilmes', '25 de mayo', 2820, 1, 'C', 'Rosas', '9 de julio'),
(4,'Argentina', 'CABA', 'CABA', 'Rivadavia', 456, 3, 'J', 'Esmeralda', 'Maipú');

-- Datos Contacto de Cliente

INSERT INTO CLIENTES_CONTACT (Id_cliente, Tel_Contact, Cel_Contact, Mail_Contact) VALUES
(1, 1122345634, 11238974, 'ORTIZJUAN@HOTMAIL.COM'),
(2, 1164905634, 11730774, 'SANDRA_BELLO@HOTMAIL.COM'),
(3, 1122878734, 11278134, 'JOSEGERVASIOBASUALDO@HOTMAIL.COM'),
(4, 1167845631, 11776674, 'TEAMOSALVATORE@GMAIL.COM');

-- Datos Ventas

INSERT INTO VENTAS (Fecha, Id_Pers, Id_cliente, Id_dir_ent, Id_Fc) VALUES
('2022-01-03', 1,1,1,1),
('2022-01-03', 1,2,2,2),
('2022-01-04', 2,3,3,3),
('2022-01-05', 3,4,4,4),
('2022-01-05', 4,3,3,5),
('2022-01-06', 2,2,2,6);

-- CUARTO PASO
-- CREACION DE VISTAS

-- Creación de Vista Área Ventas. 

CREATE VIEW A_VENTAS AS
	(SELECT 
    P.Nomb_Pers, 
    P.Ape_Pers, 
    P.DNI_Pers, 
    P.Gen_Pers,
    A.Nomb_A, 
    A.Ger
    FROM PERSONAL P
    INNER JOIN AREA A
    ON P.Id_A = A.Id_A
    WHERE A.Ger='VENTAS');
    
-- Visualizar Área Ventas    

SELECT * FROM A_VENTAS;

-- Creación de Vista Funciones del Personal

CREATE VIEW PERS_FUNC AS
	(SELECT 
    P.Nomb_Pers, 
    P.Ape_Pers, 
    P.DNI_Pers, 
    P.Gen_Pers,
    F.Cargo_Func, 
    F.Hor_Func, 
    F.Turno_Func, 
    E.Est_Func,
    E.Fec_Init_Est, 
    E.Fec_Fin_Est 
    FROM PERSONAL P
    INNER JOIN FUNCION F
    ON F.Id_Func = P.Id_Func
    INNER JOIN ESTADOS E
    ON E.Id_Est_Func = F.Id_Est_Func
    );

-- Visualizar Funciones de Personal
   
SELECT * FROM PERS_FUNC;

-- Creación de Vista Datos Personales

CREATE VIEW D_PERSON AS
	(SELECT 
    P.Nomb_Pers, 
    P.Ape_Pers, 
    P.DNI_Pers, 
    P.Gen_Pers,
    D.País_Dom, 
    D.Prov_Dom, 
    D.Loc_Dom, 
    D.Calle_Dom, 
    D.Num_Dom, 
    D.Piso_Dom, 
    D.Dep_Dom, 
    D.EC1_Dom, 
    D.EC2_Dom,
    C.Tel_Contact, 
    C.Cel_Contact, 
    C.Mail_Contact
    FROM PERSONAL P
    INNER JOIN DOMICILIO D
    ON P.Id_Dom = D.Id_Dom
    INNER JOIN CONTACTO C
    ON P.Id_Contact = C.Id_Contact
    );
    
-- Visualizar Datos Personales

SELECT * FROM D_PERSON;

-- Creación de Vista Resumen por Área

CREATE VIEW R_AREA AS
	(SELECT 
     A.Nomb_A,
     count(P.Id_Pers)
     FROM AREA A
     INNER JOIN PERSONAL P
     ON P.Id_A = A.Id_A
     GROUP BY A.Nomb_A);

-- Visualizar Resumen por Área

SELECT * FROM R_AREA;

-- Creación de Vista Resumen por Provincia

CREATE VIEW R_PROV AS
	(SELECT 
     D.Prov_Dom,
     count(P.Id_Pers)
     FROM DOMICILIO D
     INNER JOIN PERSONAL P
     ON P.Id_Dom = D.Id_Dom
     GROUP BY D.Prov_Dom);

-- Visualizar Resumen por Área

SELECT * FROM R_PROV;

-- Vista para etiquetas de identificación

CREATE VIEW ETIQ AS
	(SELECT
  P.Nomb_Pers, 
  P.Ape_Pers, 
  F.Cargo_Func, 
  C.MailC_Contact
  FROM PERSONAL P
  INNER JOIN FUNCION F
  ON P.ID_FUNC = F.ID_FUNC
  INNER JOIN CONTACTO C
  ON P.ID_CONTACT = C.ID_CONTACT);

-- Visualizar datos para etiquetas de identificación

SELECT * FROM ETIQ;

-- QUINTO PASO
-- CREACION DE FUNCIONES

-- Función: Etiqueta Corporativa

DELIMITER //

CREATE FUNCTION etiqueta(nombre VARCHAR(50), apellido VARCHAR(50), función VARCHAR(35), email VARCHAR(50)) RETURNS VARCHAR(200) DETERMINISTIC
  BEGIN
    IF email IS NOT NULL THEN
      RETURN CONCAT('El mail corporativo de ', función, ' ', nombre, ' ' ,apellido, ' es: ', email);
    ELSE
      RETURN 'Aun no hay Email registrado';
    END IF;
  END

//
  
-- Uso de la función Etiqueta Corporativa
  
SELECT etiqueta('Juan', 'Pérez', 'supervisor', 'jp@morgan.com');
  
-- Función Antigüedad en días

DELIMITER // 

CREATE FUNCTION ds_ant(fec_alta DATE) RETURNS int DETERMINISTIC
BEGIN
	DECLARE antig int;
    SET antig = DATEDIFF(date(now()), fec_alta);
    RETURN antig;
END
    
//

-- Uso de la Función Antigüedad en Días

SELECT ds_ant('2022-01-01');

  
-- SEXTO PASO
-- PROCEDIMIENTOS ALMACENADOS

-- Procedimiento de consulta de ventas por destino

DELIMITER //

CREATE PROCEDURE ventasporciudad (IN Ciud varchar(30))
BEGIN
	SELECT * FROM direccion_entrega WHERE Loc_dom = Ciud;
END

//

-- Uso de la consulta de ventas por destino

call ventasporciudad('Hurlingham');

-- Procedimiento de consulta de ventas totales

DELIMITER //

CREATE PROCEDURE montoventas ()
BEGIN
	SELECT Id_Fc, sum(Q_Art) 'Art. Vendidos', sum(Prec_Art) 'Monto', sum(Gravamen) 'IVA' FROM facturas GROUP BY Id_Fc;
END

//

-- Uso de la consulta de ventas totales

call  montoventas();

-- SEPTIMO PASO
-- TRIGGERS

--  SET DE AUTOCOMMIT EN 0 PARA INICIAR LAS SENTENCIAS DE SUBLENGUAJE TCL

select @@autocommit;
set @@autocommit = 0;

-- Transacción de Eliminación de los registros de fechas de vacaciones asignadas.

START TRANSACTION;

DELETE FROM estados
WHERE Est_Func = 'VACACIONES';

-- ROLLBACK; -- Me permite "recuperar" los registros de fechas de vacaciones asignables

-- COMMIT; -- Me permite confirmar la eliminación realizada


-- Transacción de inserción de nuevos registros a la tabla FUNCION (serviría para agregar los nuevos operadores del Call Center de Ventas)

START TRANSACTION;

INSERT INTO FUNCION (Fec_Alta_Func, Cargo_Func, Hor_Func, Turno_Func, Id_Est_Func) VALUES
('2022-02-01', 'OPERADOR', '10:00 - 15:00', 'TM', 1),
('2022-02-01', 'OPERADOR', '10:00 - 15:00', 'TM', 1),
('2022-02-01', 'OPERADOR', '10:00 - 15:00', 'TM', 1),
('2022-02-01', 'OPERADOR', '10:00 - 15:00', 'TM', 1);

SAVEPOINT Ins_CC_TM;

select * from funcion

INSERT INTO FUNCION (Fec_Alta_Func, Cargo_Func, Hor_Func, Turno_Func, Id_Est_Func) VALUES
('2022-02-01', 'OPERADOR', '15:00 - 20:00', 'TT', 1),
('2022-02-01', 'OPERADOR', '15:00 - 20:00', 'TT', 1),
('2022-02-01', 'OPERADOR', '15:00 - 20:00', 'TT', 1),
('2022-02-01', 'OPERADOR', '15:00 - 20:00', 'TT', 1);

SAVEPOINT Ins_CC_TT;

-- RELEASE SAVEPOINT Ins_CC_TM -- Me permite "eliminar" el punto de retorno Ins_CC_TM

