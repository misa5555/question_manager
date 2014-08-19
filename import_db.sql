CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255)  NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255)  NOT NULL
);

CREATE TABLE question_followers(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_reply_id INTEGER,
  user_id INTEGER,
  body VARCHAR(255)  NOT NULL
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER
);

INSERT INTO 
  users ("fname", "lname") 
VALUES 
  ("Michael", "Jackson"), ("Bill", "Clinton"), ("Bill", "Nye");
  
INSERT INTO
  questions ("title", "body")
VALUES
  ("Wealth", "How can I get rich?"), ("AppAcademy", "How do I finish all the work in time?");
