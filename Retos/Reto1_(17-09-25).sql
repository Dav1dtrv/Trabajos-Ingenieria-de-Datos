create database ventasTienda;
use ventasTienda;

create table cliente(
idCliente int auto_increment primary key,
documentoCliente varchar(50) not null,
nombreCliente varchar(50) not null,
email varchar(50) unique,
telefono varchar(50),
fechaRegistro date default (current_date)
);

describe cliente;

alter table cliente add direccionCliente varchar(200);
alter table cliente modify telefono varchar(15) not null;
alter table cliente drop direccionCliente;
alter table cliente change email emailCliente varchar(50) unique;create database ventasTienda;
use ventasTienda;

create table cliente(
idCliente int auto_increment primary key,
documentoCliente varchar(50) not null,
nombreCliente varchar(50) not null,
email varchar(50) unique,
telefono varchar(50),
fechaRegistro timestamp default current_timestamp
);

describe cliente;

alter table cliente add direccionCliente varchar(200);
alter table cliente modify telefono varchar(15) not null;
alter table cliente drop direccionCliente;
alter table cliente change email emailCliente varchar(50) unique;

create table pedido(
idPedido int auto_increment primary key,
idClienteFK int,
fechaPedido date,
totalPedido decimal (10,2),
foreign key (idClienteFK) references cliente(idCliente)
);

create table usuario(
idUsuario int auto_increment primary key,
nombreUsuario varchar(50) unique,
emailUsuario varchar(50) unique,
passwordUsuario varchar(50)
);

alter table cliente add column idUsuarioFK int not null;

alter table cliente
add constraint FKUsuarioCliente
foreign key (idUsuarioFK)
references usuario(idUsuario); 

create table producto(
idProducto int auto_increment primary key,
nombreProducto varchar(50) not null,
marcaProducto varchar(50) not null,
precioProducto decimal (10,2) not null
);

create table detallePedido(
idDetallePedido int auto_increment primary key
);

alter table detallePedido add column idProductoFK int not null;
alter table detallePedido
add constraint FKProductoDetallePedido
foreign key (idProductoFK)
references producto(idProducto);

alter table detallePedido add column idPedidoFK int not null;

alter table detallePedido
add constraint FKPedidoDetallePedido
foreign key (idPedidoFK)
references pedido(idPedido)
