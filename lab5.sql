create database lab5;

create table customers(
    customer_id int primary key,
    cust_name varchar(80),
    city varchar(80),
    grade integer,
    salesman_id integer
);

alter table customers alter column grade set default 0;
create table orders(
    ord_no int primary key,
    purch_amt decimal(10,2),
    ord_date date,
    customer_id int,
    salesman_id int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (salesman_id) references salesmans(salesman_id)
);

create table salesmans(
    salesman_id int primary key,
    name varchar(80),
    city varchar(80),
    commission decimal(10,2)
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3002, 5002),
(70009, 270.65, '2012-09-10', 3005, 5005),
(70002, 65.26, '2012-10-05', 3001, 5001),
(70004, 110.50, '2012-08-17', 3007, 5001),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3009, 5003),
(70008, 5760, '2012-09-10', 3002, 5001);

INSERT INTO salesmans (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- 3 --
select sum(purch_amt) from orders;

-- 4 --
select avg(purch_amt) from orders;

-- 5 --
select count(cust_name) from customers;

-- 6 --
select min(purch_amt) from orders;

-- 7 --
select *
from customers
where cust_name like '%b'
and city is not null
and grade is not null
and salesman_id is not null;

-- 8 --
select * from orders where customer_id in(
    select customer_id from customers where city = 'New York');

-- 9 --
select * from customers where cust_name is not null and city
    is not null and grade
        is not null and salesman_id
            is not null and customer_id in(
    select customer_id from orders where purch_amt > 100
    );

-- 10 --
select sum(grade) as total_grade from customers;

-- 11 --
select * from customers where cust_name is not null;

-- 12 --
select max(grade) from customers;
