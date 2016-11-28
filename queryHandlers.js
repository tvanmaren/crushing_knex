'use strict';

const {
  queryKnex,
  joinKnex
} = require('./knexUses.js');

exports.cleanQuery = function (query) {
  for (let key in query) {
    let front = query[key][0];
    let end = query[key].slice(-1);
    console.log('front:', front, 'end', end);
    if (front === '\'' || front === '\"') {
      query[key] = query[key].slice(1);
    }
    if (end === '\'' || end === '\"') {
      query[key] = query[key].slice(0, -1);
    }
  }
  return query;
};

exports.parseQuery = function (source, query) {
  console.log('dirty query', query);
  query = exports.cleanQuery(query);
  console.log('clean query:', query);
  for (let key in query) {
    switch (source) {
    case ('song'):
      {
        if (key === 'genre') {
          return joinKnex(source, 'song_genres', query);
        }
        if (key === 'artist') {
          return joinKnex(source, 'artist_songs', 'artist', query);
        }
        break;
      }
    case ('artist'):
      {
        if (key === 'genre') {
          return joinKnex(source, 'artist_genres', 'genre', query);
        }
        if (key === 'song') {
          return joinKnex(source, 'artist_songs', 'song', query);
        }
        break;
      }
    case ('genre'):
      {
        if (key === 'song') {
          return joinKnex(source, 'song_genres', 'song', query);
        }
        if (key === 'artist') {
          return joinKnex(source, 'artist_genres', 'artist', query);
        }
        break;
      }
    case ('users'):
      {
        break;
      }
    }
  }
  return queryKnex(source, query);
};
