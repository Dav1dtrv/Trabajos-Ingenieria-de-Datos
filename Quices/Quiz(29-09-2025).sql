create database granempresa2;
use granempresa2;

create table departamento(
idDepartamento int primary key auto_increment,
nombreDepartamento varchar(100) not null
);

create table empleado(
idEmpleado int primary key auto_increment,
nombre varchar(50) not null,
apellido varchar(50) not null,
fechaNacimiento date not null,
fechaContratacion date not null,
salario decimal(10,2) not null,
idDepartamentoFK int not null,
foreign key(idDepartamentoFK) references departamento(idDepartamento)
);

describe empleado;

/* ----------- Registros ----------- */
insert into departamento values
(' ', 'Recursos Humanos'),
(' ', 'Tecnología'),
(' ', 'Marketing'),
(' ', 'Finanzas'),
(' ', 'Ventas'),
(' ', 'Producción');

insert into empleado values
(' ', 'Carlos', 'Ramírez', '1990-05-12', '2015-06-01', 3500.00, 1),
(' ', 'Laura', 'Martínez', '1988-11-20', '2018-03-15', 4200.00, 2),
(' ', 'Andrés', 'Gómez', '1992-02-28', '2019-07-10', 3100.00, 3),
(' ', 'Marta', 'Pérez', '1985-08-10', '2012-01-20', 4800.00, 4),
(' ', 'Julián', 'Lozano', '1995-12-05', '2020-09-25', 2900.00, 5),
(' ', 'Sebastián', 'Mora', '2006-01-26', '2021-07-23', 2900.00, 5);

/* --------------- Retos a Completar --------------- */

# 1. Lista de empleados - Cambió.
select nombre, apellido, timestampdiff(year, fechaNacimiento, curdate()) as edad, salario from empleado;

# 2. Altos ingresos - No cambió.
select * from empleado where salario>4000;

# 3. Fuerza de ventas - Cambió.
select * from empleado where                      #Está bien pero hay una forma más eficiente
idDepartamentoFK in (select idDepartamento from departamento where nombreDepartamento='Ventas');

# 4. Rango de edad - Cambió.
select nombre from empleado where timestampdiff(year, fechaNacimiento, curdate()) between 30 and 40;

# 5. Nuevas contrataciones - No cambió.
select * from empleado where fechaContratacion>'2020-12-31';

# 6. Distribución empleado - Cambió poquito.
select idDepartamentoFK, count(*) as 'Cantidad empleados' from empleado group by idDepartamentoFK;

# 7. Análisis salarial - No cambió.
select avg(salario) as 'Salario promedio' from empleado;

# 8. Nombres selectivos - No cambió.
select * from empleado where nombre like 'A%' or nombre like 'C%';

# 9. Departamentos específicos - Cambió.
select * from empleado where idDepartamentoFK not like '2';

# 10. El mejor pagado - No cambió.
select * from empleado where salario=(select max(salario) from empleado);


/* Consultas multitablas */
select e.nombre as 'Empleado', d.nombreDepartamento as 'Departamento'
from empleado e
left join departamento d on e.idDepartamentoFK=d.idDepartamento;

select e.nombre as 'Empleado', d.nombreDepartamento as 'Departamento'
from empleado e
right join departamento d on e.idDepartamentoFK=d.idDepartamento;


/* ------------------------ Quiz ------------------------ */

#1. Consultar empleados cuyo salario sea mayor al salario promedio
select * from empleado where salario>(select max(salario) from empleado);

#2. Encuentre el nombre del empleado con el segundo salario más alto
select nombre as 'Empleado', salario as 'Salario' from empleado where salario in
(select max(salario) from empleado where salario<(select max(salario) from empleado));

#3. Utilizando left join muestre los departamentos que no tienen empleados asignados
select d.nombreDepartamento as 'Departamento', e.nombre as 'Empleado'
from departamento d
left join empleado e on d.idDepartamento=e.idDepartamentoFK;

#4. Muestre el total de empleados por cada departamento
select d.nombreDepartamento as 'Departamento', count(*) as 'Cantidad empleados'
from departamento d
left join empleado e on d.idDepartamento=e.idDepartamentoFK
group by d.nombreDepartamento;

