'use strict';

const express = require('express');
const app = express();

const env = 'development';
const config = require('./knexfile.js')[env];
const knex = require('knex')(config);

app.use(express.static('public'));

function queryKnex(table, constraints = {}) {
  for (let column in constraints) {
    let sql = knex(table).where(`${table}.${column}`, constraints[column])
      .then((sqlRes) => {
        knex.destroy();
        return sqlRes;
      })
      .catch((err) => {
        console.error(err);
        knex.destroy();
        process.exit(1);
      });
    return sql;
  }
}

function genre(req, res) {
  var query = req.query;
  let answer = queryKnex('genre', query);
  answer.then((found) => {
    res.send(found);})
    .catch((err)=>{
      console.error(err);
      process.exit(1);
    });
}

function artist(req,res) {
  var query = req.query;
  let answer = queryKnex('artist', query);
  answer.then((found) => {
    res.send(found);})
    .catch((err)=>{
      console.error(err);
      process.exit(1);
    });
}

function song(req,res) {
  var query = req.query;
  console.log('query:',query);
  let answer = queryKnex('song', query);
  answer.then((found) => {
    res.send(found);})
    .catch((err)=>{
      console.error(err);
      process.exit(1);
    });
}

function user(req,res) {
  var query = req.query;
  let answer = queryKnex('users', query);
  answer.then((found) => {
    res.send(found);})
    .catch((err)=>{
      console.error(err);
      process.exit(1);
    });
}

app.get('/genre/', genre);
app.get('/artist/', artist);
app.get('/song/', song);
app.get('/user/', user);

app.listen(8000, () => {
  console.log('listening at port 8000');
});
