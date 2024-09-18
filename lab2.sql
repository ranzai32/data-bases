CREATE DATABASE lab2;
CREATE TABLE countries(
    country_id SERIAL,
    country_name VARCHAR(85),
    region_id INTEGER,
    population INTEGER
);
ALTER TABLE countries ADD PRIMARY KEY (country_id);
INSERT INTO countries (country_name, region_id, population)
    VALUES ('Kazakhstan', 2, 18000000);

INSERT INTO countries (country_name)
    VALUES ( 'Japan');

INSERT INTO countries(country_name, region_id, population)
    VALUES
        ('Russia', 2, 180000000),
        ('China', 2, 1400000000),
        ('Kyrgyzstan', 3, 12000000);

ALTER TABLE countries
    ALTER COLUMN country_name SET default 'Kazakhstan';

ALTER TABLE countries
    ALTER COLUMN region_id SET  default 0;

ALTER TABLE countries
    ALTER COLUMN population SET default 0;

INSERT INTO countries(country_name)
    VALUES (DEFAULT);

INSERT INTO countries(country_name, region_id, population)
    VALUES (DEFAULT, DEFAULT, DEFAULT);

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

INSERT INTO countries_new (country_id, country_name, region_id, population)
    SELECT country_id, country_name, region_id, population
        FROM countries;

UPDATE countries_new
    SET region_id = 1
        WHERE region_id IS NULL;

SELECT country_name,
    population * 1.10 AS "New Population"
        FROM countries_new;

DELETE FROM countries
    WHERE population < 100000;

DELETE FROM countries_new
    WHERE country_id IN (SELECT country_id FROM countries)
        RETURNING *;

DELETE FROM countries
    RETURNING *;