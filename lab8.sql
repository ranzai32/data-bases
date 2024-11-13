CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(3, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customer(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

-- 3 --
create role junior_dev login;

-- 4 --
create view salesman_view as select
        salesman_id,
        name,
        city,
        commission
from salesman where city = 'New York';

-- 5 --
create view order_details as
select
    o.ord_no AS order_number,
    o.purch_amt AS purchase_amount,
    o.ord_date AS order_date,
    c.cust_name AS customer_name,
    s.name AS salesman_name
from
    orders o
join
    customer c on o.customer_id = c.customer_id
join
    salesman s on o.salesman_id = s.salesman_id;

grant all privileges  on order_details to junior_dev;

-- 6 --
CREATE VIEW highest_grade_customers AS
SELECT
    customer_id,
    cust_name,
    city,
    grade,
    salesman_id
FROM
    customer
WHERE
    grade = (SELECT MAX(grade) FROM customer);

GRANT SELECT ON highest_grade_customers TO junior_dev;

-- 7 --
create view number_of_salesman as
select
    city,
    count(salesman_id)
from salesman
group by city;

-- 8 --
create view greater_than_one as
select
    s.salesman_id,
    s.name,
    s.city,
    s.commission
from salesman s
join customer c on s.salesman_id = c.salesman_id
group by s.salesman_id, s.name, s.city, s.commission
having count(c.customer_id) > 1;

-- 9 --
create role intern;
grant junior_dev to intern;
