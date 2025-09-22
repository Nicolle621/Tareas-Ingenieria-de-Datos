CREATE DATABASE tiendaMascotas;
USE tiendaMascotas;

create table vacuna (
	idVacuna int not null,
    nombreEnf varchar(50) not null,
    nombreVacuna varchar(50) not null,
    dosisVacuna int not null,
    primary key(idVacuna)
);

CREATE TABLE cliente (
	cedulaCliente int not null,
    telefonoCliente int unique,
    nombreCliente varchar(255) not null,
    apellidoCliente varchar(255),
    direccionCliente varchar(255) not null,
    primary key(cedulaCliente)
);

create table mascota (
	idMascota int auto_increment null,
    cedulaCliente int not null,
    tipoMascota varchar(255) not null,
    nombreMascota varchar(255) not null,
    razaMascota varchar(255) not null,
    foreign key(cedulaCliente) references cliente(cedulaCliente),
    primary key(idMascota)
);

create table venta(
	idVenta int not null,
    primary key(idVenta)
);

create table producto(
	codigoBarProd int not null,
    precioProd float not null,
    nombreProd varchar(50) not null,
    marcaProd varchar(25) not null,
    primary key(codigoBarProd)
);

create table detalleVentaCliente(
	idDetalleVC int auto_increment,
    cedulaCliente int not null,
    idVenta int not null,
    fechaVenta datetime not null,
    
    primary key(idDetalleVC),
    foreign key(cedulaCliente) references cliente(cedulaCliente),
    foreign key(idVenta) references venta(idVenta)
);

create table detalleVentaProducto(
	idVenta int not null,
    idProducto int not null,
    idDetalleVP int not null auto_increment,
    
    primary key(idDetalleVP),
    foreign key(idVenta) references venta(idVenta),
    foreign key(idProducto) references producto(codigoBarProd)
);

create table aplicacionVacuna(
	idAplicacion int not null auto_increment,
    idMascota int not null,
    idVacuna int not null,
    
    primary key(idAplicacion),
    foreign key(idMascota) references mascota(idMascota),
    foreign key(idVacuna) references vacuna(idVacuna)
);

alter table cliente add email varchar(100) unique;

alter table cliente change email emailCliente varchar(100) unique;

drop database tiendaMascotas;

#DML

#insert

/*insert into (nombreTabla) (campos) values (valor1, valor2, valor3)*/ #Formma Larga
/*insert into (nombreTabla) values(valor1, valor2, valor3)*/ #Forma Corta

describe cliente;
insert into cliente (cedulaCliente,telefonoCliente,nombreCliente,apellidoCliente,direccionCliente,emailCliente) values (1141317008, 3024836745, "Nicolle ", "Garaviz", "calle 3 # 06-7", "blabla@gmail.com"),
(4534513344, 3042716291, "Pepito ", "Perez", "carrera 5 # 02-23", "pp2@gmail.com"),
(3242141424, 4343415467, "Oswaldo", "Samayoa", "calle 10 # 07-13", "sama@gmail.com"),
(0181619181, 8251916100, "Sara ", "Mendez", "carrera 93 # 03-04", "sarame@gmail.com");
select * from cliente;

describe mascota;
select * from cliente;
insert into mascota values (" ",