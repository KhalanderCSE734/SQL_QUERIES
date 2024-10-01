CREATE DATABASE college;

USE college;

CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(50)
);

INSERT INTO student 
(rollno, name, marks, grade, city)
VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhumika", 93,"B", "Mumbai"),
(103,"Chetan",85, "B", "Mumbai"),
(104, "dhruv",96,"A","Delhi"),
(105,"emanuel",12,"F","Delhi"),
(106,"farah",82,"B","Delhi");

SELECT * FROM student;

ALTER TABLE student ADD section VARCHAR(3) DEFAULT "3D";	-- Adding  new column to our table with 'default' keyword which set the values defaultely if not initialised explicitly	

ALTER TABLE student ADD questionSolved INT CHECK (questionSolved>0 AND questionSolved<100) ;	-- Adding check condition for new columns

ALTER TABLE student ALTER COLUMN questionSolved SET DEFAULT 20;			-- Setting the default values after adding the column and changing again, but it is not setting 
/*
			I'm not able to set this
ALTER TABLE student ALTER COLUMN questionSolved DROP DEFAULT;
ALTER TABLE student MODIFY COLUMN questionSolved INT DEFAULT 20;	

*/

UPDATE student 
SET marks = 92
WHERE rollno = 105;

UPDATE student
SET grade = "A"
WHERE rollno = 105;

-- Usage of 'Select' command 
-- (--) This is for comment and (/* */) This is for multiple line comment

SELECT name, marks from student;		-- selecting particular columns

SELECT * FROM student;

SELECT city FROM student;		

SELECT DISTINCT city FROM student;		-- selecting the column which has only distinct elements

/* Starting With Clauses */				-- (1). Where caluse

SELECT * FROM student WHERE marks > 90;		-- Adding condition which filter out the things 

SELECT * FROM student WHERE city = "Delhi";		

SELECT name,city,marks FROM student WHERE city = "Delhi" AND marks>80;	

-- Using 'operators' in 'Where' Clause

SELECT name,marks FROM student WHERE marks+10>90;
SELECT name,city FROM student WHERE city!="Shivamogga";
SELECT * FROM student WHERE marks>80 OR city = "Delhi";
SELECT * FROM student WHERE marks BETWEEN 80 AND 90;
SELECT * FROM student WHERE city NOT IN ("Mumbai","Delhi");
SELECT * FROM student LIMIT 2;			-- It will limit the selection only to first 2 rows
SELECT * FROM student WHERE marks>90 LIMIT 2;	
SELECT * FROM student ORDER BY city ASC;		-- It will list down the elements in ascending order fashion by city name
SELECT * FROM student ORDER BY marks DESC;

-- TO PRINT TOP 3 PEOPLE OF CLASS
SELECT * FROM student ORDER BY marks DESC LIMIT 3;



-- AGGREGATE Functions in SQL
-- 1.)COUNT() 	2.) MAX()	3.)MIN()	4.)SUM()	5.)AVG()

SELECT MAX(marks) FROM student;			-- Returns only one value
SELECT MIN(marks) FROM student;
SELECT COUNT(rollno) FROM student;		-- Returns the count of total number in the table
SELECT COUNT(city) FROM student;


-- GROUP clause in sql
/*

The GROUP BY clause is used to group rows that have the same values in specified columns into "groups". It is commonly used with aggregate functions like COUNT(), SUM(), AVG(), MAX(), and MIN() to perform operations on these groups of rows.

*/



SELECT city
FROM student 
GROUP BY city;


SELECT city, COUNT(city)
FROM student 
GROUP BY city;

SELECT city, COUNT(rollno)
FROM student 
GROUP BY city;


SELECT city, COUNT(name)
FROM student 
GROUP BY city;


SELECT city, AVG(marks)
FROM student 
GROUP BY city;


SELECT city, marks
FROM student 
GROUP BY city;


SELECT city, AVG(marks)
FROM student
GROUP BY city
ORDER BY city ASC;


SELECT city, AVG(marks)
FROM student
GROUP BY city
ORDER BY AVG(marks) ASC;

-- Q.) Find the total number of people in each grade

SELECT grade, COUNT(rollno)		-- Instead count(grade) we could have even wrote count(name) or anything	
FROM student
GROUP BY grade
ORDER BY grade ASC;

-- HAVING clause in sql

/*

The HAVING clause is used to filter the results after grouping the data using the GROUP BY clause. It's like a WHERE clause, but for grouped data.

WHERE: Filters rows before the data is grouped.
HAVING: Filters groups after the data is grouped.

*/



SELECT city, COUNT(rollno)
FROM student
GROUP BY city
HAVING MAX(marks)>80;			-- 'Having' applies condition on groups, where as 'Where' applies condition single row



-- General Order of writing the select query
SELECT city, count(marks)
FROM student
WHERE marks>70
GROUP BY city
HAVING	MAX(marks)>60
ORDER BY city ASC;


-- To turn off safe mode in sql we need to run the following command
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM student;

UPDATE student
SET marks = marks +1;

UPDATE student
SET GRADE = "A"
WHERE marks BETWEEN 90 AND 100;

UPDATE student
SET GRADE = "B"
WHERE marks BETWEEN 80 AND 90;


CREATE TABLE teacher(
	teacher_id INT PRIMARY KEY,
	teacher_name VARCHAR(50),
    dep_id INT NOT NULL,
    FOREIGN KEY (dep_id) REFERENCES department(DEP_id)
    -- We can do cascading here (Meaning to say if we change anything in 'department', it will even reflect in 'teacher' table, syntax is
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE department(
	DEP_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- We can visualize our DATABASE by 'REVERSE ENGINEERING' (We can see ER diagram)


-- 'Truncate Table student' (In order to delete the content of the table apart from the schema)

SELECT * FROM student;


-- UPDATE Command (usage) (To update data of existing row)

UPDATE student
SET marks = 90
WHERE rollno = 101;


UPDATE student
SET questionSolved = 10
WHERE city = 'Mumbai';


UPDATE student
SET grade = 'O'
WHERE grade = 'A';



SELECT * FROM student;


-- DELETE command (usage)

DELETE FROM student WHERE marks<30;

DELETE FROM student WHERE city = 'PUne';


INSERT INTO student VALUES (101, "anil", 78, "C", "Pune",'3D','10');


SELECT * FROM student;


-- Cascading in mySQL

CREATE TABLE teacher(
	teacher_id INT PRIMARY KEY,
	teacher_name VARCHAR(50),
    dep_id INT NOT NULL,
    FOREIGN KEY (dep_id) REFERENCES department(DEP_id)
    -- We can do cascading here (Meaning to say if we change anything in 'department', it will even reflect in 'teacher' table, syntax is, 				If we delete anything from department entire row of teacher will also get deleted
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE department(
	DEP_id INT PRIMARY KEY,
    name VARCHAR(50)
);


TRUNCATE table department;  	-- Cannot truncate a table which has primary key as foriegn key in another table

INSERT INTO department 
VALUES 
(101,"DBMS"),
(102,"DS"),
(103,"JAVA");

INSERT INTO department 
VALUES
(104,"COA");

INSERT INTO teacher
VALUES
(201,"Rekha",101),
(202,"Radhika",102),
(203,"Vikranth",103),
(204,"Sneha",104),
(205,"Namratha",102),
(206,"Sandhya",101),
(207,"Ragini",103);


DROP TABLE teacher;

UPDATE department
SET DEP_id = 105			-- I was able to do this after dropping the 'teacher' table and re
WHERE DEP_id = 104;			-- Changing the things here will even make changes in 'teacher' table


SET SQL_SAFE_UPDATES = 0;

SELECT * FROM department;
SELECT * FROM teacher;
SELECT * FROM student;

-- JOINS in mySQL

SELECT * 
FROM department
INNER JOIN teacher
ON department.DEP_id = teacher.dep_id;

-- we can use alis

SELECT * 
FROM department as d
INNER JOIN teacher as t
ON d.DEP_id = t.dep_id;


-- LEFT join

SELECT * 
FROM department as d
LEFT JOIN teacher as t		-- Here I have everything to be comman, so I'm getting every single value in all joins
ON d.DEP_id = t.dep_id;


-- RIGHT Join

SELECT * 
FROM department as d
RIGHT JOIN teacher as t		-- Here I have everything to be comman, so I'm getting every single value in all joins
ON d.DEP_id = t.dep_id;

-- FULL join , we need to use 'UNION' in mySQL as we don't have that , And here we'll get only unique elements
SELECT * 
FROM department as d
LEFT JOIN teacher as t		
ON d.DEP_id = t.dep_id
UNION
SELECT * 
FROM department as d
RIGHT JOIN teacher as t		
ON d.DEP_id = t.dep_id;


SELECT * 
FROM department as d
LEFT JOIN teacher as t		
ON d.DEP_id = t.dep_id
WHERE t.dep_id IS NULL;

-- Self Join 

CREATE TABLE employee(
	id INT,
	name VARCHAR(50),
    manager_id INT,
    PRIMARY KEY (id)
);

INSERT INTO employee
(id, name, manager_id)
VALUES
(101,"Oggy",103),
(102,"Bob",104),
(103,"Jack",NULL),
(104,"Olly",103);

SELECT * FROM employee;

-- 1.)
SELECT * 
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;

-- 2.)
SELECT a.name, b.name
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;

-- 3.)
SELECT a.name AS MANAGER, b.name AS EMPLOYEE
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;



/*			SQL SUB QUERIES				*/

SELECT * FROM student;		-- We'll work on existing student table

SELECT AVG(marks)			-- Output was 88.5000
FROM student;

SELECT name,marks
FROM student
WHERE marks>88.5000;


-- we can combine the above two in one by using 'sub queries'

SELECT name, marks
FROM student
WHERE marks > 
(
SELECT AVG(marks) 
FROM student
);



-- Q.)	Print the student who have even roll Number
		
SELECT * FROM student;		

SELECT name,rollno
FROM student
WHERE rollno%2=0;			-- We can even do this using sub queries

SELECT name, rollno
FROM student
WHERE rollno IN (
	SELECT rollno 
    FROM student
    WHERE rollno%2=0
);

-- Q.) Selecting students from Delhi who have scored maximum marks using sub query


SELECT MAX(marks)
FROM (
SELECT *
FROM student
WHERE city = "Delhi"
)	AS temp_Delhi;				-- We need to use the alias compulsorily in order to execute the sub-query (Compulsory When we are using it in 'FROM' sub query)

-- We can create virtual table in mySQL by using the concept of 'views' 


CREATE VIEW view1 AS 
SELECT rollno, name, marks FROM student;			-- We can create and apply all the operations which were generally applied on table

SELECT * FROM view1;	

SELECT * FROM view1
WHERE marks>80;

DROP VIEW view1;

