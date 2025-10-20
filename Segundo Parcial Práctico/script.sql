
/* ---------------- SEGUNDO PARCIAL PRÁCTICO ---------------- */
create database Technova;
use Technova;

/* ------------ TABLAS E INSERCIONES ------------ */
CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);
insert into Departamento values
(' ', 'Ventas', 10000000),
(' ', 'Finanzas', 10000000),
(' ', 'Producción', 10000000);
select * from departamento;

CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamento INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
insert into empleado values 
(' ', 'Angel Amaya', 'Gerente', '6000000', '3', '2015-04-04'),
(' ', 'Serj Tankian', 'Empleado', '2000000', '3', '2020-03-02'),
(' ', 'Daron Malakian', 'Empleado', '2000000', '3', '2021-07-25'),
(' ', 'Sebastián Mora', 'Gerente', '6000000', '1', '2016-01-26'),
(' ', 'Mariana Cantor', 'Gerente', '6000000', '2', '2015-11-25');
select * from empleado;

CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamento INT,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
insert into proyecto values
(' ', 'Proyecto X', 2023-06-02, 10000000, 3),
(' ', 'Proyecto Y', 2024-03-14, 10000000, 2),
(' ', 'Proyecto Z', 2023-10-21, 10000000, 1);
select * from proyecto;

CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
id_proyecto INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);
insert into asignacion values
(' ', 1, 1, 50),
(' ', 2, 1, 100),
(' ', 3, 1, 100),
(' ', 4, 2, 150),
(' ', 5, 3, 150);
select * from asignacion;

/* ------------ RETO 3 - BONIFICACIÓN POR HORAS EXTRAS ----------- */

# Función
DELIMITER $$
create function HorasEmpleado(id_empleado_p int)
returns int
begin
	declare horasTotales int;
    
    select sum(horas_trabajadas) into horasTotales from asignacion where id_empleado_p = id_empleado;
    
    return horasTotales;
end $$
DELIMITER ;
select nombre as 'Nombre', HorasEmpleado(id_empleado) as 'Horas trabajadas' from empleado;

# Procedimiento
DELIMITER $$
create procedure AplicarBonificacion()
begin
	update empleado set salario=(salario*1.08) where HorasEmpleado(id_empleado)>120;
end $$
DELIMITER ;

call AplicarBonificacion;


# Trigger

# Tabla en donde se registrara el historial
create table HistorialBonificaciones (
id_registro INT AUTO_INCREMENT PRIMARY KEY,
h_nombre VARCHAR(100),
h_cargo VARCHAR(50),
h_salario1 DECIMAL(10,2),
h_salario2 DECIMAL(10,2)
);

DELIMITER $$
create trigger registrarHistorial
after update
on empleado
for each row 
begin 
	insert into HistorialBonificaciones(h_nombre, h_cargo, h_salario1, h_salario2) values
    (new.nombre, new.cargo, old.salario, new.salario);
end $$
DELIMITER ;

select * from HistorialBonificaciones;


# Transacción - Debe ser añadida en el procedimiento
DELIMITER $$
create procedure AplicarBonificacion2()
begin
	declare v_salario decimal(10,2);
    declare mensaje varchar(50);

    start transaction;
    
	update empleado set salario=(salario*1.08) where HorasEmpleado(id_empleado)>120;
	
    if (select max(salario)*0.08 from empleado where HorasEmpleado(id_empleado)>120) < 500000.00 then
		select mensaje as 'Sí es menor';
        commit;
	else 
		rollback;
	end if;
end $$
DELIMITER ;
call AplicarBonificacion2();

select max(salario)*0.08 from empleado where HorasEmpleado(id_empleado)>120;

