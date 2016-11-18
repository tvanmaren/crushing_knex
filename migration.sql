DROP DATABASE IF EXISTS musical_taste;
CREATE DATABASE musical_taste;

\c musical_taste;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS genre;

CREATE TABLE genre (
  id serial PRIMARY KEY NOT NULL,
  name VARCHAR(10),
  description TEXT
);

CREATE TABLE artist (
  id serial PRIMARY KEY NOT NULL,
  name VARCHAR(15),
  genre_id INT REFERENCES genre(id)
);

CREATE TABLE song (
  id serial PRIMARY KEY NOT NULL,
  title TEXT,
  length INTERVAL(0),
  genre_id INT REFERENCES genre(id),
  artist_id INT REFERENCES artist(id),
  year INT
);

CREATE TABLE users (
  id serial PRIMARY KEY NOT NULL,
  name VARCHAR(15),
  preferences TEXT
);

CREATE TABLE ratings (
  song_id INT REFERENCES song(id),
  user_id INT REFERENCES users(id),
  rating INT
);
