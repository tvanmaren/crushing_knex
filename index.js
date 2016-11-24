'use strict';

const env='development';
const config=require('./knexfile.js');
const knex=require('knex')(config);

const sql=knex('artist');

sql.then((result)=>{
  console.log(result);
  knex.destroy();
});

sql.catch((err)=>{
  console.error(err);
  knex.destroy();
  process.exit(1);
});
