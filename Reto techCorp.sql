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


describe empleado;

insert into empleado 
values
(" ", "Oswaldo Samayoa", 22, 4500, "ventas", "2025-02-08"),
(" ", "Nicolle Garaviz", 18, 3000, "information technology ", "2020-06-17"),
(" ", "Mario Delgado", 20, 1000, "ventas", "2021-03-28"),
(" ", "Joan Schick", 33, 5000, "gerencia", "2023-05-17"),
(" ", "Pepito Perez", 65, 4000, "information technology ", "2018-10-11"),
(" ", "Juana Cerda", 38, 2500, "ventas", "2019-02-28");

select * from empleado;

#RETOS A RESOLVER 

select nomEmpleado, edadEmpleado, salEmpleado from empleado;

select nomEmpleado as 'Empleados que ganan mas de 4000', salEmpleado as 'Salario'
from empleado
group by nomEmpleado, salEmpleado
having avg(salEmpleado) > 4000;

select nomEmpleado, depTrabajo
from empleado
group by nomEmpleado, depTrabajo
having depTrabajo = 'ventas';

select nomEmpleado, edadEmpleado
from empleado
group by nomEmpleado, edadEmpleado
having  edadEmpleado > 30 and edadEmpleado < 40;

select nomEmpleado, fechaContrat
from empleado
group by nomEmpleado, fechaContrat
having year(fechaContrat) > '2020';





