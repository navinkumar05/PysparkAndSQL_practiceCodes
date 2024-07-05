drop table if exists employee;
create table if not exists employee
(
	emp_id			varchar(20),
	emp_name		varchar(50),
	salary			int,
	dept_id			varchar(20),
	manager_id		varchar(20)
);
insert into employee values
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');


drop table if exists department;
create table if not exists department
(
	dept_id			varchar(20),
	dept_name		varchar(50)
);
insert into department values
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

drop table if exists manager;
create table if not exists manager
(
	manager_id			varchar(20),
	manager_name		varchar(50),
	dept_id				varchar(20)
);
insert into manager values
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');

drop table if exists projects;
create table if not exists projects
(
	project_id			varchar(20),
	project_name		varchar(100),
	team_member_id		varchar(20)
);
insert into projects values
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');

select * from employee;
select * from department;
select * from manager;
select * from projects;

-- Inner Join
select e.emp_name, d.dept_name
from employee e
join department d on e.dept_id = d.dept_id;

-- Left Join
select e.emp_name, d.dept_name
from employee e
left join department d on e.dept_id = d.dept_id;

-- Right Join
select e.emp_name, d.dept_name
from employee e
right join department d on e.dept_id = d.dept_id;

-- Multiple joins 1
select e.emp_name, d.dept_name, m.manager_name
from employee e
right join department d on e.dept_id = d.dept_id -- returns on Manoj, Rahul, Michael and James
join manager m on m.manager_id = e.manager_id; -- Hence returns on the managers of above 4 employees

-- Multiple joins 2
select e.emp_name, d.dept_name, m.manager_name
from employee e
right join department d on e.dept_id = d.dept_id -- returns on Manoj, Rahul, Michael and James
left join manager m on m.manager_id = e.manager_id;

-- Multiple joins 3
select e.emp_name, d.dept_name, m.manager_name
from employee e
right join department d on e.dept_id = d.dept_id -- returns on Manoj, Rahul, Michael and James
right join manager m on m.manager_id = e.manager_id;

-- Multiple joins 4
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e
right join department d on e.dept_id = d.dept_id -- returns on Manoj, Rahul, Michael and James
right join manager m on m.manager_id = e.manager_id
inner join projects p on p.team_member_id = m.manager_id;




--------------------------------------------------------------------

-- Inner join / JOIN
select e.emp_name, d.dept_name
from employee e join department d on e.dept_id = d.dept_id;

-- left join
select e.emp_name, d.dept_name
from employee e left join department d on e.dept_id = d.dept_id;

-- left join = inner join + all records from left table (returns null value for any columns fetched from right table)

-- right join
select e.emp_name, d.dept_name
from employee e right join department d on e.dept_id = d.dept_id;

-- right join = inner join + all records from right table (returns null value for any columns fetched from left table)



-- fetch emp name, their manager who are not working on any project.
select e.emp_name, m.manager_name
from employee e
join manager m on m.manager_id = e.manager_id
where not exists (select 1 from projects p where p.team_member_id = e.emp_id);

-- Fetch details of ALL emp, their manager, their department and the projects they work on.
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e
left join department d on d.dept_id = e.dept_id
join manager m on m.manager_id = e.manager_id
left JOIN projects p on p.team_member_id = e.emp_id;

-- Fetch details of ALL emp and ALL manager, their department and the projects they work on.
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e
left join department d on d.dept_id = e.dept_id
right join manager m on m.manager_id = e.manager_id
left join projects p on p.team_member_id = e.emp_id;
