CREATE DATABASE tiendaMascotas;
USE tiendaMascotas;

-- Tabla Cliente
CREATE TABLE cliente (
	cedulaCliente INT NOT NULL,
    telefonoCliente VARCHAR(20) UNIQUE,
    nombreCliente VARCHAR(255) NOT NULL,
    apellidoCliente VARCHAR(255),
    direccionCliente VARCHAR(255) NOT NULL,
    PRIMARY KEY(cedulaCliente)
);

-- Tabla Mascota
CREATE TABLE mascota (
	idMascota INT NOT NULL AUTO_INCREMENT,
    tipoMascota VARCHAR(255) NOT NULL,
    nombreMascota VARCHAR(255) NOT NULL,
    razaMascota VARCHAR(255) NOT NULL,
    cedulaCliente INT NOT NULL,
    PRIMARY KEY(idMascota),
    FOREIGN KEY(cedulaCliente) REFERENCES cliente(cedulaCliente)
);

-- Tabla Vacuna
CREATE TABLE vacuna (
	idVacuna INT NOT NULL AUTO_INCREMENT,
    nombreEnf VARCHAR(255) NOT NULL,
    nombreVacuna VARCHAR(255) NOT NULL,
    dosisVacuna VARCHAR(255) NOT NULL,
    PRIMARY KEY(idVacuna)
);

-- Tabla AplicacionVacuna
CREATE TABLE aplicacionVacuna (
	idAplicacion INT NOT NULL AUTO_INCREMENT,
    idMascota INT NOT NULL,
    idVacuna INT NOT NULL,
    PRIMARY KEY(idAplicacion),
    FOREIGN KEY(idMascota) REFERENCES mascota(idMascota),
    FOREIGN KEY(idVacuna) REFERENCES vacuna(idVacuna)
);

-- Tabla Venta
CREATE TABLE venta (
	idVenta INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(idVenta)
);

-- Tabla DetalleVenta
CREATE TABLE detalleVenta (
	idDetalleVenta INT NOT NULL AUTO_INCREMENT,
    fechaVenta DATE NOT NULL,
    cedulaCliente INT NOT NULL,
    idVenta INT NOT NULL,
    PRIMARY KEY(idDetalleVenta),
    FOREIGN KEY(cedulaCliente) REFERENCES cliente(cedulaCliente),
    FOREIGN KEY(idVenta) REFERENCES venta(idVenta)
);

-- Tabla Producto
CREATE TABLE producto (
	codigoBarProd INT NOT NULL,
    precioProd DECIMAL(10,2) NOT NULL,
    nombreProd VARCHAR(255) NOT NULL,
    marcaProd VARCHAR(255),
    PRIMARY KEY(codigoBarProd)
);

-- Tabla DetalleProducto
CREATE TABLE detalleProducto (
	idDetalleProd INT NOT NULL AUTO_INCREMENT,
    idVenta INT NOT NULL,
    codigoBarProd INT NOT NULL,
    PRIMARY KEY(idDetalleProd),
    FOREIGN KEY(idVenta) REFERENCES venta(idVenta),
    FOREIGN KEY(codigoBarProd) REFERENCES producto(codigoBarProd)
);
