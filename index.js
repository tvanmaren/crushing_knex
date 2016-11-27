'use strict';

const nameDict = {
  'genre': 'name',
  'artist': 'name',
  'song': 'title',
  'users': 'name'
};

const idDict = {
  'genre': 'genre_id',
  'artist': 'artist_id',
  'song': 'song_id',
  'users': 'user_id'
};

const express = require('express');
const app = express();

const env = 'development';
const config = require('./knexfile.js')[env];
const knex = require('knex')(config);

app.use(express.static('public'));

function kError(err) {
  console.error(err);
  knex.destroy();
  process.exit(1);
}

function cleanQuery(query) {
  for (let key in query) {
    let front=query[key][0];
    let end=query[key].slice(-1);
    console.log('front:',front,'end',end);
    if (front==='\'' || front==='\"') {
      query[key]=query[key].slice(1);
    }
    if (end==='\'' || end==='\"') {
      query[key]=query[key].slice(0,-1);
    }
  }
  return query;
}

function queryKnex(table, constraints = {}) {
  let sql = [];
  for (let column in constraints) {
    console.log('column', column, '\nconstraint:', constraints[column]);
    sql.push(
      knex(table).where(`${table}.${column}`, constraints[column])
      .then((result) => {
        // knex.destroy();
        return result;
      })
      .catch(kError)
    );
  }
  return Promise.all(sql);
}

function queryMultipleKnex(table1, joinTable, table2, constraints = {}) {
  let sql = [];
  for (let column in constraints) {
    sql.push(
      knex(table1).join(joinTable, `${joinTable}.${idDict[table1]}`, `${table1}.id`).join(table2, `${table2}.id`, `${joinTable}.${idDict[table2]}`).where(`${table2}.${nameDict[column]}`, constraints[column])
      .then((result) => {
        // knex.destroy();
        return result;
      })
      .catch(kError)
    );
  }
  console.log('all promises:', sql);
  return Promise.all(sql);
}

function parseQuery(source, query) {
  console.log('dirty query',query);
  query = cleanQuery(query);
  console.log('clean query:',query);
  for (let key in query) {
    switch (source) {
    case ('song'):
      {
        if (key === 'genre') {
          return queryMultipleKnex(source, 'song_genres', query);
        }
        if (key === 'artist') {
          return queryMultipleKnex(source, 'artist_songs', 'artist', query);
        }
        break;
      }
    case ('artist'):
      {
        if (key === 'genre') {
          return queryMultipleKnex(source, 'artist_genres', 'genre', query);
        }
        if (key === 'song') {
          return queryMultipleKnex(source, 'artist_songs', 'song', query);
        }
        break;
      }
    case ('genre'):
      {
        if (key === 'song') {
          return queryMultipleKnex(source, 'song_genres', 'song', query);
        }
        if (key === 'artist') {
          return queryMultipleKnex(source, 'artist_genres', 'artist', query);
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
}

function genre(req, res) {
  var query = req.query;
  let answer = parseQuery('genre', query)
    .then((found) => {
      res.send(found);
    })
    .catch(kError);
  console.log(answer);
}

function artist(req, res) {
  var query = req.query;
  let answer = parseQuery('artist', query)
    .then((found) => {
      res.send(found);
    })
    .catch(kError);
  console.log(answer);
}

function song(req, res) {
  var query = req.query;
  console.log('query:', query);
  let answer = parseQuery('song', query)
    .then((found) => {
      console.log('found', found);
      res.send(found);
    })
    .catch(kError);
  console.log(answer);
}

function user(req, res) {
  var query = req.query;
  let answer = parseQuery('users', query)
    .then((found) => {
      res.send(found);
    })
    .catch(kError);
  console.log(answer);
}

function test(req, res) {
  let answer = parseQuery('users')
    .then((found) => {
      res.send(found);
    })
    .catch(kError);
  console.log(answer);
}

app.get('/genre/', genre);
app.get('/artist/', artist);
app.get('/song/', song);
app.get('/user/', user);
app.get('/test/', test);

app.listen(8000, () => {
  console.log('listening at port 8000');
});
