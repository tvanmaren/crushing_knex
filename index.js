'use strict';

const {
  parseQuery,
  cleanQuery
} = require('./queryHandlers.js');

const {
  nameDict,
  idDict,
  queryKnex,
  joinKnex
} = require('./knexUses.js');

const express = require('express');
const app = express();

app.use(express.static('public'));

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

function kError(err) {
  console.error(err);
  // knex.destroy();
  process.exit(1);
}
