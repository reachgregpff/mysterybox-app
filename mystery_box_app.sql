CREATE DATABASE mysterybox;

\c mysterybox

CREATE TABLE users
(
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(200),
  password_digest VARCHAR(200)
);


/*CREATE TABLE recipes 
(
  recipe_id INTEGER PRIMARY KEY NOT NULL,
  username VARCHAR(200),
  title VARCHAR(500),
  social_rank VARCHAR(500),
  image_url VARCHAR(100),
  ingredients VARCHAR(5000),
  publisher VARCHAR(500),
  source_url VARCHAR(500)
);*/

CREATE TABLE recipes 
(
  recipe_id INTEGER PRIMARY KEY,
  username VARCHAR(200) NOT NULL,
  recipe VARCHAR(12000)
);

