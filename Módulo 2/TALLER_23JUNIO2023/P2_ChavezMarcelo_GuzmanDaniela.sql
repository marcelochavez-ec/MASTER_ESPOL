--******************************************************
-- Módulo Nro. 2
-- Práctica Nro. 2
-- Integrantes:
-- Daniela Guzmán
-- Marcelo Chávez

-- Actividad Nro. 1

select staffNo,fName, lName, Position, sex, salary
from staff
where sex='F'
order by fName; 

-- Actividad Nro. 2
select *
from PropertyForRent
where (rooms between 3 and 5) and staffNo not null;

-- Actividad Nro. 3
select *
from PropertyForRent
where city not like '%Aberdeen%';

-- Actividad Nro. 4
select clientNo, viewDate
from Viewing
where comment like 'too%';

-- Actividad Nro. 5
select *
from Client
where maxRent>=500 and prefType='House';

-- Actividad Nro. 6
select fName, lName
from PrivateOwner
where fName not like in '[a,e,i,o,u]%' and lName like '[a,e,i,o,u]%' and adress like '%Glasgow';