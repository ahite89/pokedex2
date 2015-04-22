DROP TABLE IF EXISTS types, evolutions, moves, pokemon

CREATE TABLE pokemon (
  id serial PRIMARY KEY,
  name varchar(255) NOT NULL,
  national_id integer NOT NULL,
  catch_rate integer NOT NULL,
  hp integer NOT NULL,
  attack integer NOT NULL,
  defense integer NOT NULL,
  sp_atk integer NOT NULL,
  sp_def integer NOT NULL,
  speed integer NOT NULL
  height varchar(255) NOT NULL,
  weight varchar(255) NOT NULL
);

CREATE TABLE moves (
  id serial FOREIGN KEY,
  name varchar(255) NOT NULL
  learn_type varchar(255) NOT NULL,
  level integer NOT NULL
);

CREATE TABLE evolutions (
  id serial FOREIGN KEY,
  level integer NOT NULL,
  method varchar(255) NOT NULL,
  to varchar(255) NOT NULL
);

CREATE TABLE types (
  id serial FOREIGN KEY,
  name varchar(255) NOT NULL
);
