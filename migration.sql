DROP DATABASE IF EXISTS musical_taste;
CREATE DATABASE musical_taste;

\c musical_taste;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS genre;

CREATE TABLE genre (
  id VARCHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  description TEXT
);

CREATE TABLE artist (
  id CHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  genre_id VARCHAR(4) REFERENCES genre(id) ON DELETE CASCADE
);

CREATE TABLE song (
  id VARCHAR(6) PRIMARY KEY NOT NULL,
  title TEXT,
  length INTERVAL(0),
  genre_id VARCHAR(4) REFERENCES genre(id) ON DELETE CASCADE,
  artist_id CHAR(4) REFERENCES artist(id) ON DELETE CASCADE,
  year INT
);

CREATE TABLE users (
  id CHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  preferences TEXT
);

CREATE TABLE ratings (
  song_id VARCHAR(4) REFERENCES song(id) ON DELETE CASCADE,
  user_id CHAR(4) REFERENCES users(id) ON DELETE CASCADE,
  rating INT
);
