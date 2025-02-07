----TABLESPACE y CREACION DE USUARIO-------
/*
alter session set "_ORACLE_SCRIPT"=TRUE;
create user admin_vet identified by 1234;
*/
create tablespace TB_VET_FINAL datafile 'tbs_vet_final.ora' size 40M online;
create temporary tablespace TBS_VET_FINAL_TEMP tempfile 'tbs_vet_final_temp.ora' size 5M autoextend on;

alter user admin_vet default tablespace TBS_VET_FINAL
temporary tablespace TBS_VET_FINAL_TEMP
quota unlimited on TBS_VET_FINAL;


CREATE TABLE vet_citas (
    cita_id              NUMBER(5) NOT NULL,
    cita_fecha           TIMESTAMP(0) NOT NULL,
    cita_estado          VARCHAR2(1) NOT NULL,
    vet_mascotas_masc_id NUMBER(5) NOT NULL,
    vet_personas_per_id  NUMBER(5) NOT NULL
);

COMMENT ON COLUMN vet_citas.cita_id IS
    'Codigo Unico de la cita';

COMMENT ON COLUMN vet_citas.cita_fecha IS
    'Fecha agendada para la cita';

COMMENT ON COLUMN vet_citas.cita_estado IS
    'el estado de la cita será activo ''A'' o cancelada ''C''';

ALTER TABLE vet_citas ADD CONSTRAINT vet_citas_pk PRIMARY KEY ( cita_id );

CREATE TABLE vet_detalles_fac (
    facd_id                   NUMBER(5) NOT NULL,
    facd_cantidad             NUMBER(3) NOT NULL,
    facd_subtotal             NUMBER(5, 2) NOT NULL,
    facd_valoriva             NUMBER(5, 2) NOT NULL,
    fac_total                 NUMBER(6, 2) NOT NULL,
    facd_precios              NUMBER(5, 2) NOT NULL,
    vet_servicios_serv_codigo NUMBER(5) NOT NULL,
    vet_facturas_fac_id       NUMBER(5) NOT NULL
);

COMMENT ON COLUMN vet_detalles_fac.facd_id IS
    'Codigo Unico del detalle de factura';

COMMENT ON COLUMN vet_detalles_fac.facd_cantidad IS
    'Cantidad facturada de los servicios';

COMMENT ON COLUMN vet_detalles_fac.facd_subtotal IS
    'Subtotal por la cantidad de  servicios o productos, precio unitario x cantidad';

COMMENT ON COLUMN vet_detalles_fac.facd_valoriva IS
    'Valor del IVA aplicado total del servicio';

COMMENT ON COLUMN vet_detalles_fac.fac_total IS
    'Total a pagar por el servicio';

COMMENT ON COLUMN vet_detalles_fac.facd_precios IS
    'Precio por el servicio otorgado (individualmente)';

ALTER TABLE vet_detalles_fac ADD CONSTRAINT vet_detalles_fac_pk PRIMARY KEY ( facd_id );

CREATE TABLE vet_facturas (
    fac_id              NUMBER(5) NOT NULL,
    fac_fecha           DATE NOT NULL,
    fac_subtotal        NUMBER(5, 2) NOT NULL,
    fac_totaliva        NUMBER(5, 2) NOT NULL,
    fac_total           NUMBER(6, 2) NOT NULL,
    vet_usuarios_us_id  NUMBER(5) NOT NULL,
    vet_personas_per_id NUMBER(5) NOT NULL
);

COMMENT ON COLUMN vet_facturas.fac_id IS
    'Codigo Unico de la factura';

COMMENT ON COLUMN vet_facturas.fac_fecha IS
    'Fecha de emision de la factura';

COMMENT ON COLUMN vet_facturas.fac_subtotal IS
    'Subtotal de la factura';

COMMENT ON COLUMN vet_facturas.fac_totaliva IS
    'Valor total del IVA a pagar';

COMMENT ON COLUMN vet_facturas.fac_total IS
    'Total a pagar';

ALTER TABLE vet_facturas ADD CONSTRAINT vet_facturas_pk PRIMARY KEY ( fac_id );

CREATE TABLE vet_mascotas (
    masc_id                    NUMBER(5) NOT NULL,
    masc_nombre                VARCHAR2(50) NOT NULL,
    vet_personas_per_id        NUMBER(5) NOT NULL,
    vet_tiposmascotas_tipom_id VARCHAR2(5) NOT NULL
);

COMMENT ON COLUMN vet_mascotas.masc_id IS
    'Codigo Unico de la mascota';

COMMENT ON COLUMN vet_mascotas.masc_nombre IS
    'Nombre(s) de la mascota';

ALTER TABLE vet_mascotas ADD CONSTRAINT vet_mascotas_pk PRIMARY KEY ( masc_id );

CREATE TABLE vet_personas (
    per_id          NUMBER(5) NOT NULL,
    per_cedula      VARCHAR2(10) NOT NULL,
    per_nombre      VARCHAR2(50) NOT NULL,
    per_apellido    VARCHAR2(50) NOT NULL,
    per_direccion   VARCHAR2(100) NOT NULL,
    per_telefono    VARCHAR2(10) NOT NULL,
    per_correo      VARCHAR2(100) NOT NULL,
    per_coe         CHAR(1) NOT NULL,
    per_empleadoaov CHAR(1),
    per_estado      CHAR(1) NOT NULL
);

COMMENT ON COLUMN vet_personas.per_id IS
    'Codigo Unico de la persona';

COMMENT ON COLUMN vet_personas.per_cedula IS
    'Cedula de la persona';

COMMENT ON COLUMN vet_personas.per_nombre IS
    'Nombre(s) de la persona';

COMMENT ON COLUMN vet_personas.per_apellido IS
    'Apellido(s) de la persona';

COMMENT ON COLUMN vet_personas.per_direccion IS
    'Direccion de domicilio de la persona';

COMMENT ON COLUMN vet_personas.per_telefono IS
    'Numero de contacto de la persona';

COMMENT ON COLUMN vet_personas.per_correo IS
    'Correo electronico de la persona';

COMMENT ON COLUMN vet_personas.per_coe IS
    'C si es cliente o E si es empleado';

COMMENT ON COLUMN vet_personas.per_empleadoaov IS
    'A si es un empleado que brinda atencion al cliente o V si es veterinario';

COMMENT ON COLUMN vet_personas.per_estado IS
    'A si está activo o I si esta inactivo';

ALTER TABLE vet_personas ADD CONSTRAINT vet_personas_pk PRIMARY KEY ( per_id );

CREATE TABLE vet_razas (
    raza_id                    VARCHAR2(5) NOT NULL,
    raza_nombre                VARCHAR2(20) NOT NULL,
    vet_tiposmascotas_tipom_id VARCHAR2(5) NOT NULL
);

COMMENT ON COLUMN vet_razas.raza_id IS
    'Codigo unico de la raza';

COMMENT ON COLUMN vet_razas.raza_nombre IS
    'Raza de la mascota';

ALTER TABLE vet_razas ADD CONSTRAINT vet_razas_pk PRIMARY KEY ( raza_id );

CREATE TABLE vet_servicios (
    serv_codigo NUMBER(5) NOT NULL,
    serv_nombre VARCHAR2(50) NOT NULL,
    serv_precio NUMBER(5, 2) NOT NULL,
    serv_estado CHAR(1) NOT NULL,
    serv_iva    CHAR(1) NOT NULL
);

COMMENT ON COLUMN vet_servicios.serv_codigo IS
    'Codigo Unico del servicio';

COMMENT ON COLUMN vet_servicios.serv_nombre IS
    'Nombre del servicio';

COMMENT ON COLUMN vet_servicios.serv_precio IS
    'Precio del servicio';

COMMENT ON COLUMN vet_servicios.serv_estado IS
    'A si está activo o I si esta inactivo';

COMMENT ON COLUMN vet_servicios.serv_iva IS
    'S si posee IVA o N en caso contrario';

ALTER TABLE vet_servicios ADD CONSTRAINT vet_servicios_pk PRIMARY KEY ( serv_codigo );

CREATE TABLE vet_tiposmascotas (
    tipom_id     VARCHAR2(5) NOT NULL,
    tipom_nombre VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN vet_tiposmascotas.tipom_id IS
    'Codigo unico del tipo de mascota';

COMMENT ON COLUMN vet_tiposmascotas.tipom_nombre IS
    'Nombre del tipo de mascota (Perro, gato, hamster, tortuga, etc)';

ALTER TABLE vet_tiposmascotas ADD CONSTRAINT vet_tiposmascotas_pk PRIMARY KEY ( tipom_id );

CREATE TABLE vet_usuarios (
    us_id               NUMBER(5) NOT NULL,
    us_usuario          VARCHAR2(10) NOT NULL,
    us_contrasenia      VARCHAR2(10) NOT NULL,
    us_tipo             CHAR(1) NOT NULL,
    vet_personas_per_id NUMBER(5) NOT NULL
);

COMMENT ON COLUMN vet_usuarios.us_id IS
    'Codigo Unico del usuario';

COMMENT ON COLUMN vet_usuarios.us_usuario IS
    'Usuario (longitud max. de 10 caracteres)';

COMMENT ON COLUMN vet_usuarios.us_contrasenia IS
    'Contraseña del usuario (longitud max. de 10 caracteres)';

COMMENT ON COLUMN vet_usuarios.us_tipo IS
    'G si es un usuario  general o A si es un usaurio  administrativo';

CREATE UNIQUE INDEX vet_usuarios__idx ON
    vet_usuarios (
        vet_personas_per_id
    ASC );

ALTER TABLE vet_usuarios ADD CONSTRAINT vet_usuarios_pk PRIMARY KEY ( us_id );

ALTER TABLE vet_citas
    ADD CONSTRAINT vet_citas_vet_mascotas_fk FOREIGN KEY ( vet_mascotas_masc_id )
        REFERENCES vet_mascotas ( masc_id );

ALTER TABLE vet_citas
    ADD CONSTRAINT vet_citas_vet_personas_fk FOREIGN KEY ( vet_personas_per_id )
        REFERENCES vet_personas ( per_id );

ALTER TABLE vet_detalles_fac
    ADD CONSTRAINT vet_detf_fac_fk FOREIGN KEY ( vet_facturas_fac_id )
        REFERENCES vet_facturas ( fac_id );
 
ALTER TABLE vet_detalles_fac
    ADD CONSTRAINT vet_detf_serv_fk FOREIGN KEY ( vet_servicios_serv_codigo )
        REFERENCES vet_servicios ( serv_codigo );

ALTER TABLE vet_facturas
    ADD CONSTRAINT vet_facturas_vet_personas_fk FOREIGN KEY ( vet_personas_per_id )
        REFERENCES vet_personas ( per_id );

ALTER TABLE vet_facturas
    ADD CONSTRAINT vet_facturas_vet_usuarios_fk FOREIGN KEY ( vet_usuarios_us_id )
        REFERENCES vet_usuarios ( us_id );

ALTER TABLE vet_mascotas
    ADD CONSTRAINT vet_mascotas_vet_personas_fk FOREIGN KEY ( vet_personas_per_id )
        REFERENCES vet_personas ( per_id );
 
ALTER TABLE vet_mascotas
    ADD CONSTRAINT vet_masc_tp_fk FOREIGN KEY ( vet_tiposmascotas_tipom_id )
        REFERENCES vet_tiposmascotas ( tipom_id );

ALTER TABLE vet_razas
    ADD CONSTRAINT vet_razas_vet_tiposmascotas_fk FOREIGN KEY ( vet_tiposmascotas_tipom_id )
        REFERENCES vet_tiposmascotas ( tipom_id );

ALTER TABLE vet_usuarios
    ADD CONSTRAINT vet_usuarios_vet_personas_fk FOREIGN KEY ( vet_personas_per_id )
        REFERENCES vet_personas ( per_id );
        
-----------------------------------------------
-- Secuencias para auto-increment de tablas ---
create sequence v_tmas_seq start with 1;
create sequence v_ra_seq start with 1;
create sequence v_masc_seq start with 1;
create sequence v_per_seq start with 1;
create sequence v_cit_seq start with 1;
create sequence v_us_seq start with 1;
create sequence v_fac_seq start with 1;
create sequence v_serv_seq start with 1;
create sequence v_detf_seq start with 1;
------------------------------------------------
------------------------------------------------
----------------------------    TIPOS DE MASCOTAS   ----------------------------
insert into vet_tiposmascotas values (v_tmas_seq.nextval,'canino');
insert into vet_tiposmascotas values (v_tmas_seq.nextval,'felino');
insert into vet_tiposmascotas values (v_tmas_seq.nextval,'reptil');
insert into vet_tiposmascotas values (v_tmas_seq.nextval,'roedor');
insert into vet_tiposmascotas values (v_tmas_seq.nextval,'otro');
--select * from vet_tiposmascotas;
--------------------------------------------------------------------------------
----------------------------    RAZAS   ----------------------------------------
insert into vet_razas values(v_ra_seq.nextval,'Siames',(select tipom_id from vet_tiposmascotas where tipom_nombre like 'felino'));
insert into vet_razas values(v_ra_seq.nextval,'Labrador',(select tipom_id from vet_tiposmascotas where tipom_nombre like 'canino'));
insert into vet_razas values(v_ra_seq.nextval,'n/d',(select tipom_id from vet_tiposmascotas where tipom_nombre like 'otro'));
--SELECT * FROM vet_razas;
--------------------------------------------------------------------------------
----------------------------    MASCOTAS   -------------------------------------
insert into vet_mascotas values(v_masc_seq.nextval,'Rufus',(select per_id from vet_personas where per_nombre like 'Andrés'),(
select tipom_id from vet_tiposmascotas where tipom_nombre like 'canino'));
insert into vet_mascotas values(v_masc_seq.nextval,'Toby',(select per_id from vet_personas where per_nombre like 'Karen'),(
select tipom_id from vet_tiposmascotas where tipom_nombre like 'canino'));
--select * from vet_mascotas;
--------------------------------------------------------------------------------
----------------------------    PERSONAS   -------------------------------------
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'0000000000', 'Admin', 'Vet', '-', '0000000000', 'admin@ejemplo.com', 'E', 'A', 'A');
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'0950094508', 'Andrés', 'Encalada', '-', '0983586619', 'andres23102004@gmail.com', 'C', null, 'A');
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'0000000000', 'Karen', 'Ortiz', '-', '0000000000', 'karen@ejemplo.com', 'C', null, 'A');
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'0124466754', 'Carlos', 'General', '-', '0937162846', 'carlos@ejemplo.com', 'E', 'V', 'A');
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'1123544634', 'Mateo', 'Suarez', '-', '0987654321', 'mateo@ejemplo.com', 'E', 'A', 'A');
INSERT INTO vet_personas VALUES (v_per_seq.nextval,'0124435456', 'Paula', 'Acevedo', '-', '0981253462', 'paula@ejemplo.com', 'E', 'A', 'I');
--select * from vet_personas;
--------------------------------------------------------------------------------
----------------------------    CITAS   ----------------------------------------
insert into vet_citas values(v_cit_seq.nextval,(TO_TIMESTAMP('2025/02/15 10:30:00', 'YYYY/MM/DD HH24:MI:SS')),'A',2,
(select vet_personas_per_id from vet_mascotas where masc_id like 2));
--select * from vet_citas;
--------------------------------------------------------------------------------
----------------------------    USUARIOS   -------------------------------------
insert into vet_usuarios values (v_us_seq.nextval,'admin','admin','A',(select per_id from vet_personas where per_nombre like 'Admin'));
insert into vet_usuarios values (v_us_seq.nextval,'usr','usr','G',(select per_id from vet_personas where per_nombre like 'Carlos'));
insert into vet_usuarios values (v_us_seq.nextval,'mat123','123','G',(select per_id from vet_personas where per_nombre like 'Mateo'));
insert into vet_usuarios values (v_us_seq.nextval,'pau123','123','G',(select per_id from vet_personas where per_nombre like 'Paula'));
--select *from vet_usuarios;
--------------------------------------------------------------------------------
----------------------------    FACTURAS   -------------------------------------
insert into vet_facturas values (v_fac_seq.nextval,(TO_DATE('2024/02/20 10:35:23', 'yyyy/mm/dd hh24:mi:ss')),52.17,7.83,60,
(select us_id from vet_usuarios where us_usuario like 'mat123'),(select per_id from vet_personas where per_nombre like 'Andrés'));
--select * from vet_facturas;
--------------------------------------------------------------------------------
----------------------------    SERVICIOS  -------------------------------------
insert into vet_servicios values (v_serv_seq.nextval, 'Estirilización Perro Raza Pequeña',120,'A','S');
insert into vet_servicios values (v_serv_seq.nextval, 'Estirilización Perro Raza Mediana',150,'A','S');
insert into vet_servicios values (v_serv_seq.nextval, 'Estirilización Perro Raza Grande',200,'I','S');
insert into vet_servicios values (v_serv_seq.nextval, 'Estirilización Gato Pequeño',80,'A','S');
insert into vet_servicios values (v_serv_seq.nextval, 'Vacunacion completa',30.43,'A','N');
--select * from vet_servicios;
--------------------------------------------------------------------------------
----------------------------    DETALLES FACTURA   -----------------------------
insert into vet_detalles_fac values (v_detf_seq.nextval,1,30.43,0,30.43,30.43,(select serv_codigo from vet_servicios where serv_nombre like 'Vacunacion completa'),
(select fac_id from vet_facturas where fac_id like 2 ));

--select * from vet_detalles_fac;
commit;