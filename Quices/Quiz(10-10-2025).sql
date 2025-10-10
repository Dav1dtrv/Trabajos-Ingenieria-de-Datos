## Habilitar BD
use bdmascotas;

/* Incluir en la tabla vacuna el campo para la fecha de vigencia de la vacuna */
alter table Vacuna 
add column fechaVigencia date not null default(curdate());

# 1. Crear una función para saber si la vacuna está vigente o vencida
DELIMITER $$
create function EstadoVacuna(p_fechaVigencia date)
returns varchar(10)
deterministic
begin
	declare estado varchar(10);
    if p_fechaVigencia >= curdate() then
		set estado='Vigente';
	else
		set estado='Vencida';
	end if;
    return estado;
end $$
DELIMITER ;

# 2. Funcion para mostrar el nombre de la mascota, la raza y el nombre del propietario
DELIMITER $$
create function InfoMascota(p_idMascota int)
returns varchar(300)
deterministic
begin 
declare v_nombreMascota varchar(50);
declare v_raza varchar(50);
declare v_nombreCliente varchar(50);
declare v_informacion varchar(300);

select m.nombreMascota, m.raza, CONCAT(c.nombreCliente1, ' ', c.apellidoCliente1)
into v_nombreMascota, v_raza, v_nombreCliente
from Mascota m
inner join Cliente c on m.documentoClienteFK = c.documentoCliente
where m.idMascota = p_idMascota;

select concat('Mascota: ', v_nombreMascota, '; Raza: ', v_raza, '; Propietario: ', v_nombreCliente) 
into v_informacion;

return v_informacion;
end $$
DELIMITER ;

# 3. Crear trigger que impida que se elimine un cliente si tiene una mascota registrada (before delete)
DELIMITER $$
create trigger trigger3
before delete on cliente
for each row
begin 
	declare v_mascotas int;
    
    select count(*) into v_mascotas
    from mascota
    where documentoCliente = old.documentoCliente;
    
    if v_mascotas > 0 then
    select mensaje as 'El cliente tiene mascotas registradas';
    
    end if;
    
end $$
DELIMITER ;

# 4. Crear un trigger que cuando se elimine un cliente lo registré en una tabla llamada clientesEliminados 
# (after delete)
create table clientesEliminados (
    id int auto_increment primary key,
    documentoCliente varchar(20),
    nombreCliente varchar(100),
    fechaEliminacion datetime
);

DELIMITER $$
create trigger trigger4
after delete on cliente
for each row
begin 
	insert into clientesEliminados (documentoCliente, nombreCliente1, nombreCliente2, apellidoCliente1, apellidoCliente2, fechaEliminación)
    values (old.documentoCliente, old.nombreCliente1, old.nombreCliente2, old.apellidoCliente1, old.apellidoCliente2, now());
end $$
DELIMITER ;

# 5. En la tabla cliente agregar un campo llamado fecha de actualización y crear un trigger para que cada vez 
# que se actualice un cliente, se actualice automáticamente ese campo de fecha
alter table Cliente
add column fechaActualizacion datetime default now();

DELIMITER $$
create trigger trigger5
before update on cliente
for each row
begin
	set new.fechaActualizacion = now();
end $$
DELIMITER ;






