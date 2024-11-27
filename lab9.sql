CREATE DATABASE lab9;
DROP TABLE employees;
CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department INT,
    salary REAL
);
INSERT INTO employees (first_name, last_name, department, salary) VALUES
    ('John', 'Doe', 1, 55000.00),
    ('Jane', 'Smith', 2, 62000.00),
    ('Alice', 'Johnson', 3, 48000.00),
    ('Bob', 'Brown', 1, 51000.00),
    ('Charlie', 'Davis', 2, 75000.00),
    ('Emily', 'White', 3, 46000.00),
    ('Frank', 'Thomas', 1, 57000.00),
    ('Grace', 'Clark', 2, 63000.00),
    ('Hank', 'Wilson', 3, 49000.00),
    ('Ivy', 'Taylor', 1, 54000.00);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price REAL NOT NULL
);
INSERT INTO products (product_name, category, price) VALUES
    ('Laptop', 'Electronics', 899.99),
    ('Smartphone', 'Electronics', 699.99),
    ('Desk Chair', 'Furniture', 119.99),
    ('Office Desk', 'Furniture', 229.99),
    ('Refrigerator', 'Appliances', 1099.99),
    ('Microwave Oven', 'Appliances', 199.99),
    ('Running Shoes', 'Footwear', 79.99),
    ('Winter Coat', 'Clothing', 129.99),
    ('Bluetooth Headphones', 'Accessories', 149.99),
    ('Yoga Mat', 'Fitness', 25.99);
--1
CREATE FUNCTION increase_value(INOUT value INTEGER)
AS
$$
BEGIN
    value = value + 10;
END;
$$
LANGUAGE plpgsql;

--SELECT increase_value(4);

--2
CREATE OR REPLACE FUNCTION compare_numbers(val1 INTEGER, val2 INTEGER, OUT res VARCHAR)
AS
    $$
    BEGIN
        IF(val1 = val2)
            THEN res = 'Equal';
        ELSIF ( val1 < val2)
            THEN res = 'val1 is lesser';
        ELSE
            res = 'val1 is greater';
        END IF;
    END;
    $$
LANGUAGE plpgsql;

--SELECT compare_numbers(1, 5);

--3
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER)
AS
    $$
    BEGIN
        series = 1;
        WHILE series<=n LOOP
            RETURN QUERY SELECT series;
            series = series + 1;
            END LOOP ;
    END;
    $$
LANGUAGE plpgsql;

--SELECT number_series(5);

--4
CREATE OR REPLACE FUNCTION find_employee(name VARCHAR)
RETURNS TABLE
        (
            employee_id INT,
            first_name  VARCHAR(50),
            last_name   VARCHAR(50),
            department  INT,
            salary REAL
        )
AS
    $$
    BEGIN
        RETURN QUERY SELECT * FROM employees e WHERE e.first_name = name;
    END;
    $$
LANGUAGE plpgsql;

--SELECT * FROM find_employee('John');

--5
CREATE OR REPLACE FUNCTION list_products(prod_category VARCHAR)
RETURNS TABLE (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50) ,
    price REAL
              )
AS
    $$
    BEGIN
        RETURN QUERY SELECT * FROM products p WHERE p.category = prod_category;
    END;
    $$
LANGUAGE plpgsql;

--SELECT * FROM list_products('Clothing');

--6
CREATE OR REPLACE FUNCTION calculate_bonus(name VARCHAR)
RETURNS INT
AS
    $$
    DECLARE
        bonus INT;
    BEGIN
        SELECT salary * 0.1 INTO bonus FROM employees e WHERE e.first_name = name;
        RETURN bonus;
    END;
    $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(name VARCHAR)
RETURNS VOID
AS
    $$
    BEGIN
        UPDATE employees e
        SET salary = e.salary + calculate_bonus(name)
        WHERE e.first_name = name;
    END;
    $$
LANGUAGE plpgsql;

SELECT calculate_bonus('John');
SELECT update_salary('John');
SELECT * FROM employees  WHERE first_name = 'John';

--7
CREATE OR REPLACE PROCEDURE complex_calculation(val1 INT, val2 VARCHAR)
AS
    $$
    <<outer_block>>
        DECLARE
            biggest INT;
            lowest INT;
            isPal VARCHAR;
    BEGIN
        <<inner1>>
            DECLARE
                i INT = 1;
        BEGIN
            FOR i in 1..floor(sqrt(val1)) LOOP
                IF(i = 1)
                THEN
                    biggest = i;
                    lowest = val1 /i;
                END IF;

                IF val1 % i = 0 THEN
                    RAISE NOTICE 'Factors of % are % %', val1, i , val1 /i;
                END IF;
            END LOOP;
        END inner1;
        <<inner2>>
            DECLARE
                rev_str VARCHAR;
            BEGIN
                rev_str = reverse(val2);
                IF val2 = rev_str
                    THEN
                        isPal = '% is palindrome!';
                ELSE
                    isPal = '% is NOT palindrome!';
                END IF;
        END inner2;
        RAISE NOTICE 'Biggest and lowest factors of % arE % and % .Is '' % '' palindrome? % ',val1,biggest,lowest,val2,isPal;
    END outer_block;

    $$
LANGUAGE plpgsql;

CALL complex_calculation(8, 'alaL');