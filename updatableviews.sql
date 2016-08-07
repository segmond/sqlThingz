// https://www.postgresql.org/docs/9.5/static/sql-createview.html

CREATE TABLE movies.films (
	id bigserial PRIMARY KEY,
	title character varying NOT NULL,
	kind character varying NOT NULL,
	classification character varying NOT NULL,
	country_code character varying(5) NOT NULL	
);

INSERT INTO movies.films (kind, classification, country_code)
VALUES 
('Liar Liar', 'Comedy', 'PG', 'USA'),
('Tarzan', 'Cartoon', 'G', 'USA'),
('Natural Born Killers', 'Drama', 'R', 'USA'),
('Kung Fu Panda', 'Cartoon', 'G', 'USA'),
('Le Erotica', 'Adult', 'XXX', 'FR'),
('Drunken Master', 'Kung Fu', 'R', 'CHINA');

CREATE VIEW movies.cartoons AS
	SELECT * from movies.films
	WHERE kind = 'Cartoon';

CREATE VIEW movies.cartoons2 AS
        SELECT * from movies.film
        WHERE kind = 'Cartoon'
        WITH LOCAL CHECK OPTION;

CREATE VIEW movies.universal_cartoons AS
        SELECT * from movies.cartoons
        WHERE classification = 'G'
        WITH LOCAL CHECK OPTION;

CREATE VIEW movies.pg_cartoons AS
        SELECT * from movies.cartoons
        WHERE classification = 'PG'
        WITH CASCADED CHECK OPTION;

select * from movies.films
select * from movies.cartoons2
-- these work :-)
update movies.cartoons set country_code = 'USA'
INSERT INTO movies.cartoons (title, kind, classification, country_code)
VALUES ('Toy Story', 'Action', 'G', 'USA')

-- this fails :-)
INSERT INTO movies.cartoons2 (title, kind, classification, country_code)
VALUES ('GI JOE', 'Action', 'PG', 'USA')

INSERT INTO movies.cartoons2 (title, kind, classification, country_code)
VALUES ('GI JOE', 'Cartoon', 'PG', 'USA')

-- inserts :-(
INSERT INTO movies.universal_cartoons (title, kind, classification, country_code)
VALUES ('Batman', 'Action', 'G', 'USA')

-- fails :-)
INSERT INTO movies.pg_cartoons (title, kind, classification, country_code)
VALUES ('Batman', 'Action', 'PG', 'USA')

-- fails :-)
INSERT INTO movies.pg_cartoons (title, kind, classification, country_code)
VALUES ('Batman', 'Cartoon', 'PG', 'USA')


