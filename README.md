# Crushing Knex.js

## Objectives

- Create an ERD for a set of resources of your choosing.
- Create a migration file to manage creating and dropping tables in your database (DDL).
- Create a seed file to manage rows in your database (DML).
- Use Knex.js to select, insert, update & delete data your database.

##Step 1: Brainstorm

Think about a topic that is interesting to you. What data might you collect and store in a publicly-accessible database that relates to that particular topic?

**Example:** Perhaps you are interested in trail running, and wish there was a database where runners could share comments about current trail conditions. The data that might need to be stored includes:
- runner name
- trail name
- trail description
- trail length
- trail elevation
- trail conditions
- date/time the trail condition was posted

##Step 2: Create an ERD

Analyze the relationships (one-to-one, one-to-many, or many-to-many) between the pieces of information that will be stored in your database, and create an ERD that visualizes these relationships.

**Example:** The information listed in the previous step might be best organized into three tables: *trails*, *runners*, and *conditions*, with the following relationships:

- One trail could have many conditions
- One runner might post many conditions
- A trail condition can be connected to only one trail
- A trail condition can have only runner who posted it
- No direct relationship between trails and runners exists

***** post image of ERD here *****

##Step 3: Create a migration file

Remember that a migration is a file that contains SQL commands that are used to create and re-create the tables in a database on demand. Reference the [Intro to SQL]('https://github.com/gSchool/sql-curriculum/blob/master/SQL%20Intro.md') article to remind yourself what to place in this file, and how to run it so that the tables are created in your database.

**Example:** Following is the command that creates the trails table in the example database:

```
CREATE TABLE trails (
  id serial,
  name text,
  description text,
  length numeric(3,2),
  elevation_gain integer
);
```

**TIP:** One of the challenges of building out a database is choosing the correct data type for each piece of information you're storing.

**TIP:** Don't forget to create your database before you run your migration file.

##Step 4: Create a seed file

Remember that a seed file contains SQL commands that are used to create and re-create the rows in a table on demand. Reference the Intro to SQL article to remind yourself what to place in this file, and how to run it so that the tables are filled with some data.

**Example:** Following is a command that creates a row in the trails table:

```
INSERT INTO trails (name, description, length, elevation_gain) VALUES ('Mount Sanitas Trail', 'This trail will make your quads scream.', 3.3, 1354);
```

##Step 5: Hook it up to Knex.js

Remember that Knex.js is a third-party JavaScript library that builds SQL commands and sends them to a relational database system. Knex.js allows you to build a Node.js-based PostgreSQL client that communicates with a PostgreSQL server. Reference the [Knex.JS article]('https://github.com/gSchool/node-curriculum/blob/master/Knex/README.md') to set up a Node.js project that connects to the database you just created.

**HINT:** Remember that there are a couple npm packages that will be essential to install.


##Step 6: Query the sh*t out of your database

Write out some queries using Knex.js that allow you to do the following:
- select rows from a PostgreSQL table.
- insert rows into a PostgreSQL table.
- update rows in a PostgreSQL table.
- delete rows from a PostgreSQL table.

**Challenge yourself** by creating some complex queries! Reference the Knex.js documentation a lot; familiarizing yourself with these docs now will save you lots of time (and pain!) in the near future :)

If you'd like feedback on your work, submit it to the assignment **Crushing_Knex**.
