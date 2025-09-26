create database granempresa;
use granempresa;

create table empleado(
idEmpleado int primary key auto_increment,
nombre varchar(50) not null,
apellido varchar(50) not null,
edad int not null,
fechaContratacion date not null,
salario decimal(10,2) not null,
nombreDepartamento varchar(100) not null
);

insert into empleado values
(' ', 'Ana', 'Gómez', 33, '2021-03-10', 4200.00, 'Ventas'),
(' ', 'Carlos', 'Ramírez', 39, '2018-07-01', 3900.00, 'IT'),
(' ', 'Beatriz', 'López', 32, '2022-01-15', 4100.00, 'Marketing'),
(' ', 'David', 'Martínez', 46, '2010-11-20', 5000.00, 'Finanzas'),
(' ', 'Alejandro', 'Fernández', 29, '2023-06-05', 3200.00, 'Ventas'),
(' ', 'Carmen', 'Sánchez', 35, '2019-09-30', 4600.00, 'Recursos Humanos'),
(' ', 'Luis', 'Torres', 34, '2020-02-01', 3800.00, 'IT'),
(' ', 'Claudia', 'Mora', 42, '2015-05-18', 5300.00, 'Dirección'),
(' ', 'Andrés', 'Navarro', 29, '2024-01-10', 2950.00, 'Marketing'),
(' ', 'Carla', 'Ibáñez', 37, '2017-04-22', 4450.00, 'Ventas');

/* --------------- Retos a Completar --------------- */

# 1. Lista de empleados.
select nombre, apellido, edad, salario from empleado;

# 2. Altos ingresos. 
select * from empleado where salario>4000;

# 3. Fuerza de ventas.
select * from empleado where nombreDepartamento='ventas';

# 4. Rango de edad.
select * from empleado where edad between 30 and 40;

# 5. Nuevas contrataciones.
select * from empleado where fechaContratacion>'2020-12-31';

# 6. Distribución empleados.
select nombreDepartamento, count(*) as 'Cantidad empleados' from empleado group by nombreDepartamento;

# 7. Análisis salarial.
select avg(salario) as 'Salario promedio' from empleado;

# 8. Nombres selectivos.
select * from empleado where nombre like 'A%' or nombre like 'C%';

# 9. Departamentos específicos.
select * from empleado where nombreDepartamento not like 'IT';

# 10. El mejor pagado.
select * from empleado where salario=(select max(salario) from empleado);
