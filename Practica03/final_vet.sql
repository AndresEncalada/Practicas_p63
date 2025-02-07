La cantidad de condiciones de enlace siempre sera la cantidad de tablas menos 1. 
Ademas, las condiciones de enlace siempre deben  unirse con un AND;

select country_name city, street_address, department_name
from countries c, locations l, departments d
where c.country_id=l.country_id
and l.location_id=d.location_id;

select country_name, city, street_address, department_name 
from countries c 
inner join locations l on c.country_id=l.country_id 
inner join departments d on l.location_id=d.location_id;

INNER JOIN COMPLEJO
Recibe este nombre pq ademas de las condiciones de union se coloca condiciones de filtrado

Ejemplo: obtener la ciudad, el nombre del departamento y el nombre del pais de
aquellos departamentos que se encuentran en Estados Unidos o Reino Unido

Preguntas:
1. ¿De que tablas debo obtener la informacion solicitada?
    Countries - Locations - Departments 
2 ¿Que columnas voy a incluir en mi consulta?
    city(locations) - country_name (countries) - department_name (departments)
3.¿Cuantas y cuales son las condiciones de union?
    2
    country_id=locations.country_id
    location_id=departments.location_id
4.¿Como se que el pais de los registros a obtener es Estados Unidos o Reino Unido?
    Con una condicion de country_name que verifique el valor de United S.. o United K...;
    
    select city, department_name, country_name
    from countries c, departments d, locations l
    where c.country_id=l.country_id
    and l.location_id=d.location_id
    and (lower(country_name) like 'united states of america' or lower(country_name) like 'united kingdom');

-----------------OUTER JOIN (+)------------------------------------------

Devuelve filas o tuplas que son comunes a dos tablas y tambien las filas o tuplas que estan en ambas tablas o en una de ellas.

Ejemplo 1:
Presentar el nombre y apellido de los empleados en una columna llamada empleados, el nombre y el apellido del jefe de cada empleado
en una columna llamada jefes. Ordenar la informacion de manera alfabetica descendente de acuerdo al nombre del jefe. En caso de que el
empleado no tenga jefe se debe colocar la descripcion "sin jefe" en la columna llamada jefes.

1. ¿De que tablas debo obtener la informacion solicitada?
    En el modelo existe una relacion ciclica en la tabla employees,
    se debe realizar un outer join de esta tabla consigo misma.
2 ¿Que columnas voy a incluir en mi consulta?
    first_name - last_name as Empleados
    first name - last_name as Jefes
3.¿Cuantas y cuales son las condiciones de union?
    1
    employees.employee_id=employees.manager_id;

Este select se puede considerar un self join

Select empleados.first_name||' '|| empleados.last_name Empleados,
jefes.first_name ||' '|| jefes.last_name Jefes
from employees jefes, employees empleados
where jefes.employee_id=empleados.manager_id
order by 2 DESC;

Este select se puede considerar un outer join por la izquierda

Select empleados.first_name||' '|| empleados.last_name Empleados,
jefes.first_name ||' '|| jefes.last_name Jefes
from employees jefes, employees empleados
where jefes.employee_id(+)=empleados.manager_id;

Ejemplo 2: Outer join por la derecha
Presentar el nombre del pais y las ciudades de todos los paises que estan registradas en la base de datos. En caso de que un pais no tenga una ciudad asociada,
se debe presetnar el campo de la cudad con el valor 'Sin ciudades'

select country_name, nvl(city,'Sin ciudades') city
from countries c, locations l
where c.country_id=l.country_id(+)
order by 1;

Ejemplo 3: Presentar el nombre del pais y la cantidad de ciudades que estan registradas en la base de datos para cada pais. En caso de que el pais no tenga 
ciudades registradas, colocar 0 

select country_name, count(l.country_id) cantiidad_ciudades
from countries c, locations l
where c.country_id=l.country_id(+)
group by country_name
order by 1
;


---- Con la sintaxis ANSI se especifica tres tipos de outer joins
*left outer join
-- Es un enlace entre dos tablas que retornan filas basadas en la condicion de union,
-- asi como tambien aquellas filas de las tablas que estan a la izquierda de la clausula de enlace
EJEMPLO:
Presentar el nombre del departamento, el codigo del gerente, el codigo del empleado, el nombre y 
apellido de aquellos empleados que son gerentes de cada departamento en una sola columna llamada Gerentes.
En caso de que el departamento no tenga gerente, se debe colocar el texto 'Sin gerente' en la ultima columna
Ordenar la informacion por nombre de gerente

Select d.department_name, d.manager_id, e.employee_id, nvl2(d.manager_id,e.first_name ||' '||e.last_name,'Sin gerente') Gerentes
from departments d left outer join employees e
on e.employee_id=d.manager_id
order by 4;


EJEMPLO 2: 
Presentar el codigo de la ubicacion y el nombre de la ciudad de aquellas ubicaciones que no tienen departamento.

select l.location_id, city
from locations l left outer join  departments d
on l.location_id=d.location_id
where d.location_id is null
order by 2;

Un right outer join es un enlace entre dos tablas que retornan filas basadas en la condicion de enlace, asi como tambien aquellas filas de la tabla que estan
a la derecha de la clausula de enlace.

EMJEMPLO 3:
Presentar el nombre del departamento, el codigo del gerente, el codigo del empleado, el nombre y apellido de aquellos empleados que son gerentes 
de cada departamento en una sola columna llamada Gerentes.
En caso de que el empleado no sea gerente de un departamento, se debe colocar el texto 'No es gerente' en la primera columna,

select department_name, d.manager_id, employee_id,nvl2(d.manager_id, first_name||' '||last_name,'No es gerente') Gerentes
from departments d right outer join employees e
on d.manager_id=e.employee_id
order by 1;


EJEMPLO 4: 
Presentar el codigo de la ubicacion y el nombre de la ciudad de aquellas ubicaciones que no tienen departamento.

select l.location_id, city
from departments d right outer join locations l
on l.location_id=d.location_id
where d.location_id is null
order by 2;

------ FULL OUTER JOIN
Es un enlace entre dos tablas que retorna filas basadas en la condicion de union, asi como tambien las filas 
que estan a la izquierda y a la derecha de la clausula de enlace

Ejemplo 1:
Presentar el nombre del departamento, el codigo del gerente, el codigo del empleado, el nombre y apellido de aquellos empleados 
que son gerentes de cada departamento en una sola columna llamada gerentes.
Mantener los registros de los departamentos aunque no tengan un  gerente asociado y mantener los registros de los empleados 
aunque no sean gerentes de un deparmatamento.

Select department_name, d.manager_id, employee_id, first_name||' '||last_name Gerentes
from departments d full outer join employees e
on d.manager_id=e.employee_id
order by 1;

Ejemplo 2: 
Presentar el nombre del departamento y el nombre de la ciudad. Si hay departamentos sin ciudades asociadas en la columna ciudad se deberá presentar el campo 
'Sin ciudad'. Si hay ciudades sin departamentos asociados se deberá presentar en la columna del nombre del departamento el texto 'Sin departamento'.

Select nvl(department_name,'Sin departamento') Departamento, nvl(city,'Sin ciudad') Ciudad 
from departments d full outer join locations l
on d.location_id=l.location_id
order by 1;

---- Condiciones de filtrado con funciones de agregacion

CLAUSULA HAVING: permite agregar condiciones de filtrado cuando se trabaja con funciones de agregacion

Ejemplo 
Obtener el nombre del departamento, el salario promedio que se paga a los empleados del departamento
siempre y cuando ese salario promedio sea mayor a 5000;

select department_name, round(avg(salary),2) Salario_Promedio
from departments d, employees e
where d.department_id=e.department_id
group by department_name
having round(avg(salary),2)>5000;


----- Operadores de conjuntos de datos
Operador Union: permite unir o enlazar el resultado de dos o mas consultas. Aquellos registros iguales tanto para la primera como para la segunda
consulta se presentarian solo una vez. Para realizar una operacion de union se debe cumplir con dos condiciones:
1) La cantidad de columnas debe ser la misma tanto para la primera consulta como para la segunda.
2) El tipo de dato de cada columna debe ser el mismo.

Ejemplo: 
select last_name, first_name, hire_date, department_id
from employees 
where department_id=90
union 
select last_name, first_name, hire_date, department_id
from employees
where last_name like 'K%'
order by 1;

El operador union all permite unir o enlazar el resultado de dos o mas consultas. Si hay registros repetidos entre ambas consultas, 
se presentaran dos veces.

select last_name, first_name, hire_date, department_id
from employees 
where department_id=90
union all
select last_name, first_name, hire_date, department_id
from employees
where last_name like 'K%'
order by 1,2;


El operador intersect presenta las tuplas o filas que son comunes en la primera y la segunda consulta

select last_name, first_name, hire_date, department_id
from employees 
where department_id=90
intersect 
select last_name, first_name, hire_date, department_id
from employees
where last_name like 'K%'
order by 1,2;

El operador Minus presenta las tuplas que estan en la primera consulta pero que no aparecen en la segunda consulta.
El orden de las consultas producira un resultado diferente
select last_name, first_name, hire_date, department_id
from employees 
where department_id=90
minus
select last_name, first_name, hire_date, department_id
from employees
where last_name like 'K%'
order by 1,2;

------------ USO DE SUBCONSULTAS (subqueries) ----------------
Una subconsulta es una consulta dentro de otra

Subconsultas de una sola fila (Single-row subquerie): Devuelve una sola fila y una sola columna
Ejemplo 1:
Presentar el apellido, nombre y salario de los empleados que ganan el salario minimo

Paso 1: Determinar el valor del salario minimo
select min(salary)
from employees;

Paso 2: Armar la consulta
Select last_name, first_name, salary 
from employees 
where salary= (select min(salary) from employees);

Ejemplo 2:
Presentar el nombre, apelldo y salario de los empleados que trabajan en el departamento Accounting.
OPCION 1: SIN SUBCONSULTA;

select first_name, last_name, salary
from employees e, departments d
where d.department_name like 'Accounting'
and e.department_id=d.department_id;


OPCION 2: CON SUBCONSULTA

select first_name, last_name, salary
from employees 
where department_id=
(select department_id from departments 
where department_name like 'Accounting');

Subconsultas de varias filas (multiple row subqueries): Devuelve mas de una tupla, aunque sigue devolviendo una sola columna;
Ejemplo:
Obtener nombre, apellido y codigo de departamento de todos los empleados que se encuentren en un departamento donde labore un empleado
llamado John.

Paso 1: Obtener los empleados llamados John
select first_name from employees where first_name like 'John';

Paso 2: Armar la consulta
select first_name, last_name, department_id 
from employees
where department_id in (select department_id from employees where first_name like 'John');

Ejemplo 2: Presentar el nombre, apellido, salario y codigo de departamento de todos los empleados que ganen un salario mayor
a cualquiera de los salarios del departamento 110;

select first_name, last_name, salary, department_id 
from employees 
where salary> any (select salary from employees where department_id=110);

Ejemplo de subconsulta que no devuelve filas;

Select last_name, first_name, salary
from employees 
where department_id = (Select department_id
                    from departments
                    where department name like 'prueba');
 
Ejemplo:
Presentar el nombre y apellidos de aquellos empleados que son jefes
Paso 1:      Obtener el codigo de los empleados que son jefes
select distinct manager_id from employees where manager_id is not null;

Paso 2: Armar la consulta
select first_name, last_name 
from employees e, (select distinct manager_id from employees where manager_id is not null) j
where e.employee_id=j.manager_id;




------ CREATE VIEW -------
Una vista es una tabla logica basada en una o mas tablas o vistas
Las vistas en oraclea aparecen con V$
create view paises_provincias_view as
select pai_nombre, pro_nombre
from paises p. provincias pr
where p.pai_codigo=pr.oai_codigo;

SE PUEDE ACCEDER A LOS DATOS DE UNA VISTA DE MANERA SIMILAR A COMO SE ACCEDE A LOS DATOS DE UNA TABLA
ES DECIR, SE PUEDE USAR UNA SENTENCA DE SELECT;
Select * from paises_provincias_view;

Ejemplo de creacion de lista
PASO 1: Se crea la consulta que formará parte de la vista
Select department_name, first_name||' '||last_name empleados
from hr.departments d, hr.employees e
where d.department_id=e.department_id;

Paso 2: Se crea la vista
create view departments_employees_view as 
select department_name, first_name||' '||last_name empleados
from hr.departments d, hr.employees e
where d.department_id=e.department_id;

PASO 3: ACCEDER A LOS DATOS DE LA VISTA
select * from departments_employees_view;

como la vista es un objeto de la base de datos, si se desea eliminar se utiliza la sentencia drop;
drop view departments_employees_view;

----------------------------------------------------------------------------

PRIVILEGIOS Y ROLES
La autorizacion en el SGBD permite que solo ciertos usuarios puedan acceder, procesar o modificar dato. 
Tambien, crea limitaciones en el acceso de los usuarios o las acciones. Las limitaciones que se imponen
a los usuarios pueden aplicarse a objetos como esquemas, tablas completas o tuplas. 

Un privilegio es el derecho de usuario para ejecutar un tipo de declaracion de SQL, o el derecho que existe
para acceder al objeto que pertenece a otro usuario, ejecutar un paquete de PL/SQL etc.
los tipos de privilegios son definidos por la base de datos, Los privilegios se pueden clasificar en;
    **Privilegios administrativos: Son diseñados para ejectuar comunmente tareas administrativas como operaciones de respaldo y recuperaciones. 
    **Privilegios del sistema: Permiten a los usuarios ejecutar acciones en objets del esquema. Ejemplo: crear y actualizar tablas o tablespaces
    **Privilegios en tablas: Habilitan la seguridad de DDL o DML. Ejemplos: Operaciones en tablas como ALTER, INDEX y REFERENCES. Operaciones
        DELETE, INSERT, SELECT Y UPDATE en tablas o vistas.
    **Privilegios en vistas: Se puede aplicar permisos DML a las vistas, de forma similar a los privilegios sobre las tablas.
    **Privilegios sobre procedimientos: Se puede aplicar el privilegio de EXECUTE.
    **Privilegios de tipo: Se puede otorgar privilegios de sistema a tipos como objetos, VARRAYs y tablas anidadas.
    
Los roles son creados por los usuarios, generalmente los administradores de BD, para agrupar privilegios u otros role. Constituyen una manera de facilitar 
la concesion de multiples privilegios o roles a los usuarios. De esta forma, un conjunto de privilegios pueden ser otorgados (GRANT) o retirados (REVOKE) 
de varios usuarios simultaneamente. 

EJEMPLO: Se creará un rol y se asignará permisos al rol; y luego se asignará el rol a uno  o varios usuarios;

PASO 1: CREAR ROL
alter session set "_ORACLE_SCRIPT"=TRUE;

create role rol_empleado;

PASO 2: ASIGNAR AL ROL PERSMISOS PARA CONECTAR A LA BASE DE DATOS. LOS PERMISOS DE CONEXION Y DE CREAR SESION SE PUEDEN ASIGNAR DE FORMA INDIVIDUAL 
O SE PUEDE UTILIZAR EL ROL, CONNECT QUE EXISTE EN LA BD. PARA VERIFICAR LOS PERMISOS QUE TIENE EL ROL CONNECT SE PUEDE EJECUTAR LA SIGUIENTE CONSULTA.

select * from dba_sys_privs 
where grantee like 'CONNECT';

Para asignar el rol de connect al rol de empleado se ejecuta la siguiente sentencia;
grant connect to rol_empleado;
PASO 3: Se asignan privilegios adicionales correspondientes al esquema y propios del rol empleado.

Se asigna el privilegio de crear tablas dentro del esquema
Grant create table to rol_empleado;

Se asigna el privilegio de crear secuencias;
grant create sequence to rol_empleado;

Se asignan permisos de seleccion en ciertas tablas del esquema HR 
grant select on hr.employees to rol_empleado;
grant select on hr.regions to rol_empleado;

PASO 4: Se asigna el rol al usuario
create user rol identified by rol;
grant rol_empleado to rol;

ASIGNAR PERMISOS ADICIONALES AL ROL DE EMPLEADOS
grant insert on hr.regions to rol_empleado;
grant delete on hr.regions to rol_empleado;
grant select,insert,update,delete on hr.countries to rol_empleado;

ELIMINAR PRIVILEGIOS AL ROL O USUARIO
revoke create table from rol_empleado;

Insertar o eliminar privilegios a  un rol tambien afecta a aquellos usuarios con el rol asignado, por tanto
no es necesario actualizar el rol del usuario o algo parecido;

PERFILES
Un perfil es un conjunto de limites en los recursos de la base de datos. Si se asigna el perfil a un usuario, entonces el usuario
no puede exceder esos limites.
alter session set "_ORACLE_SCRIPT"=TRUE;
Create profile clave
limit password_reuse_max 2  --Especifica el numero de contraseñas requeridas antes de que la contraseña actual sea reutlizada
password_reuse_time 1;      --Especifica el numero de dias que se necesita antes de que se pueda reutlixar


Para eliminar perfil
drop profile clave;
alter user andres profile clave;


create profile conexion_usuario limit 
password_life_time 90
password_reuse_time 1/440
password_reuse_max 2
password_lock_time 10
password_grace_time 10;

alter profile clave limit 
password_reuse_time 1/1440;

create user pruebaC 
identified by 1234
default tablespace users
temporary tablespace temp 
quota unlimited on users
profile conexion_usuario
password expire
account unlock;