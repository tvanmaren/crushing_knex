\c musical_taste;

\set SID 'CURRVAL(''song_id_seq'')'
-- \set AID CURRVAL('''artist_id_seq''')--need to restructure to use this
\set UID 'CURRVAL(''users_id_seq'')'

INSERT INTO genre (id,name)
VALUES ('PPRK','Pop Rock'),
('PERK','Progressive Rock'),
('AERK','Alternative Rock'),
('SHRK', 'Synth Rock'),
('ATRK','Art Rock'),
('GMRK','Glam Rock'),
('WD','World'),
('NWAE','New Age'),
('FK','Folk'),
('CC','Celtic'),
('GE','Grunge'),
('PTGE','Post-Grunge'),
('EL','Experimental'),
('AT','Ambient'),
('EC','Electronic'),
('TO','Techno'),
('IDM','IDM'),
('TE','Trance'),
('HE','House');

INSERT INTO artist (id,name)
VALUES ('ACSS','Afro Celt Sound System'),
('BNTU','Brian Transeau'),
('JNHS','Jon Hopkins'),
('MUSE','Muse'),
('PRGL','Peter Gabriel');

INSERT INTO artist_genres (artist_id, genre_id)
VALUES ('MUSE','SHRK'),
('MUSE','GMRK'),
('MUSE','AERK'),
('ACSS','CC'),
('ACSS','WD'),
('ACSS','NWAE'),
('BNTU','EC'),
('BNTU','TO'),
('BNTU','TE'),
('JNHS','AT'),
('JNHS','EL'),
('JNHS','EC'),
('PRGL','WD'),
('PRGL','ATRK'),
('PRGL','AERK');

INSERT INTO song (title, length, year)
VALUES ('Dead Inside','1 min 30 secs',2015);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'AERK'), (:SID,'SHRK');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'MUSE');

INSERT INTO song (title, length, year)
VALUES ('Uprising','5 min 03 secs',2015);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'GMRK');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'MUSE');

INSERT INTO song (title, length, year)
VALUES ('Games Without Frontiers','4 min 05 secs',1979);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'PERK');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'PRGL');

INSERT INTO song (title, length, year)
VALUES ('When You''re Falling','5 min 14 secs',2001);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'WD');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'ACSS');

INSERT INTO song (title, length, year)
VALUES ('The Light in Things','10 min 47 secs',2010);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'TE');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'BNTU');

INSERT INTO song (title, length, year)
VALUES ('Light Through the Veins','9 min 21 secs',2009);
INSERT INTO song_genres (song_id, genre_id)
VALUES (:SID,'EC'), (:SID,'AT');
INSERT INTO artist_songs (song_id, artist_id)
VALUES (:SID,'JNHS');

-- Fake user data

INSERT INTO users (name)
VALUES ('Sid Meier'), ('Sid Vicious'), ('El Cid'), ('Sidney Applebaum'), ('A Boy Named Sue'), ('Franz Kafka'), ('Friedrich Nietzsche'), ('Saint John of the Field of the Stars');

-- Simulation of user feedback

DROP FUNCTION IF EXISTS addRating (IN uID INT,IN sTITLE TEXT,IN rating INT, OUT result RECORD);

CREATE FUNCTION addRating (IN uID INT,IN sTITLE TEXT,IN rating INT, OUT result RECORD)
AS 'INSERT INTO ratings (user_id, song_id, rating) VALUES ($1, (SELECT id FROM song WHERE title=$2), $3) RETURNING (user_id,song_id,rating);'
LANGUAGE SQL;

\set UID '(SELECT id FROM users WHERE name=''Franz Kafka'')'

SELECT addRating(:UID,'Light Through the Veins',5);

SELECT addRating(:UID,'The Light in Things',7);

SELECT addRating(:UID,'When You''re Falling',8);

SELECT addRating(:UID,'Games Without Frontiers',8);

SELECT addRating(:UID,'Uprising',9);

SELECT addRating(:UID,'Dead Inside',10);
