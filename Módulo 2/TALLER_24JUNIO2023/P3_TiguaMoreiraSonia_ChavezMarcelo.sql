--******************************************************
-- Módulo Nro. 2
-- Práctica Nro. 2
-- Integrantes:
-- Sonia Tigua Moreira
-- Marcelo Chávez

-- Actividad Nro. 1

select COUNT(*) as 'CantGerentes'
from Staff
where Staff='F' and position in ('Manager','Supervisor');

-- Actividad Nro. 2
select COUNT(*) as 'CantVisitas'
from Viewing 
where viewDate BETWEEN '01-05-2004' and '31-05-2004':

-- Actividad Nro. 3
select fName, lName
from Client
where max(maxRent) and prefType='Flat';

-- Actividad Nro. 4
select propertyNo, street, type, min(rent)
from PropertyForRent
group by type
having min(rent);

-- Actividad Nro. 5
select avg(rent) as 'Promedio'
from PropertyForRent
where city='Glasgow' or city='London'
group by city;

-- Actividad Nro. 6
select count(position) as 'CantEmpXTipo'
from Staff
group by position
having count(position) > 2;

-- Actividad Nro. 7
select count(prefType) as 'CantClientes'
from Client
group by prefType 
having count(prefType) > 2;