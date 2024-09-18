CREATE DATABASE lab_1;

CREATE TABLE IF NOT EXISTS users(
    id_user   SERIAL,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50)
);


ALTER TABLE users
    ADD COLUMN isadmin INTEGER
        CHECK(isadmin = 1 or isadmin = 0);



ALTER TABLE users ALTER COLUMN isadmin TYPE boolean
USING CASE
    WHEN isadmin = 1 THEN TRUE
    WHEN isadmin = 0 THEN FALSE
END;


ALTER TABLE users
    ALTER COLUMN isadmin SET default FALSE;


ALTER TABLE users
    ADD CONSTRAINT pk_id PRIMARY KEY (id_user);


CREATE TABLE tasks(
    id    SERIAL,
    name  VARCHAR(50),
    user_id SERIAL REFERENCES users(id_user)
);

DROP TABLE tasks;

DROP DATABASE IF EXISTS lab_1;


