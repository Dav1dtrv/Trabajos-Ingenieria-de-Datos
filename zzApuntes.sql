/* DDL funciones, 
create-
alter - modificar la estructura - crear las relaciones
drop-
truncate - elimina los datos pero mantienen la estructura - vacía tablas
rename - cambiar de nombre */
/* Crear Base de Datos */
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

create table Cliente(
documentoCliente varchar(50) primary key,
nombreCliente1 varchar(50) not null,
nombreCliente2 varchar(50) null,
apellidoCliente1 varchar(50) not null,
apellidoCliente2 varchar(50) not null,
direccionCliente varchar(100) not null
);

create table telefonoCliente(
idTelefono int primary key auto_increment,
documentoClienteFK varchar(50) not null,
telefono varchar(20) not null,
foreign key (documentoClienteFK) references Cliente(documentoCliente)
);

create table Vacuna(
idVacuna int auto_increment primary key,
nombreVacuna varchar(100) not null,
dosis int not null,
enfermedad varchar(100) not null
);

create table detalleVacuna(
idDetalleVacuna int auto_increment primary key,
idMascotaFK int not null,
idVacunaFK int not null,
foreign key (idMascotaFK) references Mascota(idMascota),
foreign key (idVacunaFK) references Vacuna(idVacuna)
);

create table Producto(
idProducto int auto_increment primary key,
nombreProducto varchar(50) not null,
marca varchar(50) not null,
precio decimal(10,2) not null,
documentoClienteFK int not null,
foreign key (documentoClienteFK) references Cliente(documentoCliente)
);

insert into Producto values
(' ', 'Chocorramo', 'Ramo', 4000, 1021674080),
(' ', 'CocaCola', 'CocaCola', 3500, 1021674080)
;

#Se usa para cambiar la estructura de un campo
alter table Mascota add column documentoClienteFK varchar(50) not null; 

/* relaciones */
alter table Mascota
add constraint FKClienteMascota
foreign key (documentoClienteFK)
references Cliente(documentoCliente);  

describe Cliente; #Nos muestra los campos de una tabla y sus restriccioes

/* Registros realizados */
insert into Mascota (idMascota, nombreMascota, raza, 
generoMascota, tipoMascota, fechaCreacion, documentoClienteFK) 
values(" ", "Lucy", "BulldogFrances", "Hembra", "Perro", "2025-09-22 08:57:30", "1021674080");

insert into Mascota values
(" ", "Arom", "BorderCollie", "Macho", "Perro", "2025-09-22 08:57:30", "1021674765"),
(" ", "Tomy", "Pincher", "Macho", "Perro", "2025-09-22 08:57:30", "1023457890"),
(" ", "Canela", "Criollo", "Hembra", "Perro", "2025-09-22 08:57:30", "53015690"),
(" ", "Orion", "Naranja", "Macho", "Gato", "2025-09-22 08:57:30", "80063169");

insert into Cliente values("1021674080", "Angel", "David", 
"Amaya", "Montoya", "Calle 33B sur");

insert into Cliente values
("1021674765", "Juan", "Sebastian", "Mora", "Cabrera", "Cajica"),
("1023457890", "Andres", "Santiago", "Amaya", "Montoya", "Calle 33B sur"),
("53015690", "Viviana", " ", "Montoya", "Rojas", "Calle 33B sur"),
("80063169", "Miguel", "Angel","Amaya", "Villamarín", "Calle 33B sur");

insert into Vacuna values
(' ', "Nobivac", 1, "Rabia"),
(' ', "FeLV", 1, "Leucemia Felina"),
(' ', "Nobivac", 2, "Rabia");

select * from Vacuna;

insert into detalleVacuna values
(' ', 1, 1),
(' ', 1, 3),
(' ', 2, 1),
(' ', 2, 3),
(' ', 3, 1),
(' ', 5, 2);


/* ---------------- Consultas Básicas ---------------- */
select * from Mascota; #Nos muestra todos (*) los datos almacenados en la tabla
select nombreMascota from Mascota; #Nos muestra solo el campo que elegimos


/* ---------------- Consultas específicas (Ordenar, agrupar, condicionar y parámetros) ---------------- */

#Se utiliza 'as' para utilizar un alias, no cambia nada en la tabla, solo lo muestra de esa manera
select idMascota as 'Código Estudiante', nombreMascota as 'Nombre Mascota' from Mascota;
select dosis as 'Número de dósis', enfermedad as 'Enfermedad tratada' from Vacuna;

#Se utliza where para condicionar la selección de datos, se puede usar '=' y '!=' (!= es lo mismo que <>)
select * from Mascota where tipoMascota="Perro";
select * from Cliente where direccionCliente="Calle 33B sur";
select * from Mascota where tipoMascota!="Perro";
select * from Cliente where direccionCliente<>"Calle 33B sur";

#Se puede utilizar where y '<' '<=' '>' '>=' para campos numéricos
select * from Mascota where idMascota>2;

/*La sentencia between permite hacer consultas entre rangos (campos numéricos), 
siempre debe estar acompañado de 'and' */
select * from Mascota where idMascota between 2 and 4;

/*La sentencia like permite buscar un patrón de texto determinado por los siguientes comodines:

('%' -> Representa 0, 1 o muchos caracteres; '_'-> Representa solo un caracter 
empiecen por cierto caracter -> like xxxx% -> like arm%
terminen por cierto caracter -> like %xxxx -> like %cion
contengan ciertos caracteres -> like %xxx% -> like %ana%
un solo caracter -> like _xxx

Se puede usar not like para buscar los que no contengan.
*/
select * from Cliente where nombreCliente1 like 'A%'; #Nombre1 empieza por 'A'
select * from Cliente where apellidoCliente1 like '%aya'; #Apellido uno termina por 'aya'
select * from Cliente where nombreCliente1 like '%i%'; #Nombre1 contiene la 'i'

#Sentencia 'in' -> valor in (valor1, valor2, valor3, ...)
select * from detalleVacuna where idVacunaFK in (1, 3);

#Operaciones booleanas (and, or, not)
select * from Mascota where idMascota<3 or tipoMascota like '%a%'; 
select * from Mascota where not idMascota=1 and not idMascota=5;

#La sentencia 'order by' permite ordenar los registros de manera asc o desc (funciona con números y texto)
select * from Cliente order by nombreCliente1 asc;
select * from Cliente order by nombreCliente1 desc;

/*La sentencia 'group by' permite agrupar, está normalmente acompañado por funciones calculadas 
o funciones de agregación.

Estructura -> select 'columna', 'funcionagregacion()' from 'tabla' group by 'campo'
*/
select * from Mascota group by generoMascota;

/*
 ---------------- FUNCIONES AGREGADAS (DE AGREGACIÓN) ---------------- 
count() -> contar registros (filas)
sum() -> Sumar valores numéricos
avg() -> Calcular promedios
max() -> obtiene el valor máximo
min() -> obtiene el valor mínimo

Siempre devuelven un único valor que normalmente es agrupado.
*/

# select count('campocontar') as 'alias' from 'tabla';
select count(*) as 'Número de mascotas' from mascota;

select max(nombreMascota) as 'Última mascota alfabéticamente' from mascota;

select sum(precio) as 'Total valor productos' from producto;

select avg(precio) as 'Promedio de precios productos' from producto;

# select campo1, funcion_agg(campo) as 'alias' from 'tabla' group by 'campoagrupar' having 'condicion';

select tipoMascota, count(*) as 'Cantidad mascotas' from mascota group by tipoMascota having count(*)>=1;


/* ---------------- Consultas avanzadas (multitables, subconsultas) ---------------- */

/* Subconsultas:
Son funciones (no necesariamente consultas) con una estructura de tipo:
select ... (insert ...)
select ... (select ...)
select ... (update ...)
select ... (delete ...)

Primero se ejecuta la subconsulta y luego la consulta principal (de adentro hacia afuera)

Existen 3 tipos de subconsultas:
1. Escalares - Devuelven un solo valor
2. De fila - Devuelven un registro completo (fila completa)
3. De tabla - Devuelven varios registros (varias filas)

*/

/* Consultas multitabla: 

Existen 5 tipos de joins:
1. Inner join - Intersección
2. Left join - 'Conjunto' izquierdo
3. Right join - 'Conjunto' derecho
4. Full outer join - Unión (no existe en mysql)

Ejemplos:

select e.nombre as 'Empleado', d.nombreDepartamento as 'Departamento'
from empleado e 
inner join departamento d on e.idDepartamentoFK=d.idDepartamento;


*/
