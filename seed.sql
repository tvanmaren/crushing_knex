\c musical_taste;

INSERT INTO genre (id,name)
VALUES ('POPR','Pop/Rock'),
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

INSERT INTO song (id, title, length, year)
VALUES ('DDIE','Dead Inside','1 min 30 secs',2015);

INSERT INTO artist_songs (artist_id, song_id)
VALUES ('MUSE','DDIE');

INSERT INTO song_genres (song_id, genre_id)
VALUES ('DDIE','AERK'),
('DDIE','SHRK');

INSERT INTO artist_genres (artist_id, genre_id)
VALUES ('MUSE','SHRK'),
('MUSE','GMRK'),
('MUSE','AERK');
