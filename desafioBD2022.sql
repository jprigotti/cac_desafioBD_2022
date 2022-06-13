-- Traversy Media Cheat Sheet
-- https://gist.github.com/bradtraversy/c831baaad44343cc945e76c2e30927b3

-- Youtube amazing tuturial
-- https://www.youtube.com/watch?v=9ylj9NR0Lcg

-- SQL  Tutorial
-- https://www.w3schools.com/sql/default.asp

-- SQL Joins
-- https://www.edureka.co/blog/sql-joins-types#INNER%20JOIN
-- https://www.raulprietofernandez.net/blog/bases-de-datos/como-funcionan-los-principales-sql-joins

-- mysqldump
-- https://hevodata.com/learn/mysqldump-export-databases-and-tables/#how
-- C:\Users\Dailu>mysqldump -u root -p desafiobd empleados departamentos> c:\Users\Dailu\desafiobd20220612.sql

-- Creamos la base de datos
create database desafiobd;

-- Seleccionamos la base de datos
use desafiobd;

-- Listamos las bases de datos
SHOW DATABASES; 

-- Creamos la tabla empleados
create table empleados(
idEmpleado int(11) NOT NULL auto_increment,
DNI int(11),
nombre varchar(100) NOT NULL,
apellido varchar(100) NOT NULL,
numeroDepartamento int(11) NOT NULL,
PRIMARY KEY (idEmpleado)
);

-- Creamos la tabla departamentos
create table departamentos(
idDepartamento int(11) not null,
nombreDepartamento varchar(100) not null,
presupuesto int(11) not null,
primary key (idDepartamento)
);

-- listamos la tablas
SHOW TABLES;

-- Agregamos la Foreign Key
alter table empleados ADD foreign key (numeroDepartamento) references departamentos(idDepartamento);

-- Insertamos algunos datos, primero hay que asegurarse que el numeroDepartamento exista en la tabla departamentos
insert into departamentos (idDepartamento, nombreDepartamento, presupuesto) values ('31096678','Juan','Lopez','14');
insert into empleados (DNI, nombre, apellido, numeroDepartamento) values ('32698547','Carmen','barbieri','16');

-- Full data insert
-- INSERT INTO `departamentos` VALUES (14,'Informática',80000),(15,'Gestión',95000),(16,'Comunicación',75000),(37,'Desarrollo',65000),(77,'Investigación',40000);
-- INSERT INTO `empleados` VALUES (1,31096678,'Juan','Lopez',14),(2,31096675,'Martin','Zarabia',77),(3,34269854,'Jose','velez',77),(4,41369852,'Paula','Madariaga',77),(5,33698521,'Pedro','Perez',14),(6,32698547,'Mariana','Lopez',15),(7,42369854,'Abril','Sanchez',37),(8,36125896,'Marti','Julia',14),(9,36985471,'Omar','Diaz',15),(10,32145698,'Guadalupe','Perez',77),(11,32369854,'Bernardo','pantera',37),(12,36125965,'Lucia','Pesaro',14),(13,31236985,'Maria','diamante',14),(14,32698547,'Carmen','barbieri',16);


-- Select para probar
select * from departamentos;
select * from empleados;

-- Inner join muestra tal cual la tabla dada
select * from empleados E
inner join departamentos D
on E.numeroDepartamento = D.idDepartamento;


-- 2.1 obtener los apellidos de los empleados
select	apellido from empleados order by apellido asc;


-- 2.2 obtener los apellidos de los empleados sin repeticiones
select distinct apellido from empleados order by apellido asc;


-- 2.3 obtener los datos de los empleados que tengan el apellido Lopez
select * from empleados where apellido = 'Lopez';


-- 2.4 obtener los datos de los empleados que tengan el apellido Lopez y los que tengan apellido Perez
select * from empleados
where apellido IN ('Lopez', 'Perez')
order by apellido asc;

-- where E.apellido = 'Lopez' OR E.apellido = 'Perez'

-- 2.5 Obtener todos los datos de los empleados que trabajen en el departamento 14
select * from empleados
where numeroDepartamento = '14'
order by apellido asc;


-- 2.6 Obtener todos los datos de los empleados que trabajen en el departamento 37 y 77
select * from empleados
where numeroDepartamento IN ('37' , '77')
order by apellido asc;


-- 2.7 Obtener los datos de los empleados cuyo apellido comience con P
select * from empleados
where apellido LIKE 'P%'
order by apellido asc;


-- 2.8 Obtener el presupuesto total de todos los departamentos
select SUM(presupuesto) from departamentos;


-- 2.9 Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento
select * from empleados E
left join departamentos D
on E.numeroDepartamento = D.idDepartamento;


-- 2.10 Obtener un listado completo de empleados, incluyendo el nombre y apellido del empleado junto al nombre y presupuesto de su departamento
select nombre, apellido, nombreDepartamento, presupuesto
from empleados
full join departamentos
ON numeroDepartamento = idDepartamento;


-- 2.11 Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60000
select nombre, apellido, presupuesto
from empleados
inner join departamentos
ON numeroDepartamento = idDepartamento
where presupuesto > '60000';


-- 2.12 Añadir un nuevo departamento: Calidad con un presupuesto de 40000 y código 11,
-- añadir un empleado vinculado al departamento recién creado: Esther Vazquez, DNI 89267109
insert into departamentos (idDepartamento, nombreDepartamento, presupuesto) values ('11', 'Calidad', '40000');
insert into empleados (DNI, nombre, apellido, numeroDepartamento) values ('89267109', 'Esther', 'Vazquez', '11');

select * from empleados where nombre = 'Esther';
select * from departamentos where nombreDepartamento = 'Calidad';


-- 2.13 Aplicar un recorte presupuestario del 10% a todos los departamentos
update departamentos set presupuesto = '36000' where idDepartamento = 11;
update departamentos set presupuesto = '36000' where idDepartamento = 77;
update departamentos set presupuesto = '72000' where idDepartamento = 14;
update departamentos set presupuesto = '85500' where idDepartamento = 15;
update departamentos set presupuesto = '58500' where idDepartamento = 37;
update departamentos set presupuesto = '67500' where idDepartamento = 16;

select * from departamentos;


-- 2.14 Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14)
update empleados set numeroDepartamento = 14 where numeroDepartamento = 77;

select * from empleados 
inner join departamentos
on numeroDepartamento = idDepartamento
where numeroDepartamento = '14';


-- 2.15 Despedir a los empleados del departamento de informática (código 14)
delete from empleados where numeroDepartamento = 14;


-- 2.16 Despedir a los empleados que trabajen en departamentos con un presupuesto superior a 90000
select * from empleados 
inner join departamentos
on numeroDepartamento = idDepartamento
where presupuesto > 90000;

-- Nada para remover.



-- En caso que necesitemos borrar y arrancar de cero
drop database desafiobd;
drop table empleados;
drop table departamentos;