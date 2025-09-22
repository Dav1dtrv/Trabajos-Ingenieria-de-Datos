create database BDMascotas;
use bdmascotas;
/* Eliminar Base de Datos */
drop database BDMascotas;

create table Mascota(
idMascota int primary key auto_increment,
nombreMascota varchar(50) not null,
raza varchar(25) not null,
generoMascota varchar(25) not null,
tipoMascota varchar(25) not null,
fechaCreacion timestamp default current_timestamp
);

describe Mascota;

insert into Mascota (idMascota, nombreMascota, raza, 
generoMascota, tipoMascota, fechaCreacion, documentoClienteFK) 
values(" ", "Lucy", "BulldogFrances", "Hembra", "Perro", "2025-09-22 08:57:30", "1021674080");

insert into Mascota values
(" ", "Arom", "BorderCollie", "Macho", "Perro", "2025-09-22 08:57:30", "1021674765"),
(" ", "Tomy", "Pincher", "Macho", "Perro", "2025-09-22 08:57:30", "1023457890"),
(" ", "Canela", "Criollo", "Hembra", "Perro", "2025-09-22 08:57:30", "53015690"),
(" ", "Orion", "Naranja", "Macho", "Gato", "2025-09-22 08:57:30", "80063169");

create table Cliente(
documentoCliente varchar(50) primary key,
nombreCliente1 varchar(50) not null,
nombreCliente2 varchar(50) null,
apellidoCliente1 varchar(50) not null,
apellidoCliente2 varchar(50) not null,
direccionCliente varchar(100) not null
);

insert into Cliente values("1021674080", "Angel", "David", 
"Amaya", "Montoya", "Calle 33B sur");

insert into Cliente values
("1021674765", "Juan", "Sebastian", "Mora", "Cabrera", "Cajica"),
("1023457890", "Andres", "Santiago", "Amaya", "Montoya", "Calle 33B sur"),
("53015690", "Viviana", " ", "Montoya", "Rojas", "Calle 33B sur"),
("80063169", "Miguel", "Angel","Amaya", "Villamarín", "Calle 33B sur");

alter table Mascota add column documentoClienteFK varchar(50) not null;

/* relaciones */
alter table Mascota
add constraint FKClienteMascota
foreign key (documentoClienteFK)
references Cliente(documentoCliente);  

create table telefonoCliente(
idTelefono int primary key auto_increment,
documentoClienteFK int not null,
telefono varchar(20) not null,
foreign key (documentoClienteFK) references Cliente(documentoCliente)
);

select * from CLiente;
select * from Mascota;
