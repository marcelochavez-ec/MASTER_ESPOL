--******************************************************
-- Módulo Nro. 2
-- Práctica Nro. 5
-- Integrantes:
-- Quimix Mariuxi
-- Chávez Marcelo

-- Actividad Nro. 1
insert into Branch
values ('B008','89 Slate Rd', 'London', 'BZW 10E');

-- Actividad Nro. 2
insert into Staff
values ('SL67','Mark','Ruiz','Manager','M','24-jan-80','26000','B003');

-- Actividad Nro. 3
insert into Staff ('staffNo','fName','lName','position','branchNo')
values ('SG6','Elena','Martínez','Assitant','B007');

-- Actividad Nro. 4
insert into PropertyForRent
values ('PG18','24 Madrid St','Aberdeen','AB1720U','House','3','250','CO93','SG6','B007');

-- Actividad Nro. 5
update Client
set maxrent = maxrent * 1.2
where prefType = 'Flat';

-- Actividad Nro. 6
update PropertyForRent
set rooms = rooms + 1;

-- Actividad Nro. 7
update PropertyForRent
set rent = rent * .5
where city = 'Glasgow';

--Actividad Nro. 8
delete from Viewing
where clientNo = 'CR56';






