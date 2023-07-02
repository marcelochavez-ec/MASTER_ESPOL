--******************************************************
-- Módulo Nro. 2
-- Práctica Nro. 2
-- Integrantes:
-- Sonia Tigua Moreira
-- Marcelo Chávez

-- Actividad Nro. 1
select branchNo, city
from Branch
where (select count(*) from Staff where Staff.branchNo = Branch.branchNo) between 2 and 3;

-- Actividad Nro. 2
select propertyNo, type, rooms, rent
from PropertyForRent
where city like '%Glasgow%';

-- Actividad Nro. 3
select staffNo, fName, lName
from Staff
where (select city from Branch where Staff.branchNo = Branch.branchNo) like in ('Bristol', 'Aberdeen')

-- Actividad Nro. 4
select *
from Client
where fName like '%M' and maxRent <= 800;

-- Actividad Nro. 5
select fName, lName
from Client
where clientNo =
(select clientNo from Viewing, propertyForRent
where propertyForRent=propertyNo and city='Glasgow')

-- Actividad Nro. 6
select branchNo
from Branch
where (select city PropertyForRent.branchNo = Branch=branchNo) like in ('Glasgow');