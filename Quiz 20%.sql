create database techCorp;
use techCorp;

create table empleado(
idEmpleado int not null auto_increment,
nomEmpleado varchar(50) not null,
edadEmpleado int not null,
salEmpleado int not null,
depTrabajo varchar(50) not null,
fechaContrat date not null,

primary key (idEmpleado)
);

create table departamento(
idDepartamento int auto_increment not null,
nomDepartamento varchar(50) not null,

primary key (idDepartamento)
);


alter table empleado add idDepartamentoFK int, add constraint foreign key(idDepartamentoFK) references departamento(idDepartamento);
alter table empleado drop column edadEmpleado;
alter table empleado drop column depTrabajo;
alter table empleado add column fechaNacimiento date;

describe empleado;

insert into empleado 
values
(" ", "Oswaldo Samayoa", 22, 4500, "ventas", "2025-02-08"),
(" ", "Nicolle Garaviz", 18, 3000, "information technology ", "2020-06-17"),
(" ", "Mario Delgado", 20, 1000, "ventas", "2021-03-28"),
(" ", "Joan Schick", 33, 5000, "gerencia", "2023-05-17"),
(" ", "Pepito Perez", 65, 4000, "information technology ", "2018-10-11"),
(" ", "Camila Perez", 31, 4400, "information technology ", "2018-10-11"),
(" ", "Juana Cerda", 38, 2500, "ventas", "2019-02-28");


describe departamento;

insert into departamento
values
(" ", "ventas"),
(" ", "gerencia"),
(" ", "information technology");

truncate table empleado;

describe empleado;

insert into empleado 
values
(" ", "Oswaldo Samayoa", 4500, "2025-02-08", 1, "2003-03-29"),
(" ", "Nicolle Garaviz", 3000, "2020-06-17", 3, "2007-06-21"),
(" ", "Mario Delgado", 1000, "2021-03-28", 1, "2005-07-13"),
(" ", "Joan Schick", 5000, "2023-05-17", 2, "1992-03-15"),
(" ", "Pepito Perez", 4000,"2018-10-11", 3, "1960-01-28"),
(" ", "Camila Perez", 4400, "2018-10-11", 3, "1994-11-24"),
(" ", "Juana Cerda", 2500, "2019-02-28", 1, "1987-12-24");

select * from departamento;
select * from empleado;


#RETOS A RESOLVER 

#1
select nomEmpleado, edadEmpleado, salEmpleado from empleado;

#2
select nomEmpleado as 'Empleados que ganan mas de 4000', salEmpleado as 'Salario'
from empleado
group by nomEmpleado, salEmpleado
having avg(salEmpleado) > 4000;

#3
select nomEmpleado, depTrabajo
from empleado
group by nomEmpleado, depTrabajo
having depTrabajo = 'ventas';

#4
select nomEmpleado, edadEmpleado
from empleado
group by nomEmpleado, edadEmpleado
having  edadEmpleado > 30 and edadEmpleado < 40;

#5
select nomEmpleado, fechaContrat
from empleado
group by nomEmpleado, fechaContrat
having year(fechaContrat) > '2020';

#6
select depTrabajo as "Departamento Empleado", COUNT(*) as "Conteo por departamento"
from empleado
group by depTrabajo
having COUNT(*) >= 0;

#7
select avg(salEmpleado) as "Promedio de salarios"
from empleado
having avg(salEmpleado) >= 0;

#8
select nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
from empleado
group by nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
having nomEmpleado like 'A%' or nomEmpleado like 'C%';

#9
select nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
from empleado
group by nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
having depTrabajo <> 'information technology';

#10
select nomEmpleado as "Nombre Empleado", max(salEmpleado) as "Salario"  from empleado;
select nomEmpleado, salEmpleado from empleado;

#RETO ACTUALIZADO (CON 2 TABLAS Y CAMBIO DE LA EDAD)

/*subconsulta y consultas multitabla 
escalares: devuelven un solo valor
de fila: devuelven un registro(fila) completa
de tabla: devyelven varios registros(varias filas)*/
#1 Obtén los nombres, edades y salarios de todos los empleados de TechCorp


#2 ¿Quiénes son los empleados que ganan más de $4,000?
select nomEmpleado as 'Empleados que ganan mas de 4000', salEmpleado as 'Salario'
from empleado
group by nomEmpleado, salEmpleado
having avg(salEmpleado) > 4000;

#3 : Extrae la lista de empleados que trabajan en el departamento de Ventas

select nomEmpleado, idDepartamentoFK 
from empleado
where idDepartamentoFK = 1;

select nomEmpleado as "Nombre", idDepartamentoFK as "ID Departamento" 
from empleado 
where idDepartamentoFK = (select idDepartamento from departamento where nomDepartamento = "ventas");

select e.nomEmpleado as "Empleado", d.nomDepartamento as "Departamento"
from empleado e 
inner join departamento d on e.idDepartamentoFK = d.idDepartamento
where d.nomDepartamento = "ventas";

#4 Encuentra a los empleados que tienen entre 30 y 40 años.

#5 ¿Quiénes han sido contratados después del año 2020?
select nomEmpleado, fechaContrat
from empleado
group by nomEmpleado, fechaContrat
having year(fechaContrat) > '2020';

#6 ¿Cuántos empleados hay en cada departamento?
select idDepartamentoFK as "Departamento Empleado", COUNT(*) as "Conteo por departamento"
from empleado
group by idDepartamentoFK
having COUNT(*) >= 0;

#7 ¿Cuál es el salario promedio en la empresa?
select avg(salEmpleado) as "Promedio de salarios"
from empleado
having avg(salEmpleado) >= 0;

#8 Muestra los empleados cuyos nombres comienzan con "A" o "C"
select nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
from empleado
group by nomEmpleado, salEmpleado, depTrabajo, edadEmpleado, fechaContrat
having nomEmpleado like 'A%' or nomEmpleado like 'C%';

#9 Encuentra a los empleados que no pertenecen al departamento de IT
select e.nomEmpleado as "Empleado", d.nomDepartamento as "Departamento"
from empleado e 
inner join departamento d on e.idDepartamentoFK = d.idDepartamento
where d.nomDepartamento <> "information technology";

#10
select nomEmpleado, salEmpleado
from empleado
where salEmpleado =(select max(salEmpleado) from empleado);

#11 Consultar empleados cuyo salarrio sea mayor al promedio
select nomEmpleado as "Empleado", salEmpleado as "Salario"
from empleado
where salEmpleado > (select avg(salEmpleado) from empleado);

#12 Encuentre el nombre del empleado con el segundo salario mas alto
select nomEmpleado, salEmpleado
from empleado
where salEmpleado = (select max(salEmpleado) from empleado 
where salEmpleado < (select max(salEmpleado) from empleado));

 

select d.nomDepartamento as "Departamento", e.nomEmpleado as "Empleado"
from departamento d
left join empleado e on d.idDepartamento = e.idDepartamentoFK
where e.nomEmpleado is null;


#14 Muestre el total de empleados por cada departamento
select d.nomDepartamento as "Departamento", count(*) as "Número de empleados"
from empleado e 
inner join departamento d on e.idDepartamentoFK = d.idDepartamento
group by d.nomDepartamento
having count(*) > 0;


/* consultas multitabla

inner join
left join
righ join 
full outer join union join*/

