CREATE DATABASE IF NOT EXISTS company;

USE company;

CREATE TABLE employee_info(
id INT PRIMARY KEY,
name VARCHAR(50),	
salary DOUBLE
);

INSERT INTO employee_info
(name, id, salary)
VALUES
("Adam",1,25000),
("Bob",2,30000),
("casey",3,40000);

SELECT * FROM employee_info;