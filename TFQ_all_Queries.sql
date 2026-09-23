/* Dropping tables */
DROP TABLE IF EXISTS STUDENT_CLASSES CASCADE;
DROP TABLE IF EXISTS STUDENT_PARENT CASCADE;
DROP TABLE IF EXISTS STUDENTS CASCADE;
DROP TABLE IF EXISTS PARENTS CASCADE;
DROP TABLE IF EXISTS CLASSES CASCADE;
DROP TABLE IF EXISTS STAFF_SALARY CASCADE;
DROP TABLE IF EXISTS STAFF CASCADE;
DROP TABLE IF EXISTS SCHOOL CASCADE;
DROP TABLE IF EXISTS SUBJECTS CASCADE;
DROP TABLE IF EXISTS ADDRESS CASCADE;
DROP TABLE IF EXISTS PRODUCTS CASCADE;

/* Queary in Tables */
SELECT * FROM SCHOOL;
SELECT * FROM SUBJECTS;
SELECT * FROM STAFF;
SELECT * FROM STAFF_SALARY;
SELECT * FROM CLASSES;
SELECT * FROM STUDENTS;
SELECT * FROM PARENTS;
SELECT * FROM STUDENT_CLASSES;
SELECT * FROM STUDENT_PARENT;
SELECT * FROM ADDRESS;

/* Different SQL Operators:::    = , <, >, >=, <=, <>, !=, BETWEEN, ORDER BY, IN, NOT IN, LIKE, ALIASE, DISTINCT, LIMIT, CASE:
Comparison Operators: =, <>, != , >, <, >=, <=
Arithmetic Operators: +, -, *, /, %
Logical Operators: AND, OR, NOT, IN, BETWEEN, LIKE etc.    */

-- Basic queries
SELECT * FROM STUDENTS;   -- Fetch all columns and all records (rows) from table.
SELECT ID, FIRST_NAME FROM STUDENTS; -- Fetch only ID and FIRST_NAME columns from students table.

-- Comparison Operators
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME = 'Mathematics'; -- Fetch all records where subject name is Mathematics.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME <> 'Mathematics'; -- Fetch all records where subject name is not Mathematics.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME != 'Mathematics'; -- same as above. Both "<>" and "!=" are NOT EQUAL TO operator in SQL.
SELECT * FROM STAFF_SALARY WHERE SALARY > 10000; -- All records where salary is greater than 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000; -- All records where salary is less than 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000 ORDER BY SALARY; -- All records where salary is less than 10000 and the output is sorted in ascending order of salary.
SELECT * FROM STAFF_SALARY WHERE SALARY < 10000 ORDER BY SALARY DESC; -- All records where salary is less than 10000 and the output is sorted in descending order of salary.
SELECT * FROM STAFF_SALARY WHERE SALARY >= 10000; -- All records where salary is greater than or equal to 10000.
SELECT * FROM STAFF_SALARY WHERE SALARY <= 10000; -- All records where salary is less than or equal to 10000.

-- Logical Operators
SELECT * FROM STAFF_SALARY WHERE SALARY BETWEEN 5000 AND 10000; -- Fetch all records where salary is between 5000 and 10000.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME IN ('Mathematics', 'Science', 'Arts'); -- All records where subjects is either Mathematics, Science or Arts.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME NOT IN ('Mathematics', 'Science', 'Arts'); -- All records where subjects is not Mathematics, Science or Arts.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME LIKE 'Computer%'; -- Fetch records where subject name has Computer as prefixed. % matches all characters.
SELECT * FROM SUBJECTS WHERE SUBJECT_NAME NOT LIKE 'Computer%'; -- Fetch records where subject name does not have Computer as prefixed. % matches all characters.
SELECT * FROM STAFF WHERE AGE > 50 AND GENDER = 'F'; -- Fetch records where staff is female and is over 50 years of age. AND operator fetches result only if the condition mentioned both on left side and right side of AND operator holds true. In OR operator, atleast any one of the conditions needs to hold true to fetch result.
SELECT * FROM STAFF WHERE FIRST_NAME LIKE 'A%' AND LAST_NAME LIKE 'S%'; -- Fetch record where first name of staff starts with "A" AND last name starts with "S".
SELECT * FROM STAFF WHERE FIRST_NAME LIKE 'A%' OR LAST_NAME LIKE 'S%'; -- Fetch record where first name of staff starts with "A" OR last name starts with "S". Meaning either the first name or the last name condition needs to match for query to return data.
SELECT * FROM STAFF WHERE (FIRST_NAME LIKE 'A%' OR LAST_NAME LIKE 'S%') AND AGE > 50; -- Fetch record where staff is over 50 years of age AND has his first name starting with "A" OR his last name starting with "S".

-- Arithmetic Operators
SELECT (5+2) AS ADDITION;   -- Sum of two numbers. PostgreSQL does not need FROM clause to execute such queries.
SELECT (5-2) AS SUBTRACT;   -- Oracle & MySQL equivalent query would be -->  select (5+2) as Addition FROM DUAL; --> Where dual is a dummy table.
SELECT (5*2) AS MULTIPLY;
SELECT (5/2) AS DIVIDE;   -- Divides 2 numbers and returns whole number.
SELECT (5%2) AS MODULUS;  -- Divides 2 numbers and returns the remainder

SELECT STAFF_TYPE FROM STAFF ; -- Returns lot of duplicate data.
SELECT DISTINCT STAFF_TYPE FROM STAFF ; -- Returns unique values only.
SELECT STAFF_TYPE FROM STAFF LIMIT 5; -- Fetches only the first 5 records from the result.

-- CASE statement:  (IF 1 then print True ; IF 0 then print FALSE ; ELSE print -1)
SELECT STAFF_ID, SALARY
, CASE WHEN SALARY >= 10000 THEN 'High Salary'
       WHEN SALARY BETWEEN 5000 AND 10000 THEN 'Average Salary'
       WHEN SALARY < 5000 THEN 'Too Low'
  END AS RANGE
FROM STAFF_SALARY
ORDER BY 2 DESC;

-- TO_CHAR / TO_DATE:
SELECT * FROM STUDENTS WHERE TO_CHAR(DOB,'YYYY') = '2014';
SELECT * FROM STUDENTS WHERE DOB = TO_DATE('13-JAN-2014','DD-MON-YYYY');


-- JOINS (Two ways to write SQL queries):
-- #1. Using JOIN keyword between tables in FROM clause.
SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 C2, T2.COLUMN3 AS C3    -- C1, C2, C3 are aliase to the column
  FROM  TABLE1    T1
  JOIN  TABLE2 AS T2 ON T1.C1 = T2.C1 AND T1.C2 = T2.C2;    -- T1, T2 are aliases for table names.

-- #2. Using comma "," between tables in FROM clause.
SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 AS C2, T2.COLUMN3 C3
  FROM  TABLE1 AS T1, TABLE2 AS T2
 WHERE  T1.C1 = T2.C1
   AND  T1.C2 = T2.C2;


-- Fetch all the class name where Music is thought as a subject.
SELECT CLASS_NAME
FROM SUBJECTS SUB
JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID
WHERE SUBJECT_NAME = 'Music';

-- Fetch the full name of all staff who teach Mathematics.
SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME --, CLS.CLASS_NAME
FROM SUBJECTS SUB
JOIN CLASSES CLS ON CLS.SUBJECT_ID = SUB.SUBJECT_ID
JOIN STAFF STF ON CLS.TEACHER_ID = STF.STAFF_ID
WHERE SUB.SUBJECT_NAME = 'Mathematics';


-- Fetch all staff who teach grade 8, 9, 10 and also fetch all the non-teaching staff
-- UNION can be used to merge two differnt queries. UNION returns always unique records so any duplicate data while merging these queries will be eliminated.
-- UNION ALL displays all records including the duplicate records.
-- When using both UNION, UNION ALL operators, rememeber that noo of columns and their data type must match among the different queries.
SELECT STF.STAFF_TYPE
,    (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME
,    STF.AGE
,    (CASE WHEN STF.GENDER = 'M' THEN 'Male'
           WHEN STF.GENDER = 'F' THEN 'Female'
      END) AS GENDER
,    STF.JOIN_DATE
FROM STAFF STF
JOIN CLASSES CLS ON STF.STAFF_ID = CLS.TEACHER_ID
WHERE STF.STAFF_TYPE = 'Teaching'
AND   CLS.CLASS_NAME IN ('Grade 8', 'Grade 9', 'Grade 10')
UNION ALL
SELECT STAFF_TYPE
,    (FIRST_NAME||' '||LAST_NAME) AS FULL_NAME, AGE
,    (CASE WHEN GENDER = 'M' THEN 'Male'
           WHEN GENDER = 'F' THEN 'Female'
      END) AS GENDER
,    JOIN_DATE
FROM STAFF
WHERE STAFF_TYPE = 'Non-Teaching';


-- Count no of students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"
FROM STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
ORDER BY SC.CLASS_ID;

-- Return only the records where there are more than 100 students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"
FROM STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
HAVING COUNT(1) > 100
ORDER BY SC.CLASS_ID;

-- Parents with more than 1 kid in school.
SELECT PARENT_ID, COUNT(1) AS "no_of_kids"
FROM STUDENT_PARENT SP
GROUP BY PARENT_ID
HAVING COUNT(1) > 1;


--SUBQUERY: Query written inside a query is called subquery.
-- Fetch the details of parents having more than 1 kids going to this school. Also display student details.
SELECT (P.FIRST_NAME||' '||P.LAST_NAME) AS PARENT_NAME
,    (S.FIRST_NAME||' '||S.LAST_NAME) AS STUDENT_NAME
,    S.AGE AS STUDENT_AGE
,    S.GENDER AS STUDENT_GENDER
,    (ADR.STREET||', '||ADR.CITY||', '||ADR.STATE||', '||ADR.COUNTRY) AS ADDRESS
FROM PARENTS P
JOIN STUDENT_PARENT SP ON P.ID = SP.PARENT_ID
JOIN STUDENTS S ON S.ID = SP.STUDENT_ID
JOIN ADDRESS ADR ON P.ADDRESS_ID = ADR.ADDRESS_ID
WHERE P.ID IN (  SELECT PARENT_ID
                   FROM STUDENT_PARENT SP
               GROUP BY PARENT_ID
                 HAVING COUNT(1) > 1)
ORDER BY 1;


-- Staff details who’s salary is less than 5000
SELECT STAFF_TYPE, FIRST_NAME, LAST_NAME
FROM  STAFF
WHERE STAFF_ID IN (SELECT STAFF_ID
                     FROM STAFF_SALARY
                    WHERE SALARY < 5000);


--Aggregate Functions (AVG, MIN, MAX, SUM, COUNT): Aggregate functions are used to perform calculations on a set of values.
-- AVG: Calculates the average of the given values.
SELECT AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
WHERE STF.STAFF_TYPE = 'Teaching';

SELECT STF.STAFF_TYPE, AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

/* Note:
“::NUMERIC” is a cast operator which is used to convert values from one data type to another.
In the above query we use it display numeric value more cleanly by restricting the decimal point to only 2.
Here 10 is precision which is the total no of digits allowed.
2 is the scale which is the digits after decimal point.
*/

-- SUM: Calculates the total sum of all values in the given column.
SELECT STF.STAFF_TYPE, SUM(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

-- MIN: Returns the record with minimun value in the given column.
SELECT STF.STAFF_TYPE, MIN(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

-- MAX: Returns the record with maximum value in the given column.
SELECT STF.STAFF_TYPE, MAX(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

/*
SQL Joins: There are several types of JOIN but we look at the most commonly used:
1) Inner Join
    - Inner joins fetches records when there are matching values in both tables.
2) Outer Join
    - Left Outer Join
        - Left join fetches all records from left table and the matching records from right table.
        - The count of the query will be the count of the Left table.
        - Columns which are fetched from right table and do not have a match will be passed as NULL.
    - Right Outer Join
        - Right join fetches all records from right table and the matching records from left table.
        - The count of the query will be the count of the right table.
        - Columns which are fetched from left table and do not have a match will be passed as NULL.
    - Full Outer Join
        - Full join always return the matching and non-matching records from both left and right table.
*/

-- Inner Join: 21 records returned – Inner join always fetches only the matching records present in both right and left table.
-- Inner Join can be represented as eithe "JOIN" or as "INNER JOIN". Both are correct and mean the same.
SELECT COUNT(1)
FROM STAFF STF
JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 2;


-- 23 records – 23 records present in left table.
-- All records from LEFT table with be fetched irrespective of whether there is matching record in the RIGHT table.
SELECT COUNT(1)
FROM STAFF STF
LEFT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
LEFT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 2;


-- 24 records – 24 records in right table.
-- All records from RIGHT table with be fetched irrespective of whether there is matching record in the LEFT table.
SELECT COUNT(1)
FROM STAFF STF
RIGHT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
RIGHT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;


-- 26 records – all records from both tables. 21 matching records + 2 records from left + 3 from right table.
-- All records from both LEFT and RIGHT table with be fetched irrespective of whether there is matching record in both these tables.
SELECT COUNT(1)
FROM STAFF STF
FULL OUTER JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
FULL OUTER JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1,2;

/* ----------------------------------------------TFQ_END ------------------------------------------------------*/

SELECT * FROM product;
-- FIRST_VALUE 
-- Write query to display the most expensive product under each category (corresponding to each record)
select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product
from product;

-- LAST_VALUE 
-- Write query to display the least expensive product under each category (corresponding to each record)
select *,
first_value(product_name) 
    over(partition by product_category order by price desc) 
    as most_exp_product,
last_value(product_name) 
    over(partition by product_category order by price desc
        range between unbounded preceding and unbounded following) 
    as least_exp_product    
from product
WHERE product_category ='Phone';

-- Alternate way to write SQL query using Window functions
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product    
from product
WHERE product_category ='Phone'
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);
                   
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product,
nth_value(product_name, 5) over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);

-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
select x.product_name, 
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid Range Phones'
     when x.buckets = 3 then 'Cheaper Phones' END as Phone_Category
from (
    select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone') x;


-- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.
select product_name, cume_dist_percetage
from (
    select *,
    cume_dist() over (order by price desc) as cume_distribution,
    round(cume_dist() over (order by price desc)::numeric * 100,2)||'%' as cume_dist_percetage
    from product) x
where x.cume_distribution <= 0.3;


-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.
select product_name, per
from (
    select *,
    percent_rank() over(order by price) ,
    round(percent_rank() over(order by price)::numeric * 100, 2) as per
    from product) x
where x.product_name='Galaxy Z Fold 3';

select * from students;
alter table staff drop column join_date;
alter table staff alter column age type varchar(20);
alter table staff rename to staff_new;
alter table staff_new rename column first_name to full_name;
alter table staff_new add constraint unq_stf unique (staff_type);
insert into staff_new values ('001','permanent','st01','Rashed','islam',35,'01.11.1987','M'),
                             ('002','permanent','st02','Rahim','hassan',36,'02.11.1987','M'),
							 ('003','temporary','st04','Karim','hassan',38,'02.11.1985','M'),
							 ('004','temporary','st06','Rohima','Khatun',40,'02.11.1983','F'),
							 ('005','permanent','st07','Kayem','hossain',39,'02.11.1980','M'),
							 ('006','temporary','st10','hassan','rohani',33,'02.11.1982','M'),
                             ('007','permanent','st12','Kiyam','hossain',41,'02.11.1981','M');
select * from staff_new;
update staff_new
set staff_type = 'Temporary'
where staff_id = '001';
update staff_new
set staff_type = 'Temporary', first_name = 'Rashad'
where staff_id = '001';
delete from staff_new where age = 41;

create table school (
 school_id varchar(20) not null,
 school_name varchar(100),
 school_type varchar(20),
 address_id varchar (20)
);
insert into school values
                   ('schl1001','Noble school','CBSE','ADR1001'),
				   ('schl1002','Noble school','CBSE','ADR1002'),
				   ('schl1003','NB school','CSE','ADR1003'),
                   ('schl1004','NB school','CSE','ADR1004'),
				   ('schl1005','HB school','EEE','ADR1004'),
				   ('schl1006','HB school','CSE','ADR1006'),
				   ('schl1007','BBB school','CSE','ADR1005');
select * from school;
create table subjects(
 subject_id varchar(20) not null,
 subject_name varchar(20)
);
insert into subjects values ('subj1001','Mathematics'),
                             ('subj1002','Science'),
							 ('subj1003','Social studies'),
							 ('subj1004','English'),
							 ('subj1005','Arts'),
							 ('subj1006','Bangla'),
							 ('subj1007','Informatincs');
select * from subjects;
create table staff_salary (
	staff_id varchar(20)not null,
	salary int,
	currency varchar(20)
	);
insert into staff_salary values 
        ('stf2004',15000, 'USD'),
		('stf2006',65000, 'USD'),
		('stf2007',10000, 'USD'),
		('stf2008',10500, 'USD'),
		('stf2009',9500, 'USD'),
		('stf2005',200500, 'USD'),
		('stf2010',12500, 'USD');


-- WITH CLAUSE --
-- QUERY 1 :
drop table emp;
create table emp
( emp_ID int
, emp_NAME varchar(50)
, SALARY int);

insert into emp values(101, 'Mohan', 40000);
insert into emp values(102, 'James', 50000);
insert into emp values(103, 'Robin', 60000);
insert into emp values(104, 'Carol', 70000);
insert into emp values(105, 'Alice', 80000);
insert into emp values(106, 'Jimmy', 90000);

select * from emp;

with avg_sal(avg_salary) as
		(select cast(avg(salary) as int) from emp)
select *
from emp e
join avg_sal av on e.salary > av.avg_salary

-- QUERY 2 :
drop table sales ;
create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

-- Find total sales per each store
select s.store_id, sum(s.cost) as total_sales_per_store
from sales s
group by s.store_id;

-- Find average sales with respect to all stores
select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
from (select s.store_id, sum(s.cost) as total_sales_per_store
	from sales s
	group by s.store_id) x;

-- Find stores who's sales were better than the average sales accross all stores
select *
from   (select s.store_id, sum(s.cost) as total_sales_per_store
				from sales s
				group by s.store_id
	   ) total_sales
join   (select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
				from (select s.store_id, sum(s.cost) as total_sales_per_store
		  	  		from sales s
			  			group by s.store_id) x
	   ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;

-- Using WITH clause
WITH total_sales as
		(select s.store_id, sum(s.cost) as total_sales_per_store
		from sales s
		group by s.store_id),
	avg_sales as
		(select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
		from total_sales)
select *
from   total_sales
join   avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;

---- Window function ----
drop table employee;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

/* **************
   Video Summary
 ************** */

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no.  of records.
select max(salary) as max_salary from employee;
select dept_name, max(salary) from employee
group by dept_name;

-- By using MAX as an window function, SQL will not reduce records but the result will be shown corresponding to each record.
select e.*,
max(salary) over() as max_salary
from employee e;

select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e; --- final code 

-- row_number(), rank() and dense_rank()
select e.*,
row_number() over() as rn
from employee e;

select e.*,
row_number() over(partition by dept_name) as rn
from employee e; --final code

-- Fetch the first 2 employees from each department to join the company.
select * from (
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as rn
	from employee e) x
where x.rn < 3;

-- Fetch the top 3 employees in each department earning the max salary.
select * from (
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee e) x
where x.rnk < 4;

-- Checking the different between rank, dense_rnk and row_number window functions:
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as dense_rnk,
row_number() over(partition by dept_name order by salary desc) as rn
from employee e;

-- lead and lag
-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal
from employee e;

select e.*,
lag(salary, 2, 0) over(partition by dept_name order by emp_id) as prev_empl_sal
from employee e;

select e.*,
lead(salary, 2, 0) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;

-- Similarly using lead function to see how it is different from lag.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;

select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' 
	 end as sal_range
from employee e;

-- Script to create the Product table and load data into it.

DROP TABLE product;
CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);

-- All the SQL Queries written during the video

select * from product;

-- FIRST_VALUE 
-- Write query to display the most expensive product under each category (corresponding to each record)
select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product
from product;

-- LAST_VALUE 
-- Write query to display the least expensive product under each category (corresponding to each record)
select *,
first_value(product_name) 
    over(partition by product_category order by price desc) as most_exp_product,
from product;

select *,
last_value(product_name)
    over(partition by product_category order by price desc
        range between unbounded preceding and unbounded following) as least_exp_product    
from product; -- with frame clause 

select *,
last_value(product_name)
    over(partition by product_category order by price desc
        range between 2 preceding and 2 following) as least_exp_product    
from product;

select *,
first_value(product_name) 
    over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) 
    over(partition by product_category order by price desc
        rows between unbounded preceding and unbounded following) as least_exp_product    
from product
WHERE product_category ='Phone'; --combined (for both highest and least  expensive price)

'-- Alternate way to write SQL query using Window functions
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product    
from product
WHERE product_category ='Phone'
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);'
                     
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product,
nth_value(product_name, 2) over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);

-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone';

select x.product_name, 
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid Range Phones'
     when x.buckets = 3 then 'Cheaper Phones' END as Phone_Category 
from (
    select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone') x;

-- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.
select *,
    cume_dist() over (order by price desc) as cume_distribution
from product;

select *,
    cume_dist() over (order by price desc) as cume_distribution,
    round(cume_dist() over (order by price desc)::numeric * 100,2) as cume_dist_percetage
    from product;
	
select product_name, cume_dist_percetage
from (
    select *,
    cume_dist() over (order by price desc) as cume_distribution,
    round(cume_dist() over (order by price desc)::numeric * 100,2)||'%' as cume_dist_percetage
    from product) x
where x.cume_distribution <= 0.3;

-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.
select *,
    percent_rank() over(order by price) ,
    round(percent_rank() over(order by price)::numeric * 100, 2) as per
    from product;

select product_name, per
from (
    select *,
    percent_rank() over(order by price) ,
    round(percent_rank() over(order by price)::numeric * 100, 2) as per
    from product) x
where x.product_name='Galaxy Z Fold 3';

/*-- Manage Duplicate data --*/
-- Scenario 1: Data duplicated based on SOME of the columns

-- Write a query to Delete duplicate dta from cars table. 
-- Duplicte record is identified based on the model and brand name.

create table cars (
       id int,
       model varchar(50),
	   brand varchar (40),
	   color varchar(30),
	   make int
);

insert into cars 
       values (2, 'EOS', 'Mercedes_Benz', 'Black', 2022),
	          (4, 'Ioniq5', 'Hyundai', 'White', 2021),
			  (6, 'Ioniq5', 'Hyundai', 'Green', 2021),
			  (1, 'ModelS', 'Tesla', 'Blue', 2018),
			  (5, 'ModelS', 'Tesla', 'Silver', 2018),
			  (3, 'iX', 'BMW', 'Red', 2022);
select * from cars;

-->> SOLUTION 1: Using UNIQUE identifier.
select model, brand, count(*)
from cars 
group by model, brand;--> To see rows with duplicated value

select model, brand, count(*) 
from cars 
group by model, brand
having count(*)>1; --> to identify only the rows with duplication.

select model, brand, max(id) 
from cars 
group by model, brand
having count(*)>1; --> find out the max ID of duplication.

delete from cars
where id in ( 
select max(id) 
from cars 
group by model, brand
having count(*)>1); --> to delete the duplication id.
select * from cars;

-->> SOLUTION 2: Using SELF join.
select *
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id; 

select c2.*
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

select c2.id
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

delete from cars 
where id in (
		    select c2.id
			from cars c1
			join cars c2 on c1.model = c2.model and c1.brand = c2.brand
			where c1.id < c2.id);

-->> SOLUTION 3: Using WINDOW function.
select *
,row_number() over (partition by model, brand) as rn 
from cars

select * from (
	select *
	,row_number() over (partition by model, brand) as rn 
	from cars) x
where x.rn>1;

select id 
from (
	select *
	,row_number() over (partition by model, brand) as rn 
	from cars) x
where x.rn>1;

delete from cars
where id in (
	select id 
    from (
	    select *
	    ,row_number() over (partition by model, brand) as rn 
	    from cars) x
        where x.rn>1);--> final 

-->> SOLUTION 4: Using MIN function. This delete even multiple dupliction records.
select model, brand
from cars
group by model, brand; --> To find the unique observations of the brand and modeel 

select model, brand, min(id)
from cars
group by model, brand; --> To find the very first records inserted  

select * from cars
where id not in (
				select min(id)
				from cars
				group by model, brand);--> To find the duplicated rows 

select id from cars 
where id not in (
			select min(id)
			from cars
			group by model, brand); --> To find the duplicated id only


delete from cars 
where id not in (
			select min(id)
			from cars
			group by model, brand);

-->> SOLUTION 5: Using BACKUP table.
create table cars_bkp
as 
select * from cars where 1=2; --> To create a backup table with the same structure of cars.

select * 
from cars
where id in (select min(id)
			from cars
			group by model, brand);--> To populate cars_bkp with the data of cars table.

drop table cars; --> To drop the table with duplication 
alter table cars_bkp rename to cars;--> To replace the backup table as a main table.

/* ##########################################################################
   <<<<>>>> Scenario 1: Data duplicated based on SOME of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate data from cars table. Duplicate record is identified based on the model and brand name.

drop table if exists cars;
create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);

select * from cars
order by model, brand;

-->> SOLUTION 1: Delete using Unique identifier
delete from cars
where id in ( select max(id)
              from cars
              group by model, brand
              having count(1) > 1);

-->> SOLUTION 2: Using SELF join
delete from cars
where id in ( select c2.id
              from cars c1
              join cars c2 on c1.model = c2.model and c1.brand = c2.brand
              where c1.id < c2.id);

-->> SOLUTION 3: Using Window function
delete from cars
where id in ( select id
              from (select *
                   , row_number() over(partition by model, brand order by id) as rn
                   from cars) x
              where x.rn > 1);

-->> SOLUTION 4: Using MIN function. This delete even multiple duplicate records.
delete from cars
where id not in ( select min(id)
                  from cars
                  group by model, brand);

-->> SOLUTION 5: Using backup table.
drop table if exists cars_bkp;
create table if not exists cars_bkp
as
select * from cars where 1=0;

insert into cars_bkp
select * from cars
where id in ( select min(id)
              from cars
              group by model, brand);

drop table cars;
alter table cars_bkp rename to cars;

-->> SOLUTION 6: Using backup table without dropping the original table.
drop table if exists cars_bkp;
create table if not exists cars_bkp
as
select * from cars where 1=0;

insert into cars_bkp
select * from cars
where id in ( select min(id)
              from cars
              group by model, brand);

truncate table cars;

insert into cars
select * from cars_bkp;

drop table cars_bkp;

/* ##########################################################################
   <<<<>>>> Scenario 2: Data duplicated based on ALL of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate entry for a car in the CARS table.

drop table if exists cars;
create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);

select * from cars;

-->> SOLUTION 1: Delete using CTID / ROWID (in Oracle)
delete from cars
where ctid in ( select max(ctid)
                from cars
                group by model, brand
                having count(1) > 1);

-->> SOLUTION 2: By creating a temporary unique id column
alter table cars add column row_num int generated always as identity

delete from cars
where row_num not in (select min(row_num)
                      from cars
                      group by model, brand);

alter table cars drop column row_num;

-->> SOLUTION 3: By creating a backup table.
create table cars_bkp as
select distinct * from cars;

drop table cars;
alter table cars_bkp rename to cars;

-->> SOLUTION 4: By creating a backup table without dropping the original table.
create table cars_bkp as
select distinct * from cars;

truncate table cars;

insert into cars
select distinct * from cars_bkp;

drop table cars_bkp;

-->Find the distance travelled by each car per day
-- Suppose you have a car travelling certain distance and the is presented as below-
   Day1- 50km
   Day2- 100km
   Day3- 200km
--Now the distance is a cumulative sum as in:
  row2=(kms travelled on that day+row1 kms)
-- How should I get the table in the form of kms travelled by the car on a given day
   and not the sum of the total distance?

-- Create a table to solve the problem below
create table cars2 (
	cars varchar(25),
	days varchar (20),
	cummulative_distance int
);
insert into cars2
values ('car1', 'day1', '50'),
	   ('car1', 'day2', '100'),
	   ('car1', 'day3', '200'),
	   ('car2', 'day1', '0'),
	   ('car3', 'day1', '0'),
	   ('car3', 'day2', '50'),
	   ('car3', 'day3', '50'),
	   ('car3', 'day4', '100');
select *from cars2;
select * 
, cummulative_distance - lag(cummulative_distance) over (partition by cars order by days) as travelled_per_day 
from cars2;

select * 
, cummulative_distance - lag(cummulative_distance, 1, 0) over (partition by cars order by days) as travelled_per_day 
from cars2;

select cars, days 
, cummulative_distance - lag(cummulative_distance, 1, 0) over (partition by cars order by days) as travelled_per_day 
from cars2;



/* By ME */
-- WITH CLAUSE --
-- QUERY 1 :
drop table emp;
create table emp
( emp_ID int
, emp_NAME varchar(50)
, SALARY int);

insert into emp values(101, 'Mohan', 40000);
insert into emp values(102, 'James', 50000);
insert into emp values(103, 'Robin', 60000);
insert into emp values(104, 'Carol', 70000);
insert into emp values(105, 'Alice', 80000);
insert into emp values(106, 'Jimmy', 90000);

select * from emp;

with avg_sal(avg_salary) as
		(select cast(avg(salary) as int) from emp)
select *
from emp e
join avg_sal av on e.salary > av.avg_salary

-- QUERY 2 :
drop table sales ;
create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

-- Find total sales per each store
select s.store_id, sum(s.cost) as total_sales_per_store
from sales s
group by s.store_id;

-- Find average sales with respect to all stores
select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
from (select s.store_id, sum(s.cost) as total_sales_per_store
	from sales s
	group by s.store_id) x;

-- Find stores who's sales were better than the average sales accross all stores
select *
from   (select s.store_id, sum(s.cost) as total_sales_per_store
				from sales s
				group by s.store_id
	   ) total_sales
join   (select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
				from (select s.store_id, sum(s.cost) as total_sales_per_store
		  	  		from sales s
			  			group by s.store_id) x
	   ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;

-- Using WITH clause
WITH total_sales as
		(select s.store_id, sum(s.cost) as total_sales_per_store
		from sales s
		group by s.store_id),
	avg_sales as
		(select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
		from total_sales)
select *
from   total_sales
join   avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;


---- Window function ----
drop table employee;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

/* **************
   Video Summary
 ************** */

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no. of records.
select max(salary) as max_salary from employee;
select dept_name, max(salary) from employee
group by dept_name;

select e.dept_name, max(salary) as max_salary
from employee e
group by e.dept_name;

-- By using MAX as an window function, SQL will not reduce records but the result will be shown corresponding to each record.
select e.*,
max(salary) over() as max_salary
from employee e;

select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e; --- final code 

-- row_number(), rank() and dense_rank()
select e.*,
row_number() over() as rn
from employee e;

select e.*,
row_number() over(partition by dept_name) as rn
from employee e; --final code

-- Fetch the first 2 employees from each department to join the company.
select * from (
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as rn
	from employee e) x
where x.rn < 3;

-- Fetch the top 3 employees in each department earning the max salary.
select * from (
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee e) x
where x.rnk < 4;

-- Checking the different between rank, dense_rnk and row_number window functions:
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as dense_rnk,
row_number() over(partition by dept_name order by salary desc) as rn
from employee e;

-- lead and lag
-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal
from employee e;

select e.*,
lag(salary, 2, 0) over(partition by dept_name order by emp_id) as prev_empl_sal
from employee e;

select e.*,
lead(salary, 2, 0) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;

-- Similarly using lead function to see how it is different from lag.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;

select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' 
	 end as sal_range
from employee e;

-- Script to create the Product table and load data into it.

DROP TABLE product;
CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);

-- All the SQL Queries written during the video

/*-- Manage Duplicate data --*/
-- Scenario 1: Data duplicated based on SOME of the columns

-- Write a query to Delete duplicate dta from cars table. 
-- Duplicte record is identified based on the model and brand name.

create table cars (
       id int,
       model varchar(50),
	   brand varchar (40),
	   color varchar(30),
	   make int
);

insert into cars 
       values (2, 'EOS', 'Mercedes_Benz', 'Black', 2022),
	          (4, 'Ioniq5', 'Hyundai', 'White', 2021),
			  (6, 'Ioniq5', 'Hyundai', 'Green', 2021),
			  (1, 'ModelS', 'Tesla', 'Blue', 2018),
			  (5, 'ModelS', 'Tesla', 'Silver', 2018),
			  (3, 'iX', 'BMW', 'Red', 2022);
select * from cars;

-->> SOLUTION 1: Using UNIQUE identifier.
select model, brand, count(*)
from cars 
group by model, brand;--> To see rows with duplicated value

select model, brand, count(*) 
from cars 
group by model, brand
having count(*)>1; --> to identify only the rows with duplication.

select model, brand, max(id) 
from cars 
group by model, brand
having count(*)>1; --> find out the max ID of duplication.

delete from cars
where id in ( 
select max(id) 
from cars 
group by model, brand
having count(*)>1); --> to delete the duplication id.
select * from cars;

-->> SOLUTION 2: Using SELF join.
select *
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id; 

select c2.*
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

select c2.id
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

delete from cars 
where id in (
		    select c2.id
			from cars c1
			join cars c2 on c1.model = c2.model and c1.brand = c2.brand
			where c1.id < c2.id);

-->> SOLUTION 3: Using WINDOW function.
select *
,row_number() over (partition by model, brand) as rn 
from cars

select * from (
	select *
	,row_number() over (partition by model, brand) as rn 
	from cars) x
where x.rn>1;

select id 
from (
	select *
	,row_number() over (partition by model, brand) as rn 
	from cars) x
where x.rn>1;

delete from cars
where id in (
	select id 
    from (
	    select *
	    ,row_number() over (partition by model, brand) as rn 
	    from cars) x
        where x.rn>1);--> final 

-->> SOLUTION 4: Using MIN function. This delete even multiple dupliction records.
select model, brand
from cars
group by model, brand; --> To find the unique observations of the brand and modeel 

select model, brand, min(id)
from cars
group by model, brand; --> To find the very first records inserted  

select * from cars
where id not in (
				select min(id)
				from cars
				group by model, brand);--> To find the duplicated rows 

select id from cars 
where id not in (
			select min(id)
			from cars
			group by model, brand); --> To find the duplicated id only


delete from cars 
where id not in (
			select min(id)
			from cars
			group by model, brand);

-->> SOLUTION 5: Using BACKUP table.
create table cars_bkp
as 
select * from cars where 1=2; --> To create a backup table with the same structure of cars.

select * 
from cars
where id in (select min(id)
			from cars
			group by model, brand);--> To populate cars_bkp with the data of cars table.

drop table cars; --> To drop the table with duplication 
alter table cars_bkp rename to cars;--> To replace the backup table as a main table.

/* ##########################################################################
   <<<<>>>> Scenario 1: Data duplicated based on SOME of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate data from cars table. Duplicate record is identified based on the model and brand name.

drop table if exists cars;
create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);

select * from cars
order by model, brand;

-->> SOLUTION 1: Delete using Unique identifier
delete from cars
where id in ( select max(id)
              from cars
              group by model, brand
              having count(1) > 1);

-->> SOLUTION 2: Using SELF join
delete from cars
where id in ( select c2.id
              from cars c1
              join cars c2 on c1.model = c2.model and c1.brand = c2.brand
              where c1.id < c2.id);

-->> SOLUTION 3: Using Window function
delete from cars
where id in ( select id
              from (select *
                   , row_number() over(partition by model, brand order by id) as rn
                   from cars) x
              where x.rn > 1);

-->> SOLUTION 4: Using MIN function. This delete even multiple duplicate records.
delete from cars
where id not in ( select min(id)
                  from cars
                  group by model, brand);

-->> SOLUTION 5: Using backup table.
drop table if exists cars_bkp;
create table if not exists cars_bkp
as
select * from cars where 1=0;

insert into cars_bkp
select * from cars
where id in ( select min(id)
              from cars
              group by model, brand);

drop table cars;
alter table cars_bkp rename to cars;

-->> SOLUTION 6: Using backup table without dropping the original table.
drop table if exists cars_bkp;
create table if not exists cars_bkp
as
select * from cars where 1=0;

insert into cars_bkp
select * from cars
where id in ( select min(id)
              from cars
              group by model, brand);

truncate table cars;

insert into cars
select * from cars_bkp;

drop table cars_bkp;

/* ##########################################################################
   <<<<>>>> Scenario 2: Data duplicated based on ALL of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate entry for a car in the CARS table.

drop table if exists cars;
create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);

select * from cars;

-->> SOLUTION 1: Delete using CTID / ROWID (in Oracle)
delete from cars
where ctid in ( select max(ctid)
                from cars
                group by model, brand
                having count(1) > 1);

-->> SOLUTION 2: By creating a temporary unique id column
alter table cars add column row_num int generated always as identity

delete from cars
where row_num not in (select min(row_num)
                      from cars
                      group by model, brand);

alter table cars drop column row_num;

-->> SOLUTION 3: By creating a backup table.
create table cars_bkp as
select distinct * from cars;

drop table cars;
alter table cars_bkp rename to cars;

-->> SOLUTION 4: By creating a backup table without dropping the original table.
create table cars_bkp as
select distinct * from cars;

truncate table cars;

insert into cars
select distinct * from cars_bkp;

drop table cars_bkp;

-->Find the distance travelled by each car per day
-- Suppose you have a car travelling certain distance and the is presented as below-
   Day1- 50km
   Day2- 100km
   Day3- 200km
--Now the distance is a cumulative sum as in:
  row2=(kms travelled on that day+row1 kms)
-- How should I get the table in the form of kms travelled by the car on a given day
   and not the sum of the total distance?

-- Create a table to solve the problem below
create table cars2 (
	cars varchar(25),
	days varchar (20),
	cummulative_distance int
);
insert into cars2
values ('car1', 'day1', '50'),
	   ('car1', 'day2', '100'),
	   ('car1', 'day3', '200'),
	   ('car2', 'day1', '0'),
	   ('car3', 'day1', '0'),
	   ('car3', 'day2', '50'),
	   ('car3', 'day3', '50'),
	   ('car3', 'day4', '100');
select *from cars2;
select * 
, cummulative_distance - lag(cummulative_distance) over (partition by cars order by days) as travelled_per_day 
from cars2;

select * 
, cummulative_distance - lag(cummulative_distance, 1, 0) over (partition by cars order by days) as travelled_per_day 
from cars2;

select cars, days 
, cummulative_distance - lag(cummulative_distance, 1, 0) over (partition by cars order by days) as travelled_per_day 
from cars2;

select * from product;

-- FIRST_VALUE 
-- Write query to display the most expensive product under each category (corresponding to each record)
select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product
from product;

-- LAST_VALUE 
-- Write query to display the least expensive product under each category (corresponding to each record)
select *,
first_value(product_name) 
    over(partition by product_category order by price desc) as most_exp_product,
from product;

select *,
last_value(product_name)
    over(partition by product_category order by price desc
        range between unbounded preceding and unbounded following) as least_exp_product    
from product; -- with frame clause 

select *,
last_value(product_name)
    over(partition by product_category order by price desc
        range between 2 preceding and 2 following) as least_exp_product    
from product;

select *,
first_value(product_name) 
    over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) 
    over(partition by product_category order by price desc
        rows between unbounded preceding and unbounded following) as least_exp_product    
from product
WHERE product_category ='Phone'; --combined (for both highest and least  expensive price)

'-- Alternate way to write SQL query using Window functions
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product    
from product
WHERE product_category ='Phone'
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);'
                     
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product,
nth_value(product_name, 2) over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);

-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone';

select x.product_name, 
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid Range Phones'
     when x.buckets = 3 then 'Cheaper Phones' END as Phone_Category 
from (
    select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone') x;

-- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.
select *,
    cume_dist() over (order by price desc) as cume_distribution
from product;

select *,
    cume_dist() over (order by price desc) as cume_distribution,
    round(cume_dist() over (order by price desc)::numeric * 100,2) as cume_dist_percetage
    from product;
	
select product_name, cume_dist_percetage
from (
    select *,
    cume_dist() over (order by price desc) as cume_distribution,
    round(cume_dist() over (order by price desc)::numeric * 100,2)||'%' as cume_dist_percetage
    from product) x
where x.cume_distribution <= 0.3;

-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.
select *,
    percent_rank() over(order by price) ,
    round(percent_rank() over(order by price)::numeric * 100, 2) as per
    from product;

select product_name, per
from (
    select *,
    percent_rank() over(order by price) ,
    round(percent_rank() over(order by price)::numeric * 100, 2) as per
    from product) x
where x.product_name='Galaxy Z Fold 3';


