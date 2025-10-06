create database sistemaPrestamo;
use sistemaPrestamo;

create table usuario(
idUsuario int auto_increment primary key,
nombre varchar(100) not null,
documento varchar(50) unique not null,
email varchar(100) not null,
telefono varchar(20) 
);

create table equipo(
idEquipo int auto_increment primary key,
tipoEquipo varchar(100) not null,
marca varchar(50) not null,
modelo varchar(50),
estado enum('disponible', 'prestado', 'dañado') default 'disponible'
);

create table prestamo(
idPrestamo int auto_increment primary key,
idEquipoFK int not null,
idUsuarioFK int not null,
fechaPrestamo date not null,
fechaDevolucion date,
estadoPrestamo enum('activo', 'devuelto', 'vencido') default'activo',
foreign key (idEquipoFK) references equipo(idEquipo),
foreign key (idUsuarioFK) references usuario(idUsuario)
);

-- Insertar usuarios
insert into usuario (nombre, documento, email, telefono) values
('Carlos Pérez', '12345678', 'carlos@example.com', '3001234567'),
('Ana Gómez', '87654321', 'ana@example.com', '3017654321'),
('Luis Torres', '11223344', 'luis@example.com', '3029876543'),
('María Rodríguez', '44332211', 'maria@example.com', '3105556677'),
('Pedro López', '99887766', 'pedro@example.com', '3112233445');

-- Insertar equipos
insert into equipo (tipoEquipo, marca, modelo, estado) values
('Cámara', 'Canon', 'EOS 2000D', 'disponible'),
('Laptop', 'Dell', 'Inspiron 15', 'disponible'),
('Micrófono', 'Shure', 'SM58', 'disponible'),
('Proyector', 'Epson', 'X500', 'disponible'),
('Tablet', 'Samsung', 'Galaxy Tab A', 'disponible');

-- Insertar préstamos
insert into prestamo (idEquipoFK, idUsuarioFK, fechaPrestamo, fechaDevolucion, estadoPrestamo) values
(1, 1, '2025-10-01', '2025-10-05', 'devuelto'),
(2, 2, '2025-10-02', null, 'activo'),
(3, 3, '2025-10-03', null, 'activo'),
(4, 4, '2025-09-28', '2025-10-02', 'devuelto'),
(5, 5, '2025-10-04', null, 'activo');

select * from equipo;
select nombre from usario;
select * from prestamo where estadoPrestamo = 'activo';

#Alias para mostrar de forma más clara
select idEquipo as 'Código', tipoEquipo as 'Tipo de Equipo', estado as 'Disponibilidad'
from equipo;
#Usuarios cuyo nombre empieza por 'A'
select * from usuario where nombre like 'A%';
#Equipos que NO están disponibles
select * from equipo where estado != 'disponible';

#Ordenar usuarios alfabéticamente
select * from usuario order by nombre asc;
#Préstamos hechos en un rango de fechas
select * from prestamo where fechaPrestamo between '2025-10-01' and '2025-10-04';

#Cantidad total de equipos
select count(*) as 'Número de equipos' from equipo;
#Cantidad de préstamos activos
select count(*) as 'Préstamos Activos' from prestamo where estadoPrestamo = 'activo';
#Usuarios que más han hecho préstamos (group by + having)
select idUsuarioFK, count(*) as 'Cantidad de préstamos'
from prestamo
group by idUsuarioFK
having count(*) >= 1;

#Ver todos los préstamos con el nombre del usuario y tipo de equipo
select p.idPrestamo, u.nombre as Usuario, e.tipoEquipo as Equipo, 
p.fechaPrestamo, p.fechaDevolucion, p.estadoPrestamo
from prestamo p
inner join usuario u on p.idUsuarioFK = u.idUsuario
inner join equipo e on p.idEquipoFK = e.idEquipo;
#Usuarios que tienen préstamos activos
select distinct u.nombre as 'Nombre'
from usuario u
inner join prestamo p on u.idUsuario = p.idUsuarioFK
where p.estadoPrestamo = 'activo';

#Buscar el usuario con más préstamos
select nombre
from usuario
where idUsuario = (
select idUsuarioFK
from prestamo
group by idUsuarioFK
order by count(*) desc
limit 1
);
#Equipos que están prestados actualmente
select *
from equipo
where idEquipo in (
select idEquipoFK
from prestamo
where estadoPrestamo = 'activo'
);
