CREATE DATABASE lab10;

\c lab10

CREATE SCHEMA my_schema;

SET search_path TO my_schema;

CREATE TABLE books(
    book_id INT PRIMARY KEY,
    title VARCHAR,
    author VARCHAR,
    price DECIMAL,
    quantity INT
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    book_id INT REFERENCES books(book_id),
    customer_id INT,
    order_date DATE,
    quantity INT
);

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    name VARCHAR,
    email VARCHAR
);


INSERT INTO books (book_id, title, author, price, quantity)
VALUES
    (1, 'Database 101', 'A. Smith', 40.00, 10),
    (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
    (3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO customers (customer_id, name, email)
VALUES
    (101, 'John Doe', 'johndoe@example.com'),
    (102, 'Jane Doe', 'janedoe@example.com');

-- 1
BEGIN;
INSERT INTO orders VALUES (1, 1, 101, NOW(), 2);
UPDATE books SET quantity = quantity - 2 WHERE book_id = 1;
COMMIT;

-- SELECT * FROM orders;
-- SELECT * FROM books;

-- 2
DO
$$
DECLARE
    book_quantity INT;
BEGIN
    SELECT quantity INTO book_quantity FROM books WHERE book_id = 3;

    IF book_quantity < 10 THEN
        ROLLBACK;
    ELSE
        INSERT INTO orders VALUES
            (2,3,102,now(),10);
        UPDATE books SET quantity = quantity - 10 WHERE book_id = 3;
        COMMIT;
    END IF;
END
$$;
-- 3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE books SET price = 70
WHERE book_id = 1;

-- BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- SELECT price FROM books WHERE book_id = 1;
-- 40

COMMIT;

--SELECT price FROM books WHERE book_id = 1;
--70

-- 4

BEGIN ;
SELECT * FROM customers;
UPDATE customers SET email = 'qwerty@example.com'
WHERE customer_id = 102;
COMMIT;
SELECT * FROM Customers WHERE customer_id = 102;

/*net stop postgresql-x64-16.4
net start postgresql-x64-16.4*/

-- SELECT version();

SELECT * FROM Customers WHERE customer_id = 102;

