'use strict';

const
  kError
 = require('./index.js').kError;

const env = 'development';
const config = require('./knexfile.js')[env];
const knex = require('knex')(config);

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

exports.queryKnex = function (table, constraints = {}) {
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
};

exports.joinKnex = function (table1, joinTable, table2, constraints = {}) {
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
};

exports.knex = knex;
