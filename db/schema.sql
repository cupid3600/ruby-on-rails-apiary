
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
CREATE INDEX goals_slug ON goals(slug);

/*codes*/
CREATE TABLE codes
(
id serial PRIMARY KEY,
user_id int NOT NULL,
code VARCHAR (4) NOT NULL,
expires_at TIMESTAMP NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP NULL,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO goals (slug, title, created_at) VALUES
('advice', 'Advice', NOW()),
('encouragement', 'Encouragement', NOW()),
('share_my_story', 'Share my story', NOW()),
('help_someone', 'Help someone', NOW());


/*Populate data in constellations*/
INSERT INTO constellations (name, icon, created_at, updated_at)
VALUES
 ('mental health', 'cancer__2_.png', now(), now()),
 ('wellness', 'cancer__2_.png', now(), now());

/*Update is_deleted in constellations*/
UPDATE constellations SET is_deleted=true WHERE id in (4,5,6,7,10,12,15,16);

/*Populate data in planets*/
INSERT INTO planets (title, is_approved, constellation_id, created_at, updated_at)
VALUES
('Anxiety', true, 18, now(), now()),
('Depression', true, 18, now(), now()),
('Bipolar disorder', true, 18, now(), now()),
('Self-Esteem', true, 18, now(), now()),
('OCD', true, 18, now(), now()),
('Breast', true, 17, now(), now()),
('Lymphoma', true, 17, now(), now()),
('Prostate', true, 17, now(), now()),
('Skin', true, 17, now(), now()),
('Treatment (chemo, radiation, surgery)', true, 17, now(), now()),
('Body Image', true, 17, now(), now()),
('Victim-related trauma', true, 11, now(), now()),
('Disaster trauma', true, 11, now(), now()),
('Violence-related trauma', true, 11, now(), now()),
('Survivors’ Guilt', true, 11, now(), now()),
('Not otherwise specified', true, 11, now(), now()),
('Coming out', true, 8, now(), now()),
('Dealing with Attraction', true, 8, now(), now()),
('Familial Acceptance', true, 8, now(), now()),
('Societal Pressure', true, 8, now(), now()),
('Transgender', true, 8, now(), now()),
('Gay', true, 8, now(), now()),
('Lesbian', true, 8, now(), now()),
('Bisexual', true, 8, now(), now()),
('Questioning', true, 8, now(), now()),
('Alcohol', true, 1, now(), now()),
('Depressants', true, 1, now(), now()),
('Stimulants', true, 1, now(), now()),
('Sex', true, 1, now(), now()),
('Eating', true, 1, now(), now());