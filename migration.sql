DROP DATABASE IF EXISTS musical_taste;
CREATE DATABASE musical_taste;

\c musical_taste;

DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS artist_songs CASCADE;
DROP TABLE IF EXISTS song_genres CASCADE;
DROP TABLE IF EXISTS song CASCADE;
DROP TABLE IF EXISTS artist_genres CASCADE;
DROP TABLE IF EXISTS artist CASCADE;
DROP TABLE IF EXISTS genre CASCADE;

CREATE TABLE genre (
  id VARCHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  description TEXT
);

CREATE TABLE artist (
  id CHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  description TEXT
);

CREATE TABLE artist_genres (
  id serial PRIMARY KEY NOT NULL,
  artist_id VARCHAR(4) REFERENCES artist(id) ON DELETE CASCADE,
  genre_id VARCHAR(4) REFERENCES genre(id) ON DELETE CASCADE
);

CREATE TABLE song (
  id VARCHAR(6) PRIMARY KEY NOT NULL,
  title TEXT,
  length INTERVAL(0),
  year INT
);

CREATE TABLE artist_songs (
  id serial PRIMARY KEY NOT NULL,
  artist_id VARCHAR(4) REFERENCES artist(id) ON DELETE CASCADE,
  song_id VARCHAR(6) REFERENCES song(id) ON DELETE CASCADE
);

CREATE TABLE song_genres (
  id serial PRIMARY KEY NOT NULL,
  song_id VARCHAR(6) REFERENCES song(id) ON DELETE CASCADE,
  genre_id VARCHAR(4) REFERENCES genre(id) ON DELETE CASCADE
);

CREATE TABLE users (
  id CHAR(4) PRIMARY KEY NOT NULL,
  name VARCHAR(25),
  preferences TEXT
);

CREATE TABLE ratings (
  id serial PRIMARY KEY NOT NULL,
  song_id VARCHAR(4) REFERENCES song(id) ON DELETE CASCADE,
  user_id CHAR(4) REFERENCES users(id) ON DELETE CASCADE,
  rating INT
);
