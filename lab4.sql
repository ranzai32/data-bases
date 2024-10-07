CREATE DATABASE lab4;
CREATE TABLE Warehouse(
    code INTEGER,
    location VARCHAR(255),
    capacity INT
);

CREATE TABLE Boxes(
    code CHAR(4),
    contents VARCHAR(255),
    value REAL,
    warehouse INT
);

INSERT INTO Warehouse VALUES  (1, 'Chicago', 3),
                              (2, 'Chicago', 4),
                              (3, 'New York', 7),
                              (4, 'Los Angeles', 2),
                              (5, 'San Francisco', 8);

INSERT INTO Boxes VALUES ('0MN7', 'Rocks', 180, 3),
                         ('4H8P', 'Rocks', 250, 1),
                         ('4RT3', 'Scissors', 190, 4),
                         ('7G3H', 'Rocks', 200, 1),
                         ('8JN6', 'Papers', 75, 1),
                         ('8Y6U', 'Papers', 50, 3),
                         ('9J6F', 'Papers', 175, 2),
                         ('LL08', 'Rocks', 140, 4),
                         ('P0H6', 'Scissors', 125,1),
                         ('P2T6', 'Scissors', 150, 2),
                         ('TU55', 'Papers', 90, 1);

-- 4 task --
SELECT * FROM Warehouse;

-- 5 task --
SELECT * FROM Boxes WHERE value > 150;

-- 6 task --
SELECT DISTINCT ON (contents) * FROM Boxes;

-- 7 task --
SELECT warehouse, COUNT(*)
    FROM Boxes
        GROUP BY warehouse ORDER BY warehouse DESC;

-- 8 task --
SELECT warehouse, COUNT(*) AS box_count
    FROM Boxes
    GROUP BY warehouse
    HAVING COUNT(*) > 2
    ORDER BY warehouse DESC;

-- 9 task --
INSERT INTO Warehouse VALUES (6, 'New York', 3);

-- 10 task --
INSERT INTO Boxes VALUES ('H5RT', 'Papers', 200, 2);

-- 11 task --
UPDATE Boxes
SET value = value * 0.85
WHERE code = (
    SELECT code
    FROM Boxes
    ORDER BY value DESC
    LIMIT 1
    OFFSET 3
);

-- 12 task --
DELETE FROM Boxes WHERE value < 150;

-- 13 task --

DELETE FROM Boxes
WHERE warehouse IN (
    SELECT code
    FROM Warehouse
    WHERE location = 'New York'
)
RETURNING *;

















