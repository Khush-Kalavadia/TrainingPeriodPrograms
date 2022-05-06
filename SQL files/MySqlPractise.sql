SELECT DATABASE();									-- know current database name

CREATE DATABASE IF NOT EXISTS MyDatabase;			-- create database with given name 
CREATE SCHEMA MyDatabase;							-- other way to create database
SHOW DATABASES;		 								-- show list of all databases
SHOW SCHEMAS;										-- same as displaying databases
USE MyDatabase;
DROP DATABASE MyDatabase;							-- it gives an exception if database does not exist 
DROP DATABASE IF EXISTS MyDatabase;					-- it gives a warning if database does not exist 

CREATE DATABASE EmployeeDb;
CREATE TABLE employee_table ( 
id int NOT NULL AUTO_INCREMENT,						-- it is set to auto increment
name varchar(45),									-- as it is primary key automatic it is set to NOT NULL	
occupation varchar(35),
age int,
PRIMARY KEY (id, name)								-- can set primary key to multiple column using comma
);
SHOW TABLES;
SHOW TABLES IN MyDatabase;
SHOW TABLES IN MyDatabase WHERE Tables_in_MyDatabase = "employee_information";
DROP TABLE employee_table;
DESCRIBE employee_table;							-- get information or structure of the table. Table name is case sensitive
SHOW FULL COLUMNS FROM employee_work;				-- can get some more information
ALTER TABLE employee_table
ADD gender char(6)
FIRST;												-- add first column 
ALTER TABLE employee_table
ADD lastName varchar(45)
AFTER name;											-- add after the "name" column
/*can also do
ALTER TABLE employee_table
ADD gender char(6)
ADD lastName varchar(45);
*/
ALTER TABLE employee_table
DROP COLUMN gender;
ALTER TABLE employee_table							-- modify column description
MODIFY lastName varchar(50);
ALTER TABLE employee_table							-- rename a column
CHANGE COLUMN name firstName
varchar(40);										-- need to give column description even in case of column rename
ALTER TABLE employee_table
RENAME TO employee_information;
DESCRIBE employee_information;
RENAME TABLE employee_information TO employee_info;
SHOW FULL TABLES;
CREATE TABLE employee_work(
id int,
work varchar(45),
PRIMARY KEY (id)
);
CREATE TEMPORARY TABLE Students( 								-- temporary table accessible only in current session
name VARCHAR(40) NOT NULL, 										-- temporary table can't be converted to permanent
total_marks DECIMAL(12,2) DEFAULT 0.00, 						-- 12 is size of decimal number while 2 digits follow the 10 digits before decimal
total_subjects INT UNSIGNED NOT NULL DEFAULT 0
);    
INSERT INTO Students(name, total_marks, total_subjects) 
VALUES ('Joseph', 150.75, 2), ('Peter', 180.75, 2);				
SELECT * FROM Students;	
TRUNCATE TABLE Students;										-- delete an entire data from a table without removing the table structure.
ALTER TABLE employee_work
ADD FOREIGN KEY (id) REFERENCES employee_info(id);	
CREATE TABLE employee_work(
id int,
work varchar(45),
PRIMARY KEY (id),
CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES employee_info(id)
);
SELECT COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME		-- find foreign keys
 FROM information_schema.key_column_usage WHERE table_name = "employee_work";			-- can use information_schema.table_constraints
ALTER TABLE table_name DROP FOREIGN KEY fk_constraint_name;  
SHOW CREATE TABLE employee_work;
describe employee_work;
INSERT INTO employee_info(id, firstName) VALUES (1, "Rahul"), (2, "Ramesh");		
INSERT INTO employee_work(id, work) VALUES (1,"developement"), (2, "hr");			-- foreign key so need to insert in info table first
CREATE TABLE IF NOT EXISTS duplicate_employee_work SELECT * FROM employee_work;		-- duplicate table
SELECT * FROM duplicate_employee_work;												
ALTER TABLE duplicate_employee_work ADD COLUMN temp_col varchar(10) DEFAULT "HELLO";-- add drop column
ALTER TABLE duplicate_employee_work DROP COLUMN temp_col;
ALTER TABLE duplicate_employee_work CHANGE COLUMN temp_col temp_column VARCHAR(25);  				-- rename column
ALTER TABLE duplicate_employee_work RENAME COLUMN temp_col TO temp_column;
SELECT * FROM employee_work;
INSERT INTO employee_info(firstName) VALUES ("Ravi");
INSERT INTO employee_work(work) VALUES ("QA");
DESCRIBE employee_work;

CREATE TABLE employee_work_trial(	-- DEFAULT in primary key works for one time because parent table has 1 and it would repeat after one usage	
id int DEFAULT 1,
work varchar(30),
PRIMARY KEY (id),
CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES employee_info(id)		-- cannot add foreign key to temporary table
);
INSERT INTO employee_work_trial(work) VALUES ("HR");				-- this won't give error
INSERT INTO employee_work_trial(work) VALUES ("SALES");				-- this will give error
TRUNCATE TABLE employee_info;										-- can't truncate as its primary key is being used as foreign key in employee_work_trial

SHOW INDEXES FROM employee_work_trial;
SHOW CREATE TABLE employee_work_trial;
select * from information_schema.table_constraints where TABLE_NAME="employee_work_trial";
ALTER TABLE employee_work ADD COLUMN date date;						-- add column having type date
SELECT * FROM employee_work;
INSERT INTO employee_work(id, work, date) VALUES (5, "hr", "2000-3-4");
INSERT INTO employee_work(id, work, date) VALUES (6, "hr", "2020-12-31");
SELECT date_format(date, '%d/%m/%Y') FROM employee_work;					-- printing date in specific format
SELECT * FROM employee_work;
UPDATE employee_work SET date = '2020-11-30' where work = "developement";	-- update single value in a row
UPDATE employee_work SET work = 'sales', date = '2010-9-16' WHERE id = 2;  -- update multiple value in a row
ALTER TABLE employee_info ADD COLUMN email varchar(45);						-- adding column
SELECT * FROM employee_info;
UPDATE employee_info SET email = 'rahul@gmail.com' where firstName = 'Rahul';	
UPDATE employee_info SET email = REPLACE(email, '@gmail.com', '@yahoo.com') where firstName = 'Rahul';	-- update a sub-string
INSERT INTO employee_info(id, firstName) VALUES (3,'Pravin');
DELETE FROM employee_info WHERE id=3;										-- delete row based on given condition
DELETE FROM employee_info ORDER BY id LIMIT 2;								-- delete first 2 rows if they are not set as foreign key in other table
SELECT work, count(*), MAX(date) FROM employee_work 					    -- specifing the columns which would be available even after grouping
GROUP BY work 																-- grouping the above query
ORDER BY MAX(date) DESC														-- ordering based on the available grouped dates
LIMIT 2;																	-- limiting the output to 2 rows
SELECT count(*), work FROM employee_work GROUP BY work HAVING work = 'hr';
SELECT * FROM employee_work;

CREATE TEMPORARY TABLE sales(
item int,
sales int
);
INSERT INTO sales VALUES (1,2), (2,3), (3,2), (1,4), (2,3); 
SELECT * FROM sales;
SELECT DISTINCT item FROM sales;
SELECT DISTINCT sales FROM sales;
SELECT DISTINCT item, sales FROM sales;				-- this gives distinct combimation of {item and sales}.
SELECT DISTINCT sales, item FROM sales;				-- this also gives same result just the position of column is different
SELECT * FROM sales ORDER BY item, sales DESC;		-- first orders based on item then based on sales
SELECT item, SUM(sales) AS "Total sales" FROM sales GROUP BY item;
SELECT item, SUM(sales) AS "Total sales" FROM sales GROUP BY item HAVING SUM(sales)>4;

show tables;
select * from employee_info;
insert into employee_info(firstName) values ("Manish");
delete from employee_info where id=7;
-- DELETE FROM employee_info WHERE id = (SELECT id FROM employee_info ORDER BY id DESC LIMIT 4);	-- cannot use target table inside where when deleting
DELETE FROM employee_info ORDER BY id DESC LIMIT 4;				-- remove last 4 rows
show full tables;

-- MOVIE DATABASE FOR JOINS
create database MovieDb;
use MovieDb;
create table movie(id int, title varchar(50), category varchar(20), rating int, PRIMARY KEY(id));
insert into movie(id, title, category, rating) values (1, "Real steel", "Action", 5), (2, "Mysterious island", "Adventure", 8), (3, "Transformer", "Action", 6);
create table member(name varchar(50), movieId int, constraint foreign key (movieId) references movie(id));
insert into member(name, movieId) values ("Adam Smith", 2), ("Lee Pong", 1), ("Ravi Kumar", 2);

select * from movie;
select * from member;
select * from movie, member;													-- cross join
select * from movie cross join member;
select * from movie inner join member on id = movieId where rating>5;			-- inner join
select * from movie natural join member;										-- natural join works when the column name and datatype of a column is same
select * from movie left outer join member on id = movieId;						-- left join (outer is optional)
select * from movie as a right join member as b on a.id = b.movieId;			-- right join
select m1.id, m1.title from movie as m1, movie as m2 where m1.title <> m2.title; -- just an example to create a query using self join
select * from movie where rating<6 union select * from movie where rating>7;
select category, title from movie where rating<6 union select title, category from movie where rating>7;	-- same number of columns and sequence is MUST

-- TCL STATEMENT
set autocommit=0;							-- also need to turn off autocommit to use rollback
start transaction;							-- MUST START to add savepoints
savepoint tablesCreation;
create table table1(id int);				
create table table2(id int);
rollback to tablesCreation;					-- cannot rollback the ddl statement like create. gives error
insert table1(id) values (10), (20), (25);
insert table2(id) values (20), (7), (10);
rollback;									-- rollback to tablesCreation savepoint by default
rollback to tablesCreation;					-- rollback to tablesCreation 
select * from table1;
select * from table2;
drop table table1, table2;
set autocommit=1;

select * from table1 where id in (select id from table2);		-- equivalent to "= ANY"
select * from table2 where id > any (select id from table1);	-- table1 -> 10,20,25 || table2 checks for 20 finds 10 which is smaller than 20
																-- table2 checks for 7 and finds none smaller than 7 same with 10. Can try >= to see the result
select * from table1 where id between 15 and 25;				-- includes 15 and 25
select * from table1 where id not in (select id from table2);	-- id which are in table1 and not in table2. basically table1 MINUS table2

-- EXISTS
CREATE DATABASE Shop;
USE Shop;
CREATE TABLE customer(  
  cust_id int NOT NULL,  
  name varchar(35),  
  occupation varchar(25),  
  age int  
);  
CREATE TABLE orders (  
    order_id int NOT NULL,   
    cust_id int,   
    prod_name varchar(45),  
    order_date date  
);  
INSERT INTO customer(cust_id, name, occupation, age)   
VALUES (101, 'Peter', 'Engineer', 32),  
(102, 'Joseph', 'Developer', 30),  
(103, 'John', 'Leader', 28),  
(104, 'Stephen', 'Scientist', 45),  
(105, 'Suzi', 'Carpenter', 26),  
(106, 'Bob', 'Actor', 25),  
(107, NULL, NULL, NULL);  
INSERT INTO orders (order_id, cust_id, prod_name, order_date)   
VALUES (1, '101', 'Laptop', '2020-01-10'),  
(2, '103', 'Desktop', '2020-02-12'),  
(3, '106', 'Iphone', '2020-02-15'),  
(4, '104', 'Mobile', '2020-03-05'),  
(5, '102', 'TV', '2020-03-20');  
SELECT * FROM customer; 
SELECT * FROM orders;  
SELECT name, occupation FROM customer WHERE EXISTS (SELECT * FROM orders WHERE customer.cust_id = orders.cust_id);  
SELECT name, occupation FROM customer WHERE EXISTS (SELECT order_date FROM orders WHERE customer.cust_id = orders.cust_id);  
-- select * or order_date makes no difference in subquery of mysql
SELECT true, false, TRUE, FALSE;										-- check boolean to number
SELECT EXISTS(SELECT * from customer WHERE cust_id=104) AS Result;  	-- want to know whether row exists or not
SELECT prod_name, order_date from orders where order_date between '2020-3-10' and '2020-2-12';		-- sequence matters
SELECT prod_name, order_date from orders where order_date between '2020-2-12' and '2020-3-10';		-- between smaller and greater

-- end --