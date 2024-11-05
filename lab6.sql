--1
CREATE DATABASE lab6;

--2
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    streeet_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY ,
    department_name VARCHAR(50) UNIQUE ,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

--3
SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
    LEFT JOIN departments d
        ON e.department_id = d.department_id;

--4
SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
    lEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id = 80 or e.department_id = 40;

--5
SELECT first_name, last_name, d.department_name, l.city, l.state_province
FROM employees e
    LEFT JOIN departments d on d.department_id = e.department_id
LEFT JOIN locations l on l.location_id = d.location_id;

--6
SELECT * FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id;

--7
SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
         LEFT JOIN departments d
                   ON e.department_id = d.department_id;
