drop schema if exists Banco;

create schema Banco;

USE Banco;

drop table if exists provincias; 

create table provincias(
id_provincia smallint auto_increment,
descripcion varchar(20),
primary key (id_provincia)
);

drop table if exists localidades; 

create table localidades(
id_localidad smallint auto_increment,
descripcion varchar(30),
id_provincia smallint,
primary key (id_localidad),
foreign key (id_provincia) references provincias(id_provincia)
);

drop table if exists tipo_de_usuarios; 

create table tipo_de_usuarios( 
id_tipouser tinyint auto_increment,
descripcion varchar(30),
primary key (id_tipouser)
);

drop table if exists clientes; 
 
create table clientes(
id_cliente int auto_increment,
dni char(8) unique not null,
cuil char(11) unique not null,
nombre varchar(30),
apellido varchar(30),
sexo char(1),
nacionalidad varchar(30),
fechanacimiento datetime,
direccion varchar(100),
id_localidad smallint,
correo varchar(50),
telefono varchar(15),
fecha_alta datetime,
estado tinyint(1) not null default 1,
primary key(id_cliente),
foreign key(id_localidad) references localidades(id_localidad)
);

drop table if exists usuarios;

create table usuarios( 
id_usuario int auto_increment,
id_cliente int unique not null,
nombreusuario varchar(20) not null unique,
contrasenia varchar(12) not null, 
id_tipouser tinyint not null,
estado tinyint(1) not null default 1,
primary key (id_usuario),
foreign key (id_tipouser) references tipo_de_usuarios(id_tipouser),
foreign key (id_cliente) references clientes(id_cliente)
);

drop table if exists tipo_de_cuentas; 

create table tipo_de_cuentas(
id_tipocuenta smallint auto_increment,
descripcion varchar(30),
primary key (id_tipocuenta)
);

drop table if exists cuentas;

create table cuentas( 
num_de_cuenta varchar(13),
cbu varchar(23) unique not null,
fecha_creacion datetime,
fecha_baja datetime ,
id_tipocuenta smallint not null,
id_cliente int not null,
saldo decimal(15, 2),
estado tinyint(1),
primary key (num_de_cuenta),
foreign key(id_cliente) references clientes(id_cliente),
foreign key(id_tipocuenta) references tipo_de_cuentas(id_tipocuenta)
);


drop table if exists prestamos;

create table prestamos(
id_prestamo int auto_increment,
num_de_cuenta varchar(14) not null,
fecha datetime,
importe_pedido decimal(15,2) not null,
cuotas smallint not null,
importe_mensual decimal(15,2) not null,
estado tinyint(1) default 0, /*(0) Pendiente - (1) Respondido*/
aprobado tinyint(1) default 0, /*(0) Rechazado - (1) Activo*/
finalizado tinyint(1), /*(1) Finalizado*/
primary key (id_prestamo),
foreign key (num_de_cuenta) references cuentas(num_de_cuenta)
);

drop table if exists cuotas;

create table cuotas(
id_pago_de_cuota int auto_increment,
id_prestamo int not null,
num_cuota smallint not null,
monto decimal(15,2),
estado tinyint(1) default 1, /*1 pendiente*/
fecha_pago datetime,
primary key (id_pago_de_cuota),
foreign key (id_prestamo) references prestamos(id_prestamo)
);

drop table if exists tipo_de_movimiento;

create table tipo_de_movimiento(
id_tipomovimiento smallint auto_increment,
descripcion varchar(30),
primary key (id_tipomovimiento)
);

drop table if exists movimientos;

create table movimientos(
id_movimiento int auto_increment,
fecha datetime,
detalle varchar(50),
importe decimal(15,2),
id_tipomovimiento smallint not null,
num_de_cuenta varchar(14),
primary key (id_movimiento),
foreign key (id_tipomovimiento) references tipo_de_movimiento(id_tipomovimiento),
foreign key (num_de_cuenta) references cuentas(num_de_cuenta)
);

drop table if exists transferencias;

create table transferencias(
id_transferencia int auto_increment,
fecha datetime,
numCuentaDestino varchar(13),
numCuentaOrigen varchar(13),
importe decimal(15,2),
primary key (id_transferencia),
foreign key (numCuentaDestino) references cuentas(num_de_cuenta),
foreign key (numCuentaOrigen) references cuentas(num_de_cuenta)
)

