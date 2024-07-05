drop table employee;
create table employee
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

insert into employee values
('M1', 'Prem', 115000, 'D3', 'M4'),
('M2', 'Shripadh', 125000, 'D4', 'M4'),
('M3', 'Nick', 150000, 'D1', 'M4'),
('M4', 'Cory', 220000, 'D1', '');

drop table department;
create table department
(
	dept_id			varchar(20),
	dept_name		varchar(50)
);
insert into department values
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

drop table company;
create table company
(
	company_id		varchar(10),
	company_name	varchar(50),
	location		varchar(20)
);
insert into company values
('C001', 'techTFQ Solutions', 'Kuala Lumpur');

insert into company values
('C002', 'techTFQ Media Group', 'Singapore');


DROP TABLE family;
CREATE TABLE family
(
    member_id     VARCHAR(10),
    name          VARCHAR(50),
    age           INT,
    parent_id     VARCHAR(10)
);
insert into family values
  ('F1', 'David', 4, 'F5'),
  ('F2', 'Carol', 10, 'F5'),
  ('F3', 'Michael', 12, 'F5'),
  ('F4', 'Johnson', 36, ''),
  ('F5', 'Maryam', 40, 'F6'),
  ('F6', 'Stewart', 70, ''),
  ('F7', 'Rohan', 6, 'F4'),
  ('F8', 'Asha', 8, 'F4');



select * from employee; -- D1, D2, D10
select * from department; -- D1, D2, D3, D4
select * from company;

-- INNER JOIN can also be represented as "JOIN"
-- INNER Join = Fetches only matching records in both tables based on the JOIN condition.
-- Write a query to fetch the employee name and their corresponding department name.
SELECT e.emp_name, d.dept_name
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id;

-- LEFT JOIN can also be represented as "LEFT OUTER JOIN"
-- LEFT Join = INNER Join + all remaining records from Left Table (returns null value for any columns fetched from right table)
-- Write a query to fetch ALL the employee name and their corresponding department name.
SELECT e.emp_name, d.dept_name
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id;

-- RIGHT JOIN can also be represented as "RIGHT OUTER JOIN"
-- RIGHT Join = INNER Join + all remaining records from Right Table (returns null value for any columns fetched from left table)
-- Write a query to fetch ALL the department and the employees under these departments.
SELECT e.emp_name, d.dept_name
FROM employee e
RIGHT JOIN department d ON e.dept_id = d.dept_id;


-- FULL JOIN can also be represented as "FULL OUTER JOIN"
-- FULL Join = INNER Join
--              + all remaining records from Left Table (returns null value for any columns fetched from right table)
--              + all remaining records from Right Table (returns null value for any columns fetched from left table)
-- Write a query to fetch the employee name and their corresponding department name.
-- Make sure to include all the employees and the departments.
SELECT e.emp_name, d.dept_name
FROM employee e
FULL JOIN department d ON e.dept_id = d.dept_id;


-- CROSS JOIN
-- CROSS JOIN returns cartesian product.
-- Meaning it will match every record from the left table with every record from the right table hence it will return records from both table.
-- No join condition is required to be specified.
SELECT e.emp_name, d.dept_name
FROM employee e
CROSS JOIN department d;

-- Write a query to fetch the employee name and their corresponding department name.
-- Also make sure to display the company name and the company location correspodning to each employee.


-- NATURAL JOIN - SQL will naturally choose the column on which join should happen based on the column name.
-- Natural join will perform inner join operation if there are columns with same name in both table. If there are more than 1 column with same name then join will happen based on all these columns.
-- If there are no columns with same name in both table then it performs cross join
-- If you specify * in select list then it displays the join columns in the beginning and does not repeat it.
-- No join condition is required to be specified.
SELECT *
FROM employee e
NATURAL JOIN department d;

-- Altering the dept_id column name to see how Natural Join acts when there are no common column names in both tables.
--alter table department rename column dept_id to department_id
--alter table department rename column department_id to dept_id;



-- SELF JOIN - When you join a table to itself, this is called as SELF Join.
-- There is no keyword like SELF JOIN but we just use the regular JOIN keyword to make the self join.
-- Write a query to fetch the child name and their age correspodning to their parent name and parent age.
select child.name as child_name
, child.age as child_age
, parent.name as parent_name
, parent.age as parent_age
from family as child
join family as parent on parent.member_id = child.parent_id;


select child.name as child_name
, child.age as child_age
, parent.name as parent_name
, parent.age as parent_age
from family as child
left join family as parent on parent.member_id = child.parent_id;



-- ANSI JOIN - Uses the JOIN clause and mentions join condition under the ON clause and filter conditions in the WHERE clause.
SELECT e.emp_name, d.dept_name
FROM employee e
JOIN department d ON e.dept_id = d.dept_id
WHERE e.salary > 15000;

SELECT e.emp_name, d.dept_name
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id
WHERE e.salary > 15000;


-- Non ANSI JOIN - Uses comma to seperate multiple tables and then use WHERE clause to mention both the join and filter conditions.
SELECT e.emp_name, d.dept_name
FROM employee e
,    department d
WHERE e.salary > 15000
AND   e.dept_id = d.dept_id;

SELECT e.emp_name, d.dept_name
FROM employee e
,    department d
WHERE e.salary > 15000
AND   e.dept_id = d.dept_id (+); -- This is unsupported in PostgreSQL but works in Oracle. Other RDBMS may have alternative symbols to performs same thing.
