
/*Queries to create Tables*/
/*planets*/
CREATE TABLE planets
(
id serial PRIMARY KEY,
title VARCHAR (255) NOT NULL,
icon VARCHAR (100) NULL,
constellation_id int NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NULL,
is_approved BOOLEAN NOT NULL DEFAULT FALSE,
is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
FOREIGN KEY (constellation_id) REFERENCES constellations(id) ON DELETE CASCADE
);

/*interests_planets*/
CREATE TABLE interests_planets
(
id serial PRIMARY KEY,
planet_id int NOT NULL,
user_id int NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NULL,
FOREIGN KEY (planet_id) REFERENCES planets(id) ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

/*interests_constellations*/
CREATE TABLE interests_constellations
(
id serial PRIMARY KEY,
constellation_id int NOT NULL,
user_id int NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NULL,
FOREIGN KEY (constellation_id) REFERENCES constellations(id) ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
/*goals*/
CREATE TABLE goals
(
id serial PRIMARY KEY,
slug VARCHAR (255) NOT NULL UNIQUE,
title VARCHAR (255) NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NULL,
is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

/*Set Index Slug on goals Table*/
CREATE INDEX slug ON goals