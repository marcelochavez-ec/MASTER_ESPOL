create table tbl_paciente (
 pk_paciente serial primary key,
 nombre varchar(50) not null,
 nro_habitacion int not null,
 fk_departamento int not null,
 fk_dosificacion int not null
)

create table tbl_dosificacion (
 pk_dosificacion serial primary key,
 dosificacion varchar(10) not null,
 fk_farmaco int not null
)

create table tbl_farmaco (
 pk_farmaco serial primary key,
 nombre varchar(50) not null,
 fk_unidades_dia int not null
)

create table tbl_departamento (
 pk_departamento serial primary key,
 cod_departamento varchar(10) not null,
 nombre_departamento varchar(50) not null
)

create table tbl_administracion (
 pk_administracion serial primary key,
 metodo_administracion int
)

create table tbl_unidades_dia (
 pk_unidades_dia serial primary key, 
 fecha_inicio date not null,
 fecha_fin date not null,
 fk_administracion int not null
)

-- Insertar registros en la tabla tbl_paciente
INSERT INTO tbl_paciente (nombre, nro_habitacion, fk_departamento, fk_dosificacion)
VALUES
    ('Juan Pérez', 101, 1, 1),
    ('Tito Toscano', 102, 2, 2),
    ('Pablo Lucio', 103, 3, 3);

-- Insertar registros en la tabla tbl_dosificacion
INSERT INTO tbl_dosificacion (dosificacion, fk_farmaco)
VALUES
    ('Inyección', 1),
    ('Oral', 2),
    ('Oral', 3);

-- Insertar registros en la tabla tbl_farmaco
INSERT INTO tbl_farmaco (nombre, fk_unidades_dia)
VALUES
    ('Morfina', 1),
    ('Paracetamol', 2),
    ('Fluimucil', 1);

-- Insertar registros en la tabla tbl_departamento
INSERT INTO tbl_departamento (cod_departamento, nombre_departamento)
VALUES
    ('NEU-3', 'Neumología'),
    ('CARD-4', 'Cardiología'),
    ('FIS-2', 'Fisiatría');

-- Insertar registros en la tabla tbl_administracion
INSERT INTO tbl_administracion (metodo_administracion)
VALUES
    (1),
    (2),
    (3);

-- Insertar registros en la tabla tbl_unidades_dia
INSERT INTO tbl_unidades_dia (fecha_inicio, fecha_fin, fk_administracion)
VALUES
    ('2023-06-22', '2023-07-04',1),
    ('2023-06-22', '2023-07-04',2),
    ('2023-06-22', '2023-07-04',3);

-- Agregar la restricción de clave primaria a la columna fk_dosificacion en tbl_paciente
ALTER TABLE tbl_paciente
ADD CONSTRAINT fk_pk_dosificacion
FOREIGN KEY (fk_dosificacion)
REFERENCES tbl_dosificacion (pk_dosificacion);

alter table tbl_dosificacion 
add constraint fk_pk_farmaco 
foreign key (fk_farmaco)
references tbl_farmaco (pk_farmaco);

alter table tbl_farmaco  
add constraint fk_pk_farmaco_unidades 
foreign key (fk_unidades_dia)
references tbl_unidades_dia (pk_unidades_dia);

alter table tbl_unidades_dia  
add constraint fk_pk_unidades_administracion 
foreign key (fk_administracion)
references tbl_adminisracion (pk_administracion);

alter table tbl_paciente  
add constraint fk_pk_paciente_departamento 
foreign key (fk_departamento)
references tbl_departamento (pk_departamento);
