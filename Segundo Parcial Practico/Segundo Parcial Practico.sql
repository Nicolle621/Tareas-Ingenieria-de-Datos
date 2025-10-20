/*=====================================================
	Segundo Parcial Practico - Ingenieria de Datos
    Nicolle Stefany Garaviz Sanchez
    Reto Numero: 16
  =====================================================*/
  
/*=====================================================
					CREACION BASE DE DATOS
  =====================================================*/
  
create database BD_TechNova;
use BD_TechNova;

/*=====================================================
						TABLAS
  =====================================================*/

/*---- TABLA DEPARTAMENTO ----*/

CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);

/*---- TABLA EMPLEADO ----*/

CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamento INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

/*---- TABLA PROYECTO ----*/
CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamento INT,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)

);

/*---- TABLA ASIGNACION ----*/
CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
id_proyecto INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);

/*=====================================================
					INSERTAR DATOS
  =====================================================*/

/*---- DEPARTAMENTO ----*/
describe departamento;

insert into departamento
values
(null, 'soporte de redes', 1000000),
(null, 'gestion de proyectos', 1100000),
(null, 'soporte y mantenimiento', 900000);

select * from departamento;

/*---- EMPLEADO ----*/

describe empleado;

insert into empleado
values
(null, 'patricia toro', 'desarrollador', 200000, 3, '2024-12-03'),
(null, 'peito perez', 'lider', 500000, 1, '2018-03-10'),
(null, 'pedro picapiedra', 'lider', 500000, 2, '2018-10-12'),
(null, 'aitor menta', 'desarrollador', 250000, 1, '2022-03-29'),
(null, 'elsa pato','lider', 500000, 3, '2020-01-15');

select * from empleado;

/*---- PROYECTO ---*/

describe proyecto;

insert into proyecto
values
(null, 'pagina web zapatos', '2024-10-11', 800000, 1),
(null, 'gestionar proyecto 3', '2025-05-20', 975000, 2),
(null, 'mantenimiento juego', '2020-02-15', 990000, 3);

select * from proyecto;

/*---- ASIGNACION ----*/

describe asignacion;

insert into asignacion
values
(null, 1, 3, 10),
(null, 2, 1, 12),
(null, 3, 2, 9),
(null, 4, 3, 11),
(null, 5, 2, 10),
(null, 1, 3, 12);

select * from asignacion;

/*=====================================================
   SOLUCION RETO 16: CONTROL DE ASIGNACIONES DUPLICADAS
  =====================================================*/

/*----FUNCION: VERIFICAR ASIGNACION*/

describe empleado;
describe proyecto;

DELIMITER $$

create function verificarAsignacion(
    p_id_empleado INT,
    p_id_proyecto INT)
    
returns boolean
deterministic
begin
    declare existe int;

    select count(*) into existe
    from Asignacion
    where id_empleado = p_id_empleado
      and id_proyecto = p_id_proyecto;

    if existe > 0 then
        return TRUE;
    else
        return FALSE;
    end if;
end $$

DELIMITER ;

select verificarAsignacion( 1, 3);


/*---- TRIGGER: BEFORE INSERT EN ASIGNACION ----*/

describe asignacion; 

DELIMITER $$

create trigger beforeInsertAsignacion
before insert on Asignacion
for each row
begin
    if exists(
    
    select 1
    from Asignacion
    where id_empleado = new.id_empleado
		and id_proyecto = new.id_proyecto) 
        then
			set message_text= concat('Error: El empleado ', new.id_empleado,' ya está asignado al proyecto ', new.id_proyecto);
		
    end if;
end $$

DELIMITER ;



/*---- PROCEDIMIENTO: CORREGIR DUPLICADAS ----*/


DELIMITER $$

create procedure CorregirDuplicadas()
begin
    delete a1
    from Asignacion a1
    join Asignacion a2
        on a1.id_empleado = a2.id_empleado
       and a1.id_proyecto = a2.id_proyecto
       and a1.id_asignacion > a2.id_asignacion;
end $$

DELIMITER ;

insert into Asignacion (id_empleado, id_proyecto, horas_trabajadas)
values (3, 2, 10);

insert into Asignacion (id_empleado, id_proyecto, horas_trabajadas)
values (3, 2, 5);

call corregirduplicadas();







