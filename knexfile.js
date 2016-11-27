'use strict';
module.exports={
  development: {
    client: 'pg',
    connection: 'postgres://localhost/musical_taste',
    searchPath: 'knex,public'
  }
};
