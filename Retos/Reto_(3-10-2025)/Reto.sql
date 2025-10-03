
/* -------------------- Modificaciones  -------------------- */
/* No modifica las tablas, modifica los contenidos.
update nombretabla set campo=valor, campo1=valor1 where condicion
*/
# Un campo cambia en varios registros
update mascota set tipoMascota='Canino' where idmascota<5;

#Un registro cambian en varios campos
update mascota set raza='GatoNaranja', tipoMascota='Felino', 
fechaCreacion='2025-09-33 07:53:40' where idmascota=5;

#Update para corregir la tabla
update mascota set fechaCreacion="2025-09-03 07:53:40" where idmascota=1 or idmascota=5;

/* ------------------------- Delete ------------------------- */
/* delete from nombretabla where condicion begin rollback commit
begin rollback y commit son transacciones en base de datos que utilizan los principios
ACID: 
Atomicidad - O se cumplen todas las especificaciones o ninguna.
Consistencia -  La base de datos siempre pasa de un estado a otro
Isolation - Las transacciones concurrentes no interfieren entre sí.
Durabilidad - Una vez algo ha sido confirmado los cambios son permanentes.

begin - Iniciar la transacción
commit - Guardar cambios
rollback - deshacer transacciones no confirmadas

start transaction;
delete from tabla where condicion;
commit;

Si lo que se quiere eliminar tiene una foreign key asociada no puede ser eliminado, a menos que tenga
el comando cascada, que va a guardar los cambios que le realicen en donde quiera que esté siendo usado

show variables like 'autocommit';

show processlist; -> Para ver todos los commits realizados
select * from information_schema.innodb_trx; -> Para ver aún más detalladamente
*/

insert into mascota values 
(' ', 'Lucy', 'Bulldog', 'Hembra', 'Canino', '2025-09-03 07:53:40', '1021674080');
delete from mascota where idMascota=6;

select * from mascota;

/* ------------ Vistas, triggers, procedimientos almacenados ---------------- */
/* 
create view nombreVista as select campos from tabla where condicion;
*/
create view vistaMascota as select m.nombreMascota as 'Nombre Mascota', 
m.raza as 'Raza mascota' from mascota m;
select * from vistaMascota;

# Vista para nombre cliente y nombre mascota
create view vistaClienteMascota as select c.nombreCliente1 as 'Nombre Cliente', 
c.apellidoCliente1 as 'Apellido Cliente', m.nombreMascota as 'Nombre Mascota'
from cliente c
left join mascota m on c.documentoCliente=m.documentoClienteFK;
select * from vistaClienteMascota;
