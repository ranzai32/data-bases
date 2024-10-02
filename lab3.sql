CREATE DATABASE lab3;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  lastname VARCHAR(255) NOT NULL ,
  city VARCHAR(255)
);

CREATE TABLE departments (
    code INTEGER,
    name VARCHAR(30),
    budget INTEGER
);

CREATE TABLE employees (
    ssn VARCHAR(9),
    name VARCHAR(50),
    lastname VARCHAR(50),
    department INTEGER,
    city VARCHAR(50)
);

INSERT INTO departments(code,name,budget) VALUES(14,'IT',65000);
INSERT INTO departments(code,name,budget) VALUES(37,'Accounting',15000);
INSERT INTO departments(code,name,budget) VALUES(59,'Human Resources',240000);
INSERT INTO departments(code,name,budget) VALUES(77,'Research',55000);
INSERT INTO departments(code,name,budget) VALUES(45,'Management',155000);
INSERT INTO departments(code,name,budget) VALUES(11,'Sales',85000);

INSERT INTO employees(ssn,name,lastname,department, city) VALUES('123234877','Michael','Rogers',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('152934485','Anand','Manikutty',14, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('222364883','Carol','Smith',37, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('326587417','Joe','Stevens',37, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332154719','Mary-Anne','Foster',14, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332569843','George','ODonnell',77, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('546523478','John','Doe',59, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('631231482','David','Smith',77, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('654873219','Zacary','Efron',59, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('745685214','Eric','Goldsmith',59, 'Atyrau');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657245','Elizabeth','Doe',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657246','Kumar','Swamy',14, 'Almaty');



INSERT INTO customers(name,lastname, city) VALUES('John','Wills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Garry','Foster', 'London');
INSERT INTO customers(name,lastname, city) VALUES('Amanda','Hills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('George','Doe', 'Tokyo');
INSERT INTO customers(name,lastname, city) VALUES('David','Little', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Shawn','Efron', 'Astana');
INSERT INTO customers(name,lastname, city) VALUES('Eric','Gomez', 'Shymkent');
INSERT INTO customers(name,lastname, city) VALUES('Elizabeth','Tailor', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Julia','Adams', 'Astana');

SELECT lastname
    FROM employees;
SELECT DISTINCT lastname
    FROM employees;

SELECT *
    FROM employees
        WHERE lastname = 'Smith';

SELECT * FROM employees
    WHERE lastname = ('Smith' OR 'Doe');

SELECT * FROM employees
    WHERE department =  14;

SELECT * FROM employees
    WHERE department = (37 OR 77);

SELECT sum(budget) FROM departments;

SELECT department, COUNT(*) AS employee_count
    FROM employees
        GROUP BY department;

SELECT department, COUNT(*) AS employee_count
    FROM employees
        GROUP BY department
            HAVING COUNT(*) > 2;

SELECT name
    FROM departments
        ORDER BY budget DESC
            LIMIT 1 OFFSET 1;

SELECT name, lastname
FROM employees
JOIN (
    SELECT DISTINCT ON (code) code
    FROM departments
    ORDER BY budget ASC
) departments ON employees.department = departments.code;

SELECT name, lastname
FROM employees
WHERE city = 'Almaty'

UNION

SELECT name, lastname
FROM customers
WHERE city = 'Almaty';

SELECT *
    FROM departments
        WHERE budget > 60000
            ORDER BY budget ASC, code DESC;

UPDATE departments
    SET budget = budget * 0.9
        WHERE budget = (SELECT MIN(budget) FROM departments);

UPDATE employees
    SET department = (SELECT code FROM departments WHERE name = 'IT')
        WHERE department = (SELECT code FROM departments WHERE name = 'Research');

DELETE FROM employees
    WHERE department = (SELECT code FROM departments WHERE name = 'IT');

DELETE FROM employees;




