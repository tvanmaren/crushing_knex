\c musical_taste;

INSERT INTO genre (id,name)
VALUES ('POPR','Pop/Rock'),
('PERK','Progressive Rock'),
('AERK','Alternative Rock'),
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

INSERT INTO song (id, title, artist_id, genre_id, length, year)
VALUES ('DDIE','Dead Inside','MUSE','POPR','1 min 30 secs',2015),
